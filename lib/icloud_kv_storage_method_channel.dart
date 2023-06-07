import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'icloud_kv_storage_platform_interface.dart';

typedef GetNativeCallBackFuture = Future Function(String route, Map<String, dynamic> params);

/// An implementation of [IcloudKvStoragePlatform] that uses method channels.
class MethodChannelICloudKvStorage extends ICloudKvStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('icloud_kv_storage');

  static const String _prefix = 'flutter.';

  @override
  String getRealKey(String key) {
    return "$_prefix$key";
  }

  @override
  void setNativeCallBack({required GetNativeCallBackFuture onCallBack}) {
    Future<dynamic> platformCallHandler(MethodCall call) async {
      return await onCallBack(call.method, Map<String, dynamic>.from(call.arguments));
    }
    methodChannel.setMethodCallHandler(platformCallHandler);
  }

  @override
  Future<void> write<T>({required String key, required T value}) async {

    if (!Platform.isIOS && !Platform.isMacOS) {
      return;
    }

    if (key.isEmpty) {
      return;
    }

    await methodChannel.invokeMethod('SAVE_VALUE',
            {"key": "$_prefix$key", "value": value});

  }

  @override
  Future<T?> read<T>({required String key}) async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return null;
    }

    if (key.isEmpty) {
      return null;
    }

    T? value = await (methodChannel
        .invokeMethod('GET_VALUE', {"key": "$_prefix$key"}));
        
    return value;
  }

  @override
  Future<void> delete({required String key}) async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return;
    }

    if (key.isEmpty) {
      return;
    }

    await methodChannel.invokeMethod('DELETE_VALUE', {
          "key": "$_prefix$key",
        });
  }
}
