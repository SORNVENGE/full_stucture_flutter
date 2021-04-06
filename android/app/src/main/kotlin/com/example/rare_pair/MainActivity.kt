package com.example.rare_pair

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.io/platform_view"
    private val METHOD_SWITCH_VIEW = "switchView"
    private val ARGUMENT = "SHOES_MODEL"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method.equals(METHOD_SWITCH_VIEW)) {
//                call.arguments
                val intent = Intent(this, TryOnShoesActivity::class.java)
                intent.putExtra(ARGUMENT, "${call.arguments}")
                startActivity(intent)
            }
        }
        
    }
}
