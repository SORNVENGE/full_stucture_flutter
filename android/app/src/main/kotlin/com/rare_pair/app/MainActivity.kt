package com.rare_pair.app

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    val PREFS_NAME= "RarePairSneakerModel"
    val KEY_URL = "key.urlModel"
    lateinit var sharedPreferences: SharedPreferences
    private var result: MethodChannel.Result? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("com.rare-pair.webview", WebViewFactory())
        
        MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(
                object : MethodChannel.MethodCallHandler {
                    @Override
                    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
                        this@MainActivity.result = result
                        val urlSneaker : String = methodCall.arguments()
                        if (methodCall.method.equals(METHOD_SET_MODEL)) {
                            sharedPreferences = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                            saveUrlModel(urlSneaker)
                            onLaunchTryOnShoes()
                        } else {
                            result.notImplemented()
                        }
                    }
                }
        )
    }

    private fun onLaunchTryOnShoes() {
        val tryOnShoesIntent = Intent(this, TryOnShoesActivity::class.java)
        startActivityForResult(tryOnShoesIntent, SNEAKER_REQUEST)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == SNEAKER_REQUEST) {
            if (resultCode == RESULT_OK) {
//                result?.success(data.getIntExtra(TryOnShoesActivity.EXTRA_SNEAKER, 0))
            } else {
                result?.error("ACTIVITY_FAILURE", "Failed while launching activity", null)
            }
        }
    }

    private fun saveUrlModel(urlModel: String) {
        val editor = sharedPreferences.edit()
        editor.putString(KEY_URL, urlModel)
        editor.apply()
    }

    companion object {
        private const val CHANNEL = "com.rare_pair.app/try_on_shoes"
        private const val METHOD_SET_MODEL = "setModel"
        private const val SNEAKER_REQUEST = 1
    }
}