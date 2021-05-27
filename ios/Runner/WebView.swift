//
//  WebView.swift
//  Runner
//
//  Created by Dev on 4/7/21.
//

import Flutter
import UIKit
import WebKit

class WebViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return WebView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class WebView: NSObject, FlutterPlatformView, WKNavigationDelegate {

    let frame: CGRect
    let viewId: Int64;
    let args: Any?
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        self.frame = frame;
        self.viewId = viewId;
        self.args = args;
        super.init()

    }

    func view() -> UIView {
        let map = args as? [String: Any];
        let mUrl = map?["url"] as? String;
        let params = map?["params"] as? String;
        let referer = map?["referer"] as? String;
        let jsWrapper = map?["jsWrapper"] as? String;

        let url = URL(string: mUrl ?? "");

        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: jsWrapper!,
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        contentController.addUserScript(userScript)
        
        let view: WKWebView = WKWebView(frame: frame, configuration: config)
        view.navigationDelegate = self

        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(referer, forHTTPHeaderField: "Referer")
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("100", forHTTPHeaderField: "Content-Length")
        urlRequest.httpBody = params!.data(using: .utf8)
        
        view.load(urlRequest)
        return view
    }
}
