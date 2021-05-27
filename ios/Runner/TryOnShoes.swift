import UIKit
import VykFootView

class TryOnShoes: UIViewController, vkFootViewDelegate, ARVideoCaptureDelegate {
    func externalVideoCapture(_ didCaptureVideoFrame: ARFrame?) -> Int? {
        let frameID = vykFootView?.VykFeetSendExternalVideoCapture(didCaptureVideoFrame)
        return frameID
    }
    
    @IBOutlet weak var ARView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var mARvideoCapture    : ARvideoCapture? = nil
    var vykFootView : VykFootView? = nil
    var isVykFootViewActive : Bool = true
    var model = ""
    
    func LoadShoe(urlString: String) {
        vykFootView?.loadShoeAsset(urlString: urlString)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("ViewDidLoad")
        vykFootView = VykFootView(frame: ARView.frame)
        if let mv = vykFootView {
            ARView.addSubview(mv)
            mv.setupAssetLoaderModified(destinationPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path)
            mv.setupFootTracker(initConfig: ConstantsForVykingTracker.vykingTrackerInitConfig, accessConfig: ConstantsForVykingTracker.vykingTrackerAccessConfig, delegate: self);
            LoadShoe(urlString: self.model)
        }
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        swipeGestureRecognizerLeft.direction = .right
        ARView.addGestureRecognizer(swipeGestureRecognizerLeft)
        takePictureButton.isHidden = true
        loadingSpinner.startAnimating()
        backButton.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        let menuBackItem = UIBarButtonItem(customView: backButton)
        let currWidth = menuBackItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBackItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        navigationItem.leftBarButtonItem = menuBackItem
    }
    
    @objc func goBack(){
        DispatchQueue.main.async {
            self.shutdownVyking()
        }
        self.switchToFlutter()
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let mySnap = vykFootView?.snapshot()
        
        //add watermark
        let watermarkImage = UIImage(named: "watermark")
        let rect = CGRect(x:0, y:0, width: mySnap!.size.width, height: mySnap!.size.height)
        UIGraphicsBeginImageContextWithOptions(mySnap!.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        context!.fill(rect)
        mySnap!.draw(in: rect, blendMode: .normal, alpha: 1)
        watermarkImage!.draw(in: CGRect(x: 0, y: mySnap!.size.height-(watermarkImage!.size.height/4+10), width: watermarkImage!.size.width/4, height: watermarkImage!.size.height/4), blendMode: .normal, alpha: 0.5)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let imageResult = result {
            UIImageWriteToSavedPhotosAlbum(
                imageResult,
                self,
                #selector(ProcessSnapImageSaveResult),
                nil)
        }
    }
    
    @objc func ProcessSnapImageSaveResult( image                    : UIImage!,
                                           didFinishSavingWithError error :NSError!,
                                           contextInfo                     :UnsafeRawPointer)
    {
        if error == nil {
            NSLog("ProcessSnapImageSaveResult result successful")
            
            let alertController = UIAlertController(title: "Picture was successfully saved", message: nil, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            NSLog("ProcessSnapImageSaveResult result of Camera Save \(String(describing: error))")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("ViewDidAppear")
        vykFootView?.frame = ARView.frame
        vykFootView?.frame.origin = CGPoint(x: 0, y: 0)
    }
    
    override func viewDidLayoutSubviews() {
        NSLog("ViewDidLayoutSubviews")
        if let mv = vykFootView {
            mv.frame = ARView.frame
            mv.frame.origin = CGPoint(x: 0, y: 0)
            mv.viewLayoutChanged()
        } else {
            ARView?.frame = ARView.frame
        }
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
                    "width": 540,
                    "height": 960,
                    "widthAv": 7,
                    "heightAv": 7,
                    "fusionFactor": 0.6565
                ]
            ]
        ]
    }
    
    func vkReady(good: Bool) {
        NSLog("TryOnShoes.swift: vkReady good \(good)")
        if (good == false) {
            showAlert()
        }
    }
    
    func vkShutdown(good: Bool) {
        NSLog("TryOnShoes.swift: vkShutdown good \(good)")
    }
    
    func vkLoadShoeAssetResponse(urlString: String, assetsPath: String?, good: Bool, message: String?) {
        NSLog("TryOnShoes.swift: vkLoadShoeAssetResponse urlString \(urlString), good \(good), message \(String(describing: message))")
        if (good == true) {
            loadingSpinner.stopAnimating()
            loadingSpinner.hidesWhenStopped = true
            takePictureButton.isHidden = false
        }
        else {
            showAlert()
        }
    }
    
    func shutdownVyking() {
        NSLog("TryOnShoes.swift: shutDownVyking")
        #if true
        DispatchQueue.main.async {
            self.mARvideoCapture?.setDelegate(delegate: nil)
            self.mARvideoCapture = nil
            self.vykFootView?.destroyFootTracking()
            self.vykFootView?.removeFromSuperview()
            self.vykFootView = nil
        }
        #else
        vykFootView?.pauseFootTracking()
        NSLog("TryOnShoes.swift: pauseFootTracking")
        
        #endif
    }
    
    func switchToFlutter() {
        dismiss(animated:true, completion:nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Something went wrong!", message: "But you can try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Back", style: UIAlertAction.Style.default, handler: {action in switch action.style {
        case .default:
            self.goBack()
        case .cancel:
            self.goBack()
        case .destructive:
            self.goBack()
        }}))
        DispatchQueue.main.async(execute: {
           self.present(alert, animated: true, completion: nil)
   })
    }
}
