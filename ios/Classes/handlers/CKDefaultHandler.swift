#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

class CKDefaultHandler: CKCommandHandlerProtocol {
    
    var COMMAND_NAME: CKCommandType = .EMPTY
    
    func evaluateExecution(command: String) -> Bool {
        return true
    }
    
    func handle(command: String, arguments: Dictionary<String, Any>, result: @escaping FlutterResult) {
        result(FlutterError.init(code: "Error", message: "Not implemented", details: nil))
    }
    
    
}
