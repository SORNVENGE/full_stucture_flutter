package com.rare_pair.app

import android.Manifest
import android.app.Activity
import android.content.ContentValues
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Paint
import android.icu.text.DateFormat
import android.net.Uri
import android.net.http.HttpResponseCache
import android.os.*
import android.provider.MediaStore
import android.util.Log
import android.view.*
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.*
import com.alertview.lib.AlertView
import com.alertview.lib.OnItemClickListener
import com.rare_pair.app.databinding.ActivityTryOnShoesBinding
import kotlinx.coroutines.*
import java.io.ByteArrayOutputStream
import java.io.File
import java.lang.ref.WeakReference
import java.util.*
import com.google.android.material.snackbar.Snackbar

class TryOnShoesActivity : AppCompatActivity(), OnItemClickListener {
    private val tag: (String) -> String = { it -> "${this.javaClass.name}.$it" }

    private lateinit var surfaceView: SurfaceView
    private lateinit var watermarkBitmapResized: Bitmap
    private var footTrackingTrackingViewModel: VykingTrackingViewModel? = null
    private val binding by lazy { ActivityTryOnShoesBinding.inflate(layoutInflater) }

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d(tag("onCreate"), "()")
        super.onCreate(savedInstanceState)
//        Log.i(tag(""), "App Version: ${BuildConfig.VERSION_NAME}")
        activityInstanceRef = WeakReference(this)
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        try {
            HttpResponseCache.install(File(this.cacheDir, "http"), 30 * 1024 * 1024.toLong())
        } catch (e: java.lang.Exception) {
            Log.i(tag("onCreate"), "HTTP response cache installation failed:$e")
        }
        with(binding) {
            setContentView(root)
            photoButton.apply {
                setOnClickListener {
                    if (ContextCompat.checkSelfPermission(this@TryOnShoesActivity, Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED) {
                        photoCapture()
                    } else {
                        ActivityCompat.requestPermissions(
                                this@TryOnShoesActivity,
                                arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                                MY_PERMISSIONS_REQUEST_TAKE_PHOTO
                        )
                    }
                }
                setImageResource(R.drawable.photo_start)
                isEnabled = true
            }
        }
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) {
            createViewModels()
        } else {
            ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.CAMERA),
                    MY_PERMISSIONS_REQUEST_USE_CAMERA
            )
        }
        val watermarkBitmap = BitmapFactory.decodeResource(resources, R.drawable.watermark)
        watermarkBitmapResized = Bitmap.createScaledBitmap(watermarkBitmap, watermarkBitmap.width/8, watermarkBitmap.height/8, false)
    }

    private fun createViewModels() {
        Log.d(tag("createViewModels"), "()")
        try {
            ViewModelProvider(this).get(SneakerViewModel::class.java).apply {
                getInventory().observe(this@TryOnShoesActivity, { inventory ->
                    inventory.let { footTrackingTrackingViewModel?.replaceAccessoriesAsync(it) }
                })

                getInventoryIsLoading().observe(this@TryOnShoesActivity, {
                    when (it) {
                        true -> binding.InventoryIsLoadingProgressBar.visibility = View.VISIBLE
                        false -> binding.InventoryIsLoadingProgressBar.visibility = View.GONE
                    }
                })

                getError().observe(this@TryOnShoesActivity, {
                    showErrorAlert("Something went wrong!", "But you can try again.")
                })
            }

            // Create the viewModel that performs the Vyking tracking
            surfaceView = binding.footTrackingView.also { surfaceView ->
                footTrackingTrackingViewModel = ViewModelProvider(this).get(VykingTrackingViewModel::class.java).apply {
                    attachToSurface(surfaceView)
                    getAccessoriesAreLoading().observe(this@TryOnShoesActivity, {
                        when (it) {
                            true -> binding.AccessoriesAreLoadingProgressBar.visibility = View.VISIBLE
                            false -> binding.AccessoriesAreLoadingProgressBar.visibility = View.GONE
                        }
                    })
                    getError().observe(this@TryOnShoesActivity, {
                        showErrorAlert("Something went wrong!", "But you can try again.")
                    })
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            Toast.makeText(this, e.message, Toast.LENGTH_LONG).apply {
                setGravity(Gravity.CENTER, 0, 0)
                show()
            }
        }
    }

    private fun photoCapture() {
        var photoCaptureUri: Uri? = null
        val resolver = contentResolver

        try {
            val relativePath = Environment.DIRECTORY_PICTURES // + File.separator + "Vyking";
            val filename = "RARE-PAIR_" + DateFormat.getDateTimeInstance().format(Date())
            val values = ContentValues().apply {
                put(MediaStore.Images.Media.TITLE, filename)
                put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    put(MediaStore.Images.Media.RELATIVE_PATH, relativePath)
                } else {
                    @Suppress("DEPRECATION")
                    put(
                            MediaStore.Images.Media.DATA,
                            Environment.getExternalStoragePublicDirectory(relativePath).toString() + File.separator + filename + ".jpg"
                    )
                }
            }

            photoCaptureUri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)?.also { uri ->
                photoCaptureUri = uri

                // Create a bitmap the size of the scene view.
                val bitmap = Bitmap.createBitmap(surfaceView.width, surfaceView.height, Bitmap.Config.ARGB_8888)

                // Create a handler thread to offload the processing of the image.
                val handlerThread = HandlerThread("PixelCopier")
                handlerThread.start()
                PixelCopy.request(surfaceView, bitmap, { copyResult ->
                    try {
                        if (copyResult != PixelCopy.SUCCESS) {
                            Log.e(tag("photoCapture"), java.lang.String.format("PixelCopy failure %d", copyResult))
                            resolver.delete(uri, null, null)
                            runOnUiThread {
                                Toast.makeText(this, "Failed to copyPixels", Toast.LENGTH_LONG).apply {
                                    setGravity(Gravity.CENTER, 0, 0)
                                    show()
                                }
                            }
                            return@request
                        }
                        try {
                            resolver.openOutputStream(uri, "w")?.use { outputStream ->
                                ByteArrayOutputStream().use { outputData ->
                                    val canvasBitmap = Canvas(bitmap)
                                    val transparentpaintwatermark = Paint()
                                    transparentpaintwatermark.alpha = 150
                                    canvasBitmap.drawBitmap(
                                            watermarkBitmapResized,
                                            0f,(bitmap.getHeight())-(watermarkBitmapResized.height)-20f,
                                            transparentpaintwatermark
                                    )
                                    canvasBitmap.setBitmap(bitmap)
                                    bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputData)
                                    outputData.writeTo(outputStream)
                                    outputStream.flush()
                                }
                            }
                        } catch (cause: Throwable) {
                            Log.e(tag("photoCapture"), String.format("(%s) Exception %s", Build.VERSION.SDK_INT, cause.toString()))
                            resolver.delete(uri, null, null)
                            runOnUiThread {
                                Toast.makeText(this, "Failed to save photo", Toast.LENGTH_LONG).apply {
                                    setGravity(Gravity.CENTER, 0, 0)
                                    show()
                                }
                            }
                            return@request
                        }
                        Intent()
                                .setType("mime/*")
                                .setAction(Intent.ACTION_VIEW)
                                .setData(uri)
                                .let { intent ->
                                    Snackbar.make(findViewById(android.R.id.content), "Photo saved", Snackbar.LENGTH_LONG)
                                            .setAction("Open in Photos") { startActivity(intent) }
                                            .show()
                                }
                    } finally {
                        handlerThread.quitSafely()
                    }
                }, Handler(handlerThread.looper))
            }
        } catch (e: java.lang.Exception) {
            Log.e(tag("photoCapture"), String.format("(%s) Exception %s", Build.VERSION.SDK_INT, e.toString()))
            if (photoCaptureUri != null) {
                resolver.delete(photoCaptureUri!!, null, null)
            }

            Toast.makeText(this, "Failed to take photo", Toast.LENGTH_LONG).apply {
                setGravity(Gravity.CENTER, 0, 0)
                show()
            }
        }
    }

    override fun onResume() {
        Log.d(tag("onResume"), "()")
        super.onResume()
        footTrackingTrackingViewModel?.resume()
    }

    override fun onPause() {
        Log.d(tag("onPause"), "()")
        super.onPause()
        footTrackingTrackingViewModel?.pause()
    }

    override fun onStop() {
        Log.d(tag("onStop"), "()")
        super.onStop()
        //Keep a lid on our cache usage
        HttpResponseCache.getInstalled()?.apply {
            Log.d(tag("onStop"), String.format("Cache hit ratio %f", if (requestCount > 0) hitCount.toFloat() / requestCount else 0.0f))
            flush()
        }
    }

    override fun onDestroy() {
        Log.d(tag("onDestroy"), "()")
        super.onDestroy()
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        Log.d(tag("onWindowFocusChanged"), "()")
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            hideSystemUI()
        }
    }

    private fun hideSystemUI() {
        Log.d(tag("hideSystemUI"), "()")
        val decorView = window.decorView
        decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_IMMERSIVE // Set the content to appear under the system bars so that the
                // content doesn't resize when the system bars hide and show.
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
//                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN // Hide the nav bar and status bar
//                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String?>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            MY_PERMISSIONS_REQUEST_USE_CAMERA -> if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                createViewModels()
            } else {
                Toast.makeText(this, "Camera permission is required to use feet tracker.", Toast.LENGTH_LONG).apply {
                    setGravity(Gravity.CENTER, 0, 0)
                    show()
                }
            }
            MY_PERMISSIONS_REQUEST_TAKE_PHOTO -> if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                photoCapture()
            } else {
                Toast.makeText(this, "Write to external storage permission is required to use screen capture.", Toast.LENGTH_LONG).apply {
                    setGravity(Gravity.CENTER, 0, 0)
                    show()
                }
            }
        }
    }

    fun showErrorAlert(title: String, message: String) {
        AlertView(title,
                message,
                null, arrayOf("Back"),
                null,
                this,
                AlertView.Style.Alert,
                this)
                .show()
    }

    private fun returnToFlutterView() {
        val returnIntent = Intent()
//        returnIntent.putExtra(EXTRA_COUNTER, counter)
        setResult(Activity.RESULT_OK, returnIntent)
        finish()
    }

    override fun onBackPressed() {
        returnToFlutterView()
    }

    companion object {
        var activityInstanceRef: WeakReference<Activity>? = null
        private const val MY_PERMISSIONS_REQUEST_USE_CAMERA = 1
        private const val MY_PERMISSIONS_REQUEST_TAKE_PHOTO = 2
    }

    override fun onItemClick(o: Any?, position: Int) {
        if (position !== AlertView.CANCELPOSITION) {
            returnToFlutterView()
            return
        }
    }
}