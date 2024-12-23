import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'usb_storage_path_method_channel.dart';

abstract class UsbStoragePathPlatform extends PlatformInterface {
  /// Constructs a UsbStoragePathPlatform.
  UsbStoragePathPlatform() : super(token: _token);

  static final Object _token = Object();

  static UsbStoragePathPlatform _instance = MethodChannelUsbStoragePath();

  /// The default instance of [UsbStoragePathPlatform] to use.
  ///
  /// Defaults to [MethodChannelUsbStoragePath].
  static UsbStoragePathPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UsbStoragePathPlatform] when
  /// they register themselves.
  static set instance(UsbStoragePathPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
