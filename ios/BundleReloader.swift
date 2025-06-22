@objc(BundleReloader)
class BundleReloader: NSObject {
  @objc static func reloadBridge() {
    DispatchQueue.main.async {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window,
            let factory = appDelegate.reactNativeFactory else {
        print("❌ Could not access AppDelegate or window")
        return
      }

      print("🔁 Restarting React Native with updated JS bundle")
      factory.startReactNative(
        withModuleName: "DemoApp",
        in: window,
        launchOptions: nil
      )
    }
  }

  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
}

