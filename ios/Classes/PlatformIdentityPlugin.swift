import Flutter
import UIKit

public class PlatformIdentityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_identity", binaryMessenger: registrar.messenger())
    let instance = PlatformIdentityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {

         case "getPlatformVersion":
             result(UIDevice.current.systemVersion)

         case "getAppVersion":
             if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                 result(version)
             } else {
                 result(FlutterError(code: "UNAVAILABLE",
                                     message: "App version not available",
                                     details: nil))
             }

         case "getIosBundleId":
             if let bundleId = Bundle.main.bundleIdentifier {
                 result(bundleId)
             } else {
                 result(FlutterError(code: "UNAVAILABLE",
                                     message: "Bundle ID not available",
                                     details: nil))
             }

         default:
             result(FlutterMethodNotImplemented)
         }
  }
}
