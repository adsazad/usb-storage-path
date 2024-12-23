import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'usb_storage_path_platform_interface.dart';

/// An implementation of [UsbStoragePathPlatform] that uses method channels.
class MethodChannelUsbStoragePath extends UsbStoragePathPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('usb_storage_path');

  Future<String?> getUsbStoragePath() async {
    try {
      final String? path = await methodChannel.invokeMethod('getUsbStoragePath');
      return path;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
