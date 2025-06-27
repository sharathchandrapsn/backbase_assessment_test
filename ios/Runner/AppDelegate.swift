import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var isFlashOn = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.example.deviceinfo",
                                           binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { (call, result) in
            switch call.method {
            case "getBatteryLevel":
                UIDevice.current.isBatteryMonitoringEnabled = true
                let batteryLevel = Int(UIDevice.current.batteryLevel * 100)
                result(batteryLevel)
            case "getDeviceName":
                result(UIDevice.current.name)
            case "getOSVersion":
                result(UIDevice.current.systemVersion)
            case "toggleFlashlight":
                self.toggleFlashlight()
                result(nil)
            case "getGyroscope":
                let mockData: [String: Double] = ["x": 0.1, "y": 0.2, "z": 0.3]
                result(mockData)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }

        do {
            try device.lockForConfiguration()
            if isFlashOn {
                device.torchMode = .off
            } else {
                try device.setTorchModeOn(level: 1.0)
            }
            isFlashOn.toggle()
            device.unlockForConfiguration()
        } catch {
            print("Flashlight error: \(error)")
        }
    }
}
