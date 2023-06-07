import 'package:flutter_test/flutter_test.dart';
import 'package:icloud_kv_storage/icloud_kv_storage.dart';
import 'package:icloud_kv_storage/icloud_kv_storage_platform_interface.dart';
import 'package:icloud_kv_storage/icloud_kv_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockICloudKvStoragePlatform
    with MockPlatformInterfaceMixin
    implements ICloudKvStoragePlatform {

  @override
  String getRealKey(String key) {
    throw UnimplementedError();
  }

  @override
  void setNativeCallBack({required GetNativeCallBackFuture onCallBack}) {
    // TODO: implement setNativeCallBack
  }

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> write<T>({required String key, required T value}) {
    // TODO: implement write
    throw UnimplementedError();
  }

  @override
  Future<T?> read<T>({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> clearData() {
    // TODO: implement clearDatabase
    throw UnimplementedError();
  }
}

void main() {
  final ICloudKvStoragePlatform initialPlatform = ICloudKvStoragePlatform.instance;

  test('$MethodChannelICloudKvStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelICloudKvStorage>());
  });
}
