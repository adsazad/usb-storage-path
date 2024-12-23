package com.sarabit.usbstoragepath.usb_storage_path;

import androidx.annotation.NonNull;

import android.content.Context;
import android.os.Build;
import android.os.storage.StorageManager;
import android.os.storage.StorageVolume;
import android.util.Log;

import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * UsbStoragePathPlugin
 */
public class UsbStoragePathPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "usb_storage_path");
        channel.setMethodCallHandler(this);

        // Initialize context here
        context = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getUsbStoragePath")) {
            String usbPath = getUsbStoragePath();
            if (usbPath != null) {
                result.success(usbPath);
            } else {
                result.error("UNAVAILABLE", "USB storage path not found", null);
            }
        } else {
            result.notImplemented();
        }
    }

    public String getUsbStoragePath() {
        if (context == null) {
            Log.e("UsbStoragePathPlugin", "Context is null, cannot fetch USB storage path.");
            return null;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            StorageManager storageManager = (StorageManager) context.getSystemService(Context.STORAGE_SERVICE);
            List<StorageVolume> storageVolumes = storageManager.getStorageVolumes();

            for (StorageVolume volume : storageVolumes) {
                if (volume.isRemovable() && volume.getState().equals(android.os.Environment.MEDIA_MOUNTED)) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                        try {
                            return volume.getDirectory().getPath();
                        } catch (Exception e) {
                            Log.e("UsbStoragePathPlugin", "Error fetching USB path: ", e);
                        }
                    } else {
                        try {
                            // Fallback for older APIs
                            return volume.toString();
                        } catch (Exception e) {
                            Log.e("UsbStoragePathPlugin", "Error accessing volume information: ", e);
                        }
                    }
                }
            }
        } else {
            Log.e("UsbStoragePathPlugin", "API level not supported for USB storage detection.");
        }
        return null;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
