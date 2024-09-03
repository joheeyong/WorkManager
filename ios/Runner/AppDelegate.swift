import Flutter
import UIKit
import workmanager
import home_widget
import BackgroundTasks

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      GeneratedPluginRegistrant.register(with: self)
      
      WorkmanagerPlugin.registerTask(withIdentifier: "work.taskName")
      
      WorkmanagerPlugin.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
      }
      
      if #available(iOS 17, *) {
        HomeWidgetBackgroundWorker.setPluginRegistrantCallback { registry in
          GeneratedPluginRegistrant.register(with: registry)
        }
      }

      UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60 * 15))

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
