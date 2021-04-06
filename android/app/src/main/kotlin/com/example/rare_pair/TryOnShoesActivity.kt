package com.example.rare_pair

import android.Manifest
import android.app.Activity
import android.content.pm.PackageManager
import android.net.http.HttpResponseCache
import android.os.*
import android.util.Log
import android.view.*
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.observe
import io.vyking.vykingfilamentdemo.BuildConfig
import kotlinx.coroutines.*
import java.io.File
import java.lang.ref.WeakReference
import java.util.*
import io.vyking.vykingfilamentdemo.databinding.ActivityTryOnShoesBinding

class TryOnShoesActivity : AppCompatActivity() {
    private val tag: (String) -> String = { it -> "${this.javaClass.name}.$it" }

    private lateinit var surfaceView: SurfaceView
    private var footTrackingTrackingViewModel: VykingTrackingViewModel? = null
    private val binding by lazy { ActivityTryOnShoesBinding.inflate(layoutInflater) }

    private val ARGUMENT = "SHOES_MODEL"
    private val DEFAULT_ARGUMENT = "SHOES_MODEL"

    override fun onCreate(savedInstanceState: Bundle?) {
        Log.d(tag("onCreate"), "()")

        super.onCreate(savedInstanceState)

        val model = intent.getStringExtra(ARGUMENT) ?: DEFAULT_ARGUMENT

        Log.d("Model", model)

        Log.i(tag(""), "App Version: ${BuildConfig.VERSION_NAME}")

        activityInstanceRef = WeakReference(this)

        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        try {
            HttpResponseCache.install(File(this.cacheDir, "http"), 30 * 1024 * 1024.toLong())
        } catch (e: java.lang.Exception) {
            Log.i(tag("onCreate"), "HTTP response cache installation failed:$e")
        }

        with(binding) {
            setContentView(root)
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
    }

    private fun createViewModels() {
        Log.d(tag("createViewModels"), "()")

        try {
            // Create the viewModel that provides an inventory of shoes
            ViewModelProvider(this).get(InventoryViewModel::class.java).apply {
                getInventory().observe(this@TryOnShoesActivity, { inventory ->
//                    binding.ShoeSelectionLayoutView.removeAllViewsInLayout()
//                    inventory.forEach { item ->
//                        ImageView(binding.ShoeSelectionLayoutView.context).apply {
//                            isClickable = true
//                            setOnClickListener {
//                                footTrackingTrackingViewModel?.replaceAccessoriesAsync(item)
//                            }
//                            if (item.icon != null) {
//                                setImageBitmap(item.icon)
//                            } else {
//                                setImageDrawable(binding.DefaultShoeSelectionView.drawable)
//                            }
//                            alpha = binding.DefaultShoeSelectionView.alpha
//                            background = binding.DefaultShoeSelectionView.background
//                            foreground = binding.DefaultShoeSelectionView.foreground
//                            layoutParams = binding.DefaultShoeSelectionView.layoutParams
//
//                            binding.ShoeSelectionLayoutView.addView(this)
//                        }
//                    }

                    Log.d("inventoryFirst", inventory.first().toString())
                    //Load the first shoe from the inventory
                    if (inventory.isNotEmpty()) {
                        inventory.first().let { footTrackingTrackingViewModel?.replaceAccessoriesAsync(it) }
                    }
                })

                getInventoryIsLoading().observe(this@TryOnShoesActivity, {
                    when (it) {
                        true -> binding.InventoryIsLoadingProgressBar.visibility = View.VISIBLE
                        false -> binding.InventoryIsLoadingProgressBar.visibility = View.GONE
                    }
                })

                getError().observe(this@TryOnShoesActivity, {
                    Toast.makeText(this@TryOnShoesActivity, it, Toast.LENGTH_LONG).apply {
                        setGravity(Gravity.CENTER, 0, 0)
                        show()
                    }
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
                        Toast.makeText(this@TryOnShoesActivity, it, Toast.LENGTH_LONG).apply {
                            setGravity(Gravity.CENTER, 0, 0)
                            show()
                        }
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
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN // Hide the nav bar and status bar
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String?>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        when (requestCode) {
            MY_PERMISSIONS_REQUEST_USE_CAMERA -> if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                createViewModels()
            } else {
                Toast.makeText(this, "Camera permission is required to use VykingTracker.", Toast.LENGTH_LONG).apply {
                    setGravity(Gravity.CENTER, 0, 0)
                    show()
                }
            }
        }
    }

    companion object {
        var activityInstanceRef: WeakReference<Activity>? = null

        private const val MY_PERMISSIONS_REQUEST_USE_CAMERA = 1
    }
}
