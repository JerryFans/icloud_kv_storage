import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icloud_kv_storage/icloud_kv_storage_method_channel.dart';

void main() {
  MethodChannelICloudKvStorage platform = MethodChannelICloudKvStorage();
  const MethodChannel channel = MethodChannel('icloud_kv_storage');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
