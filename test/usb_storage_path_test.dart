import 'package:flutter_test/flutter_test.dart';
import 'package:usb_storage_path/usb_storage_path.dart';
import 'package:usb_storage_path/usb_storage_path_platform_interface.dart';
import 'package:usb_storage_path/usb_storage_path_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUsbStoragePathPlatform
    with MockPlatformInterfaceMixin
    implements UsbStoragePathPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UsbStoragePathPlatform initialPlatform = UsbStoragePathPlatform.instance;

  test('$MethodChannelUsbStoragePath is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUsbStoragePath>());
  });

  test('getPlatformVersion', () async {
    UsbStoragePath usbStoragePathPlugin = UsbStoragePath();
    MockUsbStoragePathPlatform fakePlatform = MockUsbStoragePathPlatform();
    UsbStoragePathPlatform.instance = fakePlatform;

    expect(await usbStoragePathPlugin.getPlatformVersion(), '42');
  });
}
