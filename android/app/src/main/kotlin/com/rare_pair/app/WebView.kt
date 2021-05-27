package com.rare_pair.app

import android.content.Context
import android.view.View
import android.webkit.WebResourceResponse
import io.flutter.plugin.platform.PlatformView

import android.webkit.WebView
import android.webkit.WebViewClient
import java.net.URL
import java.nio.charset.StandardCharsets
import javax.net.ssl.HttpsURLConnection

import android.widget.TextView
import android.graphics.Color

internal class WebView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val webview: WebView = WebView(context)
//    private val textView: TextView

    override fun getView(): View {
//        return textView
        return webview;
    }

    override fun dispose() {}

    init {
        webview.settings.javaScriptEnabled = true
        webview.setWebViewClient(object : WebViewClient() {
            override fun onPageFinished(view: WebView, url: String) {

                val js = creationParams?.getValue("jsWrapper").toString()

                webview.evaluateJavascript(js, null)
                super.onPageFinished(view, url)
            }
        })

        var url = URL(creationParams?.getValue("url").toString())
        var params = creationParams?.getValue("params").toString()
        webview.postWebview(url.toString(), params.toByteArray(StandardCharsets.UTF_8), creationParams)
    }

    private fun WebView.postWebview(postUrl: String,  postData: ByteArray, params: Map<String?, Any?>?) {

        val savedWebViewClient =
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                webViewClient
            } else {
                TODO("VERSION.SDK_INT < O")
            }

        webViewClient = object : WebViewClient() {
            override fun shouldInterceptRequest(view: WebView, url: String): WebResourceResponse? {

                if (url != postUrl) {
                    view.post {
                        webViewClient = savedWebViewClient
                    }
                    return savedWebViewClient.shouldInterceptRequest(view, url)
                }

                val httpsUrl = URL(url)
                val conn: HttpsURLConnection = httpsUrl.openConnection() as HttpsURLConnection
                conn.requestMethod = "POST"
                conn.addRequestProperty("Referer", params?.getValue("referer").toString())
                conn.addRequestProperty("Content-Type", "application/x-www-form-urlencoded")

                conn.outputStream.write(postData)
                conn.outputStream.close()

                val responseCode = conn.responseCode
                view.post {
                    webViewClient = savedWebViewClient
                }
                // typical conn.contentType is "text/html; charset=UTF-8"
                return WebResourceResponse(
                    conn.contentType.substringBefore(";"),
                    "utf-8",
                    conn.inputStream
                )

            }
        }
        loadUrl(postUrl)
    }
}