import 'package:flutter/services.dart';

import 'usb_storage_path_platform_interface.dart';

class UsbStoragePath {
  static const MethodChannel _channel = MethodChannel('usb_storage_path');

  Future<String?> getUsbStoragePath() async {
    try {
      final String? path = await _channel.invokeMethod('getUsbStoragePath');
      return path;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
