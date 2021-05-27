import Flutter
import UIKit
import VykFootView

private let useExternalVideoCapture   : Bool = false

class TryOnShoesViewFactory: NSObject, FlutterPlatformViewFactory {
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
        return TryOnShoesView(
            messenger: messenger,
            frame: frame,
            viewId: viewId,
            args: args)
    }
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class TryOnShoesView: NSObject, FlutterPlatformView, vkFootViewDelegate, ARVideoCaptureDelegate {
    let messenger: FlutterBinaryMessenger
    let frame: CGRect
    let viewId: Int64
    let channel: FlutterMethodChannel
    
    func externalVideoCapture(_ didCaptureVideoFrame: ARFrame?) -> Int? {
        let frameID = vykFootView?.VykFeetSendExternalVideoCapture(didCaptureVideoFrame)
        return frameID
    }
    
    private var _view: UIView
    var mARvideoCapture : ARvideoCapture? = nil
    var vykFootView : VykFootView? = nil
    var isVykFootViewActive : Bool = true
    var model : String
    var mShoe : String = "https://vykingsneakerkitnative.s3.amazonaws.com/SneakerStudio/may_android_ios/adidas_yeezy_350_yecheil/offsets.json"
    
    init(messenger: FlutterBinaryMessenger,
         frame: CGRect,
         viewId: Int64,
         args: Any?
    ) {
        self.messenger = messenger
        self.frame=frame
        self.viewId=viewId
        model=""
        channel = FlutterMethodChannel(name: "com.rare_pair.app/try_on_shoes", binaryMessenger: messenger)
        _view = UIView()
        super.init()
        createTryOnShoesView(view: _view)
    }
        func view() -> UIView {
            return _view
        }
        
        func createTryOnShoesView(view _view: UIView) {
            _view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            vykFootView = VykFootView(frame: _view.frame)
            if let mv = vykFootView {
                _view.addSubview(mv)
                mv.setupAssetLoaderModified(destinationPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path)
                mv.setupFootTracker(initConfig: ConstantsForVykingTracker.vykingTrackerInitConfig, accessConfig: ConstantsForVykingTracker.vykingTrackerAccessConfig, delegate: self);
                LoadShoe(urlString: self.mShoe)
            }
        }
        
        func LoadShoe(urlString: String) {
            vykFootView?.loadShoeAsset(urlString: urlString)
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
                        "width": 1000,
                        "height": 1000,
                        "widthAv": 8,
                        "heightAv": 8,
                        "fusionFactor": 0.6565
                    ]
                ]
            ]
        }
        
        func vkReady(good: Bool) {
            NSLog("TryOnShoesView.swift: vkReady good \(good)")
        }
        
        func vkShutdown(good: Bool) {
            NSLog("TryOnShoesView.swift: vkShutdown good \(good)")
        }
        
        func vkLoadShoeAssetResponse(urlString: String, assetsPath: String?, good: Bool, message: String?) {
            NSLog("TryOnShoesView.swift: vkLoadShoeAssetResponse urlString \(urlString), good \(good), message \(String(describing: message))")
        }
        
        func shutdownVyking() {
            NSLog("TryOnShoesView.swift: shutDownVyking")
            #if true
            mARvideoCapture?.setDelegate(delegate: nil)
            mARvideoCapture = nil
            vykFootView?.destroyFootTracking()
            vykFootView?.removeFromSuperview()
            vykFootView = nil
            #else
            vykFootView?.pauseFootTracking()
            NSLog("TryOnShoesView.swift: pauseFootTracking")
            #endif
        }
    }
