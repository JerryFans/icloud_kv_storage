// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.
import 'icloud_kv_storage_platform_interface.dart';

const String kCloudKitKeyValueUpdate = "icloud_key_update";

typedef OnCloudKitKVUpdateCallBackFuture = Function(Map<String, dynamic> kvMap);

class CKKVStorage {

  /// Return a CallBack when a key value update on other device like Mac iPhone iPad 
  /// which login in the same iCloud Account.
  void onCloudKitKVUpdateCallBack({required OnCloudKitKVUpdateCallBackFuture onCallBack}) {
    ICloudKvStoragePlatform.instance.setNativeCallBack(onCallBack: (route, params) async {
      if (route == kCloudKitKeyValueUpdate) {
        onCallBack(params);
      }
      return "";
    },);
  }

  /// Save a new entry to CloudKit using a key and value.
  /// The key is required.
  /// The value if null, will be delete the value of this key.
  /// If key not empty the task result must be true.
  Future<void> writeString({required String key,required String? value}) async {
    if (value == null) {
      return delete(key);
    }
    return ICloudKvStoragePlatform.instance.write(key: key, value: value);
  }
  
  /// Query a value from CloudKit by key.
  /// Returns a string [string] with the saved value if exist.
  /// This can be null if the key was not found.
  Future<String?> getString(String key) async {
   return ICloudKvStoragePlatform.instance.read(key: key);
  }

  /// Delete a value from CloudKit by key.
  /// If key not empty the task result must be true.
  Future<void> delete(String key) async {
    return ICloudKvStoragePlatform.instance.delete(key: key);
  }

  String getRealKey(String key) {
    return ICloudKvStoragePlatform.instance.getRealKey(key);
  }
}
