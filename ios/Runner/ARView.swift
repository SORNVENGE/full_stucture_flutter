//
//  FLNativeView.swift
//  Runner
//
//  Created by Dev on 4/7/21.
//

import Flutter
import UIKit
import VykFootView

class ARViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return ARView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class ARView: NSObject, FlutterPlatformView, vkFootViewDelegate {
    private var _view: UIView
    var vykFootView : VykFootView? = nil
    var mShoe : String = "https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/adidas_yeezy_350_yecheil/offsets.json"
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        
        super.init()
        // iOS views can be created here
        createARView(view: _view)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createARView(view _view: UIView) {
        _view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vykFootView = VykFootView(frame: _view.frame)
        if let mv = vykFootView {
            mv.backgroundColor = UIColor.orange
            _view.addSubview(mv)
            mv.setupAssetLoaderModified(destinationPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path)
            mv.setupFootTracker(initConfig: ConstantsForVykingTracker.vykingTrackerInitConfig, accessConfig: ConstantsForVykingTracker.vykingTrackerAccessConfig, delegate: self)
            LoadShoe()
        }
    }
    
    @IBAction func LoadShoe() {
        vykFootView?.loadShoeAsset(urlString: mShoe)
    }
    
    typealias VykingTrackerConfig = [String : Any]
    
    enum ConstantsForVykingTracker {
        static let vykingTrackerInitConfig: VykingTrackerConfig = [
            "baseDir"   : Bundle.main.bundlePath,
            "vykingFile": "VykingData.lzma",
        ]
        
        static let vykingTrackerAccessConfig: VykingTrackerConfig = [
            "facing"                      : false,
            "arKit"                       : false,
            "arKitExternalCamera"         : false,
            "arKitInternalPlaneDetection" : "none",
            "tracker"                     : "foot",
            "config" : [
                "textureScale": [
                    "width": 750,
                    "height": 750,
                    "widthAv": 7,
                    "heightAv": 7,
                    "fusionFactor": 0.6565
                ]
            ]
        ]
    }
    
    func vkReady(good: Bool) {
        NSLog("ARView.swift: vkReady good \(good)")
    }
    
    func vkShutdown(good: Bool) {
        NSLog("ARView.swift: vkReady good \(good)")
    }
    
    func vkLoadShoeAssetResponse(urlString: String, assetsPath: String?, good: Bool, message: String?) {
        NSLog("ARView.swift: vkLoadShoeAssetResponse urlString \(urlString), good \(good), message \(String(describing: message))")
    }
}
