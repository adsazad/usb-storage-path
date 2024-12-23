import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usb_storage_path/usb_storage_path_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUsbStoragePath platform = MethodChannelUsbStoragePath();
  const MethodChannel channel = MethodChannel('usb_storage_path');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}