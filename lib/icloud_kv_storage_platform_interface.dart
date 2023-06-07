import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'icloud_kv_storage_method_channel.dart';

abstract class ICloudKvStoragePlatform extends PlatformInterface {
  /// Constructs a ICloudKvStoragePlatform.
  ICloudKvStoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static ICloudKvStoragePlatform _instance = MethodChannelICloudKvStorage();

  /// The default instance of [ICloudKvStoragePlatform] to use.
  ///
  /// Defaults to [MethodChannelIcloudKvStorage].
  static ICloudKvStoragePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ICloudKvStoragePlatform] when
  /// they register themselves.
  static set instance(ICloudKvStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  String getRealKey(String key) {
    throw UnimplementedError('getRealKey()) has not been implemented.');
  }

  void setNativeCallBack({required GetNativeCallBackFuture onCallBack}) {
    
  }

  Future<void> write<T>({required String key,required T value}) {
    throw UnimplementedError('write({required String key,required String value}) has not been implemented.');
  }

  Future<T?> read<T>({required String key}) {
    throw UnimplementedError('read({required String key}) has not been implemented.');
  }

  Future<void> delete({required String key}) {
    throw UnimplementedError('delete({required String key}) has not been implemented.');
  }
}
