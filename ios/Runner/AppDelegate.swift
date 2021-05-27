import UIKit
import Flutter

@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
    
    var flutterResult: FlutterResult?
    override func application(
        
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        GeneratedPluginRegistrant.register(with: self)
        
        //Webview
        weak var registrarWebView = self.registrar(forPlugin: "WebView")
        self.registrar(forPlugin: "WebViewFactory")!.register(
            WebViewFactory(messenger: registrarWebView!.messenger()),
            withId: "com.rare-pair.webview"
        )
        
        //3D View
        weak var registrarModelView = self.registrar(forPlugin: "ModelView")
        self.registrar(forPlugin: "ModelViewFactory")!.register(
            ModelViewFactory(messenger: registrarModelView!.messenger()),
            withId: "com.rare-pair.modelview"
        )
        
        //Try On Shoes NSObject based
//        weak var registrarTryOnShoesView = self.registrar(forPlugin: "TryOnShoesView")
//        self.registrar(forPlugin: "TryOnShoesViewFactory")!.register(
//            TryOnShoesViewFactory(messenger: registrarTryOnShoesView!.messenger()),
//            withId: "com.rare-pair.tryonshoes"
//        )
        
        //Try On Shoes UIViewController based
        let channel = FlutterMethodChannel.init(name: "com.rare_pair.app/try_on_shoes", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if ("setModel" == call.method) {
                self.flutterResult = result
                let tryOnShoesController = TryOnShoes(nibName: "TryOnShoes", bundle: nil)
                tryOnShoesController.model = call.arguments as! String
                let navigationController = UINavigationController(rootViewController: tryOnShoesController)
                navigationController.modalPresentationStyle = .fullScreen
                navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController.navigationBar.shadowImage = UIImage()
                navigationController.navigationBar.backgroundColor = .clear
                navigationController.navigationBar.isTranslucent = true
                controller.present(navigationController, animated: true, completion: nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        });
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
