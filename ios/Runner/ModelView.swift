import Flutter
import UIKit
import SceneKit

class ModelViewFactory: NSObject, FlutterPlatformViewFactory {
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
        return ModelView(
            messenger: messenger,
            frame: frame,
            viewId: viewId,
            args: args)
    }
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class ModelView: NSObject, FlutterPlatformView, UIGestureRecognizerDelegate {
    
    let messenger: FlutterBinaryMessenger
    let frame: CGRect
    let viewId: Int64
    let channel: FlutterMethodChannel
    
    private var _view: UIView
    private var _sceneView : SCNView
    //var cameraNode:SCNNode!
    
    //// camera
    let camera = SCNCamera()
    var cameraNode = SCNNode()
    var cameraOrbitFinal = SCNNode() // final position of camera (smooth transition)
    let cameraOrbitStart = SCNNode() // start position of camera
    
    //// pan camera limits
    var widthAngle: Float = 0.0 // initial angles
    var heightAngle: Float = 0.0
    var lastWidthAngle: Float = 0.0 /// in radians
    var lastHeightAngle: Float = 0.0
    var maxHeightAngleXUp: Float = 1  // up/down limits
    var maxHeightAngleXDown: Float = -1
    
    // camera zoom limits
    var cameraCurrentZoomScale = 45.0
    
    // camera limits up/down, left/right
    var lastPositionX: Float = 0.0
    var lastPositionY: Float = 0.0
    var maxXPositionRight: Float = 0.0
    var maxXPositionLeft: Float = 0.0
    var maxYPositionUp: Float = 0.0
    var maxYPositionDown: Float = 0.0
    
    ////// original settings, double tap to reset
    var originalCameraZoomScale: Double!
    var originalWidthAngle: Float!
    var originalHeightAngle: Float!
    var originalPositionX: Float!
    var originalPositionY: Float!
    
    /////// position of cameraOrbitNode, starts at center of scene
    var positionX: Float = 0.0
    var positionY: Float = 0.0
    
    init(messenger: FlutterBinaryMessenger,
         frame: CGRect,
         viewId: Int64,
         args: Any?
    ) {
        self.messenger = messenger
        self.frame=frame
        self.viewId=viewId
        channel = FlutterMethodChannel(name: "com.rare-pair/modelview", binaryMessenger: messenger)
        
        _sceneView = SCNView()
        _view = UIView()
        super.init()
        createModelView(sceneView: _sceneView)
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createModelView(sceneView _sceneView: SCNView) {
        _view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        _view.backgroundColor = UIColor(named: "BackgroundColor")?.withAlphaComponent(0)
        _view.backgroundColor = UIColor.clear
        _sceneView.frame = CGRect(x: 0, y: -105, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        _view.addSubview(_sceneView)
        // 1: Load 3D file
        let scene = SCNScene(named: "sb_dunk_low_travis_scott_regular_box.usdz")
        
        // 2: Add camera node
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: Float(cameraCurrentZoomScale))
        // 4: Set camera on scene
        scene?.rootNode.addChildNode(cameraNode)
        
        // 5: Adding light to scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 45)
        scene?.rootNode.addChildNode(lightNode)
        
        // 6: Creating and adding ambien light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        //cameraNode = scene?.rootNode.childNode(withName: "sceneCamera", recursively: true)
        // Allow user to manipulate camera
        //_sceneView.allowsCameraControl = true
        _sceneView.autoenablesDefaultLighting = true
        
        // Show FPS logs and timming
        // sceneView.showsStatistics = true
        
        // Set background color
        _sceneView.backgroundColor = UIColor.orange.withAlphaComponent(0)
        _sceneView.backgroundColor = UIColor.clear
        _sceneView.layer.backgroundColor = UIColor.clear.cgColor
        
        // Allow user translate image
        _sceneView.cameraControlConfiguration.allowsTranslation = false
        
        // Set scene settings
        _sceneView.scene = scene
        
        _sceneView.delegate = self
        
        cameraNode.camera = camera
        //        cameraNode.position = SCNVector3(x: 0, y: 0, z: 45)
        cameraOrbitStart.position = cameraNode.position
        
        //initial camera selfie stick setup
        cameraOrbitFinal.addChildNode(cameraNode)
        cameraOrbitFinal.position = SCNVector3(x: 0, y: 0, z: 0)
        cameraOrbitFinal.eulerAngles.y = Float(-2 * M_PI) * lastWidthAngle // initial view angle around y
        cameraOrbitFinal.eulerAngles.x = Float(-M_PI) * lastHeightAngle // initial view angle around x
        cameraOrbitStart.eulerAngles.x = cameraOrbitFinal.eulerAngles.x
        cameraOrbitStart.eulerAngles.y = cameraOrbitFinal.eulerAngles.y
        scene!.rootNode.addChildNode(cameraOrbitFinal)
        scene!.rootNode.addChildNode(cameraOrbitStart)
        
        //// set original positions and camera angle, double tap to reset
        originalCameraZoomScale = cameraCurrentZoomScale
        originalWidthAngle = widthAngle
        originalHeightAngle = heightAngle
        originalPositionX = positionX
        originalPositionY = positionY
        
        ////// add gestures
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognized(gesture:)) )
        panGesture.delegate = self //// needed for simultaneous gestures
        _sceneView.addGestureRecognizer(panGesture)
        _view.isOpaque = false
        _sceneView.isOpaque = false
        _view.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func panGestureRecognized(gesture: UIPanGestureRecognizer) {
        if gesture.numberOfTouches == 1 {
            let translation = gesture.translation(in: gesture.view!)
            
            widthAngle = Float(translation.x) / Float(gesture.view!.frame.size.width) + lastWidthAngle
            heightAngle = Float(translation.y) / Float(gesture.view!.frame.size.height) + lastHeightAngle
            
            //  limits
            if (heightAngle >= maxHeightAngleXUp ) {
                heightAngle = maxHeightAngleXUp
                lastHeightAngle = heightAngle
                ///// reset translation when at max height so finger slide reacts immediately
                gesture.setTranslation(CGPoint(x: translation.x, y: 0.0), in: self.view())
            }
            if (heightAngle <= maxHeightAngleXDown ) {
                heightAngle = maxHeightAngleXDown
                lastHeightAngle = heightAngle
                ///// reset translation when at min height so finger slide reacts immediately
                gesture.setTranslation(CGPoint(x: translation.x, y: 0.0), in: self.view())
            }
            //// rotate camera smootly to new angle
            cameraOrbitStart.eulerAngles.y = Float(-2 * M_PI) * widthAngle
            cameraOrbitStart.eulerAngles.x = Float(-M_PI) * heightAngle
        }
        else { // when gesture ends or another finger touches screen, save the rotation
            cameraOrbitStart.eulerAngles.y = Float(-2 * M_PI) * originalWidthAngle
            cameraOrbitStart.eulerAngles.x = Float(-M_PI) * originalHeightAngle
            cameraOrbitStart.position = SCNVector3(x: 0, y: 0, z: Float(originalCameraZoomScale))
            cameraCurrentZoomScale = originalCameraZoomScale
            positionX = 0.0
            positionY = 0.0
            lastPositionX = 0.0
            lastPositionY = 0.0
            lastWidthAngle = originalWidthAngle
            lastHeightAngle = originalHeightAngle
        }
    }
    
    //smooth gestures, called by SCNSceneRendererDelegate
    func updatePositions() {
        /// pan
        let lerpY = (cameraOrbitStart.eulerAngles.y - cameraOrbitFinal.eulerAngles.y) * 0.5
        let lerpX = (cameraOrbitStart.eulerAngles.x - cameraOrbitFinal.eulerAngles.x) * 0.5
        cameraOrbitFinal.eulerAngles.y += lerpY
        cameraOrbitFinal.eulerAngles.x += lerpX
    }
    
}

extension ModelView : SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
        updatePositions()
    }
}


