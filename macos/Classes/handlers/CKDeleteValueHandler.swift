#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

import CloudKit

class CKDeleteValueHandler: CKCommandHandlerProtocol {
    
    var COMMAND_NAME: CKCommandType = .DELETE_VALUE
    
    func evaluateExecution(command: String) -> Bool {
        return CKCommandType(rawValue: command) == COMMAND_NAME
    }
    
    func handle(command: String, arguments: Dictionary<String, Any>, result: @escaping FlutterResult) {
        if (!evaluateExecution(command: command)) {
            return
        }
        
        if let key = arguments["key"] as? String {
            let store = NSUbiquitousKeyValueStore.default
            store.removeObject(forKey: key)
            result(true)
        } else {
            result(FlutterError.init(code: "Error", message: "Cannot pass key parameter", details: nil))
        }
    }
    
    
}
