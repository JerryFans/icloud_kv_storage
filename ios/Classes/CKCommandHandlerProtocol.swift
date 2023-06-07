#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif

enum CKCommandType: String {
    case DELETE_VALUE
    case GET_VALUE
    case SAVE_VALUE
    case EMPTY = ""
}

protocol CKCommandHandlerProtocol {
    var COMMAND_NAME: CKCommandType { get }
    func evaluateExecution(command: String) -> Bool
    func handle(command: String, arguments: Dictionary<String, Any>, result: @escaping FlutterResult) -> Void
}
