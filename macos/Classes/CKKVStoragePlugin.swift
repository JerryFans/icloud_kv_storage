#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

public class CKKVStoragePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    let channel = FlutterMethodChannel(name: "icloud_kv_storage", binaryMessenger: messenger)
    let instance = CKKVStoragePlugin()
    instance.channel = channel
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
    var channel: FlutterMethodChannel?
    
    public override init() {
        super.init()
        let keyValueStore = NSUbiquitousKeyValueStore.default
        // 监听数据变化
        NotificationCenter.default.addObserver(self, selector: #selector(keyValueStoreDidChange), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: keyValueStore)
        keyValueStore.synchronize()
    }
    
    @objc func keyValueStoreDidChange(notification: Notification) {
        // 处理数据变化
        if let userInfo = notification.userInfo as? [String: Any],
           let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? NSNumber {
           
           var reason = -1
           reason = reasonForChange.intValue
           
           if (reason == NSUbiquitousKeyValueStoreServerChange || reason == NSUbiquitousKeyValueStoreInitialSyncChange) {
              guard let changedKeys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else {
                 return
              }
              let store = NSUbiquitousKeyValueStore.default
              for key in changedKeys {
                let value = store.object(forKey: key)
                self.channel?.invokeMethod("icloud_key_update", arguments: [key:value])
              }
           }
        }
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let callArguments: Dictionary<String, Any> = call.arguments as! Dictionary<String, Any>
    CKGetValueHandler().handle(command: call.method, arguments: callArguments, result: result)
    CKSaveValueHandler().handle(command: call.method, arguments: callArguments, result: result)
    CKDeleteValueHandler().handle(command: call.method, arguments: callArguments, result: result)
  }
}
