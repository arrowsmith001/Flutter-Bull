import UIKit
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate
//                  // , FlutterPluginRegistry
//{
//
//  var window: UIWindow?
//
//  func application(_ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions:
//        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//    GeneratedPluginRegistrant.register(with: self)
//    FirebaseApp.configure()
//    return true
//
//  }
//}
