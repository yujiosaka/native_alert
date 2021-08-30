import Flutter
import UIKit

public class SwiftNativeDialogPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_dialog", binaryMessenger: registrar.messenger())
        let instance = SwiftNativeDialogPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "alert":
            let message = getMessage(call.arguments)
            alert(message, result: result)
        case "confirm":
            let message = getMessage(call.arguments)
            confirm(message, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private var controller: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    private var okText: String {
        return NSLocalizedString("OK", comment: "OK")
    }
    
    private var cancelText: String {
        return NSLocalizedString("Cancel", comment: "Cancel")
    }
    
    private var unavailableError: FlutterError {
        return FlutterError(code: "UNAVAILABLE", message: "Native alert is unavailable", details: nil)
    }
    
    private func getMessage(_ arguments: Any?) -> String {
        return (arguments as! [Any]).first as! String
    }
    
    private func alert(_ message: String, result: @escaping FlutterResult) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: okText, style: .default) { _ in
            result(nil)
        }
        alert.addAction(defaultAction)
        
        guard let controller = controller else {
            result(unavailableError)
            return
        }
        
        controller.present(alert, animated: true)
    }
    
    private func confirm(_ message: String, result: @escaping FlutterResult) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: okText, style: .default) { _ in
            result(true)
        }
        let cancelAction = UIAlertAction(title: cancelText, style: .cancel) { _ in
            result(false)
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        guard let controller = controller else {
            result(unavailableError)
            return
        }
        
        controller.present(alert, animated: true)
    }
}
