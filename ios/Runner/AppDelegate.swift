import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application: UIApplication,
             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
                 Messaging.messaging().apnsToken = deviceToken
                 print("Token: \(deviceToken)")
                 super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
             }
}
