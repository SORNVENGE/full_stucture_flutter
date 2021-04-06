/*
 * Copyright (c) 2020. Vyking.io. All rights reserved.
 */

package com.example.rare_pair

import android.app.Application
import android.content.Context
import android.opengl.Matrix
import android.util.Log
import android.view.Choreographer
import android.view.Surface
import android.view.SurfaceView
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.google.android.filament.*
import com.google.android.filament.android.UiHelper
import com.google.android.filament.utils.*
import io.vyking.vykingtracker.*
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.*
import java.io.File
import java.io.FileOutputStream
import java.nio.ByteBuffer
import java.nio.channels.Channels
import java.util.concurrent.ConcurrentHashMap
import kotlin.coroutines.resume
import io.vyking.vykingfilamentdemo.R

/**
 * An example ViewModel to handle the rendering and positioning of VykingAccessories using the Filament graphics engine and
 * the VykingTracker library.
 */
class VykingTrackingViewModel constructor(
        application: Application
) : AndroidViewModel(application) {
    private val tag: (String) -> String = { it -> "${this.javaClass.name}.$it" }

    private val engine: Engine = Engine.create()
    private var swapChain: SwapChain? = null
    private var surfaceView: SurfaceView? = null

    private val vykingTracker: VykingTrackerJNI = VykingTrackerJNI.getInstance()
    private val vykingImageTextures: VykingTrackerJNI.ImageTextures = vykingTracker.createImageTextures(engine)

    @Volatile
    private var viewDidChange: Boolean = false
        set(value) {
            synchronized(field) {
                field = value
            }
        }

    data class TrackingData(val id: Int = 0, val data: VykingTrackerJNI.TrackingData? = null, val viewDidChange: Boolean = false)

    private var trackingData: TrackingData? = null
    private val onVykingTrackerUpdate: VykingTrackerJNI.OnUpdateListener = VykingTrackerJNI.OnUpdateListener { frameId, frameData ->
        synchronized(viewDidChange) { trackingData = TrackingData(frameId, frameData.copy()) }
    }
    private val trackingDataFlow = flow {
        var data = TrackingData()
        synchronized(viewDidChange) {
            trackingData = trackingData?.let {
                data = it.copy(data = it.data?.copy(), viewDidChange = viewDidChange)
                viewDidChange = false
                null
            }
        }
        emit(data)
    }

    data class SurfaceMirror(val surface: Surface, val swapChain: SwapChain, val viewport: Viewport)

    private val surfaceMirrors: MutableList<SurfaceMirror> = ArrayList()

    private val choreographer: Choreographer = Choreographer.getInstance()
    private val frameScheduler = FrameCallback()
    private val renderer: Renderer = engine.createRenderer()
    private val uiHelper: UiHelper = UiHelper(UiHelper.ContextErrorPolicy.DONT_CHECK).apply {
        renderCallback = SurfaceCallback()
    }

    private val camera: Camera by lazy {
        engine.createCamera()
                .apply {
                    // Point camera down because we assume the user is pointing their phone down at their feet.
                    // The environmental lighting defaults to the sky being +Y
                    lookAt(
                            0.0, 0.0, 0.0,
                            0.0, -1.0, 0.0,
                            0.0, 0.0, -1.0
                    )
                    setExposure(kAperture, kShutterSpeed, kSensitivity)
                }
    }
    private val screen: VykingCameraScreen by lazy { VykingCameraScreen.getConstructor(getApplication(), engine, vykingImageTextures)() }
    private val lights: IntArray by lazy {
        intArrayOf(
                EntityManager.get().create()
                        .apply {
                            val direction = floatArrayOf(0.0f, -1.0f, 0.0f)
//                    val direction = floatArrayOf(0.0f, -1.0f, 0.0f).apply {
//                        indirectLight?.getDirectionEstimate(this)
//                    }
                            val colourAndIntensity = floatArrayOf(1.0f, 1.0f, 1.0f, 200.0f)
//                    val colourAndIntensity = floatArrayOf(0.8879232f, 0.6614058f, 0.5520116f, 200.0f).apply {
//                        indirectLight?.getColorEstimate(this, direction[0], direction[1], direction[2])
//                    }
                            LightManager.Builder(LightManager.Type.DIRECTIONAL)
                                    .color(colourAndIntensity[0], colourAndIntensity[1], colourAndIntensity[2])
                                    .intensity(420.0f * colourAndIntensity[3])
                                    .direction(direction[0], direction[1], direction[2])
                                    .castShadows(true)
                                    .build(engine, this)
                        })
    }
    private val indirectLight: IndirectLight? by lazy {
        fun readAsset(context: Context, assetName: String): ByteBuffer {
            return context.assets.open(assetName)
                    .use { inputStream -> ByteBuffer.wrap(inputStream.readBytes()) }
        }

        val ibl = getApplication<Application>().getString(R.string.indirectLightIbl)
        val iblIntensity = getApplication<Application>().getString(R.string.indirectLightIblIntensity).toFloat()

        readAsset(getApplication(), "envs/$ibl/${ibl}_ibl.ktx").let {
            KtxLoader.createIndirectLight(engine, it).apply {
                intensity = iblIntensity
//                setRotation(transpose(rotation(Float3(0.0f,1.0f), -90.0f).upperLeft).toFloatArray())
            }
        }
    }
    private val skybox: Skybox? by lazy {
        fun readAsset(context: Context, assetName: String): ByteBuffer {
            return context.assets.open(assetName)
                    .use { inputStream -> ByteBuffer.wrap(inputStream.readBytes()) }
        }

        val ibl = "studio_small_03_2k"
        readAsset(getApplication(), "envs/$ibl/${ibl}_skybox.ktx").let {
            KtxLoader.createSkybox(engine, it)
        }
    }
    private val scene by lazy {
        engine.createScene()
                .also {
                    it.indirectLight = indirectLight
//                it.skybox = skybox
//                it.addEntities(lights)
                    screen.setEnabled(it, false)
                }
    }
    private val view: View

    private val replaceAccessoriesJob = Job()
    private var accessories: ConcurrentHashMap<VykingTrackerJNI.TrackingData.DetectedObjectType, VykingAccessory> = ConcurrentHashMap()
    private var deferredAccessoriesSources: List<Deferred<List<VykingAccessorySource>>>? = ArrayList()

    private val accessoriesAreLoading = MutableLiveData<Boolean>()
    fun getAccessoriesAreLoading(): LiveData<Boolean> = accessoriesAreLoading
    private val error = MutableLiveData<String>()
    fun getError(): LiveData<String> = error

    init {
        Log.d(tag("init"), "()")

        view = engine.createView()
                .also {
                    it.scene = scene
                    it.camera = camera
                }
                .apply {
                    dynamicResolutionOptions = dynamicResolutionOptions.apply { enabled = true }
                    ambientOcclusionOptions = ambientOcclusionOptions.apply { enabled = false }
                    bloomOptions = bloomOptions.apply { enabled = false } // Requires substantional graphics memory.
                }

        fun copyLzmaFile(context: Context, directory: String) {
            File(directory).apply {
                mkdirs()

                Channels.newChannel(context.assets.open(context.getString(R.string.lzmaFileName))).use { readableByteChannel ->
                    FileOutputStream(File(directory, context.getString(R.string.lzmaFileName))).use { fileOutputStream ->
                        fileOutputStream
                                .channel
                                .transferFrom(readableByteChannel, 0, Long.MAX_VALUE)
                    }
                }
            }
        }

        // Copy the Vyking .lzma asset file ready to pass to the vykingTracker.
        with(getApplication<Application>().getExternalFilesDir("Vyking")?.absolutePath + "/") {
            copyLzmaFile(getApplication(), this)

            runBlocking {
                if (!initialiseVykingTracker(vykingTracker, this@with)) {
                    throw (ExceptionInInitializerError("Failed to initialise VykingTracker"))
                }
            }
        }
    }

    /**
     * Initialise the VykingTracker using the specified lzma configuration file.
     */
    private var initialiseVykingTrackerContinuation: CancellableContinuation<Boolean>? = null
    private suspend fun initialiseVykingTracker(vykingTracker: VykingTrackerJNI, pathForLZmaFile: String): Boolean {
        Log.d(tag("initialiseVykingTracker"), "()")

        // Simply log the VykingTrackerEventLogs
        vykingTracker.registerLogEventCallback { Log.d(tag("VykingTrackerEventLog"), it) }

        // Setup the VykingTracker delegates and do the initialisation.
        // The trackerReady delegate will be called when initialisation is complete.
        // The property "initialiseVykingTrackerContinuation" is used to convert this asynchronous delegate callback to a blocking synchronous call.
        vykingTracker.setCallbackDelegate(VykingTrackerCallback())
        return suspendCancellableCoroutine { cont ->
            initialiseVykingTrackerContinuation = cont
            if (!vykingTracker.initialise(getApplication(), VykingTrackerJNI.getDefaultInitConfigUsing(pathForLZmaFile))) {
                cont.cancel()
                throw (ExceptionInInitializerError("VykingTracker.initialise returned false"))
            }
        }
    }

    fun attachToSurface(surfaceView: SurfaceView) {
        Log.d(tag("onattachToSurface"), "()")

        this.surfaceView = surfaceView
        uiHelper.attachTo(surfaceView)
    }

    /**
     * Replace the currently rendered set of Vyking accessories with a new set
     */
    fun replaceAccessoriesAsync(item: InventoryViewModel.Item) {
        // Only one replacement at a time
        if (replaceAccessoriesJob.children.count() > 0) {
            return
        }

        val vykingAccessoryConstructor = VykingAccessory.getConstructor(engine, vykingImageTextures)
        CoroutineScope(replaceAccessoriesJob).launch(Dispatchers.Main) {
            accessoriesAreLoading.postValue(true)

            val newAccessories: ConcurrentHashMap<VykingTrackerJNI.TrackingData.DetectedObjectType, VykingAccessory> = ConcurrentHashMap()
            accessories = try {
                withTimeout(30000) {

                    // Remember the Deferred jobs so that we can cancel them in the onCleared() callback
                    deferredAccessoriesSources = item.parts.map { it.deferredSources }
                    deferredAccessoriesSources?.awaitAll() //TODO support retry

                    item.parts.associateByTo(newAccessories,
                            { it.type },
                            { vykingAccessoryConstructor(it.name, it.deferredSources.await()) }
                    )

                    deleteAccessories(accessories)
                    viewDidChange = true // Let the render loop know the view properties changed

                    // Record the new pair of shoes
                    vykingTracker.set3DModelSerialNumberJNI(item.shortShoeDescription, item.sneakerKitReference)

                    newAccessories
                }
            } catch (cause: Throwable) {
                Log.e(tag("replaceAccessories"), "Exception $cause")

                deferredAccessoriesSources?.forEach {
                    it.cancelAndJoin()
                }
                deleteAccessories(newAccessories)

                error.postValue("Failed to load accessories (${cause.message ?: cause})")

                cause.printStackTrace()
                accessories
            }

            accessoriesAreLoading.postValue(false)
        }
    }

    /**
     * Empty the specified set of Vyking accessories and destroy all the Filament resources.
     * A copy of the accessories is fist taken and cleared so that there is nothing to render before
     * destroying all the Filament resources.
     */
    private fun deleteAccessories(accessories: ConcurrentHashMap<VykingTrackerJNI.TrackingData.DetectedObjectType, VykingAccessory>) =
            ConcurrentHashMap(accessories).apply {
                accessories.clear()
                forEach { it.value.destroyFilamentResources(engine, scene) }
            }

    fun startMirroringToSurface(surface: Surface, left: Int, bottom: Int, width: Int, height: Int) {
        synchronized(surfaceMirrors) {
            surfaceMirrors.add(SurfaceMirror(surface, engine.createSwapChain(surface), Viewport(left, bottom, width, height)))
        }
    }

    fun stopMirroringToSurface(surface: Surface) {
        synchronized(surfaceMirrors) {
            surfaceMirrors.forEach {
                if (it.surface == surface) {
                    engine.destroySwapChain(it.swapChain)
                    surfaceMirrors.remove(it)
                }
            }
        }
    }

    /**
     * Resume the render loop indicating the view may have changed so any appropriate rescaling is performed. Also,
     * restart the Vyking tracking.
     */
    fun resume() {
        Log.d(tag("resume"), "()")

        viewDidChange = true
        vykingTracker.start(getApplication(), vykingImageTextures, VykingTrackerJNI.getDefaultStartConfigUsing(DESIRED_CAMERA_WIDTH, DESIRED_CAMERA_HEIGHT))
        choreographer.postFrameCallback(frameScheduler)
    }

    /**
     * Stop the render loop and the Vyking tracking
     */
    fun pause() {
        Log.d(tag("pause"), "()")

        choreographer.removeFrameCallback(frameScheduler)
        vykingTracker.stop()
    }

    /**
     * Cancel any outstanding coroutines before destroying all Filament resources and the
     * Vyking tracker.
     * IMPORTANT
     * This method must be completed before this viewModel is instantiated again.
     */
    override fun onCleared() {
        Log.d(tag("onCleared"), "()")

        // Make sure all asynchronous use of resources is complete before cleaning up.
        runBlocking {
            // deferredAccessoriesSources were launched using Dispatchers.IO, so we are ok to block the main thread
            // here without risk of a deadlock
            deferredAccessoriesSources?.forEach {
                it.cancelAndJoin()
            }
            // We cannot join() here without the risk of a deadlock because the replaceAccessoriesJob has
            // coroutines using Dispatchers.Main. It's ok, we don't need to know when the job is complete.
            replaceAccessoriesJob.cancel()
        }

        vykingTracker.removeOnUpdateListener(onVykingTrackerUpdate)
        vykingTracker.destroy()

        // Always detach the surface before destroying the engine
        uiHelper.detach()

        deleteAccessories(accessories)
        screen.destroyFilamnetResources(engine)
        vykingImageTextures.destroyFilamentResources()

        EntityManager.get().destroy(lights)
        indirectLight?.let { engine.destroyIndirectLight(it) }
        skybox?.let { engine.destroySkybox(it) }
        engine.destroyCamera(camera)
        engine.destroyScene(scene)
        engine.destroyView(view)
        swapChain?.let { engine.destroySwapChain(it) }

        // Destroying the engine will free up any resource you may have forgotten
        // to destroy, but it's recommended to do the cleanup properly
        engine.destroy()

        super.onCleared()
        Log.d(tag("onCleared"), "return")
    }

    /**
     * Vyking tracker delegate.
     */
    private inner class VykingTrackerCallback : VykingTrackerJNI.CallbackDelegate {
        override fun trackerReady(good: Boolean) {
            Log.d(tag("trackerReady"), "good: $good")

            // The property "initialiseVykingTrackerContinuation" is used to convert the asynchronous
            // initialiseVykingTracker callback into a blocking synchronous call.
            initialiseVykingTrackerContinuation?.resume(good)

            if (!good) {
                error.postValue("Tracker failed to get ready")
            } else {
                vykingTracker.addOnUpdateListener(onVykingTrackerUpdate)
            }
        }
    }

    /**
     * Filament delegate to handle the rendering
     */
    private inner class SurfaceCallback : UiHelper.RendererCallback {
        override fun onNativeWindowChanged(surface: Surface) {
            Log.d(tag("onNativeWindowChanged"), "()")

            swapChain?.let {
                engine.destroySwapChain(it)
                engine.flushAndWait()
            }
            swapChain = engine.createSwapChain(surface)
            viewDidChange = true
        }

        override fun onDetachedFromSurface() {
            Log.d(tag("onDetachedFromSurface"), "()")

            swapChain = swapChain?.let {
                engine.destroySwapChain(it)
                engine.flushAndWait()
                null
            }
        }

        override fun onResized(width: Int, height: Int) {
            view.viewport = Viewport(0, 0, width, height)
            viewDidChange = true
        }
    }

    /**
     * Called by Filament to render a frame
     */
    private inner class FrameCallback : Choreographer.FrameCallback {
        var isVykingDataReadyToRender = false

        override fun doFrame(frameTimeNanos: Long) {
            fun onViewDidChange(surfaceView: SurfaceView, frameId: Int, trackingData: VykingTrackerJNI.TrackingData) {
                val viewWidth = surfaceView.width.toFloat()
                val viewHeight = surfaceView.height.toFloat()

                FloatArray(16).also { projectionTransform ->
                    vykingTracker.cameraProjectionTransformForViewPort(
                            frameId,
                            LENS_FACTOR,
                            viewWidth,
                            viewHeight,
                            NEAR,
                            FAR,
                            projectionTransform
                    )
                    camera.setCustomProjection(projectionTransform.toDouble16(), NEAR.toDouble(), FAR.toDouble())
                }
                FloatArray(16).also { displayTransform ->
                    vykingTracker.cameraDisplayTransformForViewPort(
                            frameId,
                            LENS_FACTOR,
                            viewWidth,
                            viewHeight,
                            surfaceView.display.rotation,
                            displayTransform
                    )
                    screen.setDisplayTransform(displayTransform)
                    accessories.forEach { (_: VykingTrackerJNI.TrackingData.DetectedObjectType?, v: VykingAccessory) ->
                        v.setOccluderMaskTransform(
                                displayTransform,
                                LENS_FACTOR,
                                viewWidth,
                                viewHeight,
                                trackingData.imageWidth,
                                trackingData.imageHeight,
                                trackingData.imageOrientation
                        )
                    }
                }
                screen.setEnabled(scene, true)
            }

            // Disable each accessory so that we do not see it and then for each detected object type update its occluders,
            // update its position and then re-enable it so that it becomes visible again.
            fun onTrackingDidChange(trackingData: VykingTrackerJNI.TrackingData) {
                val parentTransform = FloatArray(16).apply {
                    camera.getModelMatrix(this)
                }

                with(engine.transformManager) {
                    openLocalTransformTransaction()
                    accessories.onEach { entry ->
                        FloatArray(16).apply {
                            Matrix.multiplyMM(this, 0, parentTransform, 0, COORD_SPACE_TRANSFORM(trackingData.getObjectTransform(entry.key)), 0)
                            entry.value.setTransform(scene, this@with, trackingData.isObjectDetected(entry.key), this)
                        }
                    }
                    commitLocalTransformTransaction()
                }
            }

            /**
             * Renders the models and updates the Filament camera.
             */
            fun render(swapChain: SwapChain, frameTimeNanos: Long) {
                fun updataMirrors(view: View) {
                    fun getLetterboxViewport(srcViewport: Viewport, destViewport: Viewport): Viewport {
                        val letterBoxSides = (destViewport.width / destViewport.height.toFloat()
                                > srcViewport.width / srcViewport.height.toFloat())
                        val scale = if (letterBoxSides) destViewport.height / srcViewport.height.toFloat() else destViewport.width / srcViewport.width.toFloat()
                        val width = (srcViewport.width * scale).toInt()
                        val height = (srcViewport.height * scale).toInt()
                        val left = (destViewport.width - width) / 2
                        val bottom = (destViewport.height - height) / 2
                        return Viewport(left, bottom, width, height)
                    }

                    synchronized(surfaceMirrors) {
                        surfaceMirrors.map {
                            renderer.copyFrame(
                                    it.swapChain,
                                    getLetterboxViewport(view.viewport, it.viewport),
                                    view.viewport,
                                    Renderer.MIRROR_FRAME_FLAG_COMMIT or Renderer.MIRROR_FRAME_FLAG_SET_PRESENTATION_TIME or Renderer.MIRROR_FRAME_FLAG_CLEAR
                            )
                        }
                    }
                }

                accessories.forEach { (_: VykingTrackerJNI.TrackingData.DetectedObjectType, v: VykingAccessory) ->
                    v.asyncUpdateLoad()
                }

                if (renderer.beginFrame(swapChain, frameTimeNanos)) {
                    if (isVykingDataReadyToRender) {
                        renderer.render(view)
                        updataMirrors(view)
                    }
                    renderer.endFrame()
                }
            }

            if (uiHelper.isReadyToRender) {
                swapChain?.let { swapChain ->
                    surfaceView?.let { surfaceView ->
                        if (surfaceView.display != null) runBlocking {
                            trackingDataFlow
                                    .filter { it.id != 0 && it.data != null }
                                    .collect {
                                        if (it.viewDidChange) {
                                            onViewDidChange(surfaceView, it.id, it.data!!)
                                        }
                                        isVykingDataReadyToRender = true
                                        onTrackingDidChange(it.data!!)
                                    }
                        }
                    }
                    render(swapChain, frameTimeNanos)
                }
            }

            choreographer.postFrameCallbackDelayed(this, 16)
        }
    }

    private companion object {
        // Load the Filament library for the utility layer, which in turn loads gltfio and the Filament core.
        init {
            Utils.init()
        }

        private const val kAperture = 16f
        private const val kShutterSpeed = 1f / 125f
        private const val kSensitivity = 100f
        private const val DESIRED_CAMERA_WIDTH = 1080
        private const val DESIRED_CAMERA_HEIGHT = 1920
        private const val LENS_FACTOR = 0.9f
        private const val NEAR = 0.1f
        private const val FAR = 10.0f

        // Function to convert VykingTracker's coordinate space into Filament's coordinate space.
        private val COORD_SPACE_TRANSFORM: (FloatArray) -> FloatArray = { transform ->
            val coordSpaceTransform =
                    floatArrayOf(
                            1.0f, 0.0f, 0.0f, 0.0f,
                            0.0f, -1.0f, 0.0f, 0.0f,
                            0.0f, 0.0f, -1.0f, 0.0f,
                            0.0f, 0.0f, 0.0f, 1.0f
                    )

            val coordSpaceTransformInverse = FloatArray(16)
            Matrix.invertM(coordSpaceTransformInverse, 0, coordSpaceTransform, 0)

            val m = FloatArray(16)
            val result = FloatArray(16)

            Matrix.multiplyMM(m, 0, transform, 0, coordSpaceTransform, 0)
            Matrix.multiplyMM(result, 0, coordSpaceTransformInverse, 0, m, 0)

            result
        }
    }

    private fun FloatArray.toDouble16(): DoubleArray {
        require(size >= 16)
        return doubleArrayOf(
                this[0].toDouble(),
                this[1].toDouble(),
                this[2].toDouble(),
                this[3].toDouble(),
                this[4].toDouble(),
                this[5].toDouble(),
                this[6].toDouble(),
                this[7].toDouble(),
                this[8].toDouble(),
                this[9].toDouble(),
                this[10].toDouble(),
                this[11].toDouble(),
                this[12].toDouble(),
                this[13].toDouble(),
                this[14].toDouble(),
                this[15].toDouble()
        )
    }
}