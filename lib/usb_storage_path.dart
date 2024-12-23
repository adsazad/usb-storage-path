
import 'usb_storage_path_platform_interface.dart';

class UsbStoragePath {
  Future<String?> getPlatformVersion() {
    return UsbStoragePathPlatform.instance.getPlatformVersion();
  }
}
