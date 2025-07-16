import 'package:flutter/foundation.dart';

import 'securx_platform_interface.dart';

class Securx {
  /// The application ID (package name) of your app.
  final String applicationID;

  /// Manages the clipboard protection state for your UI to listen to.
  ///
  /// `true` means copy/paste should be disabled.
  final ValueNotifier<bool> isClipboardProtected = ValueNotifier(false);

  /// Initializes the Securx plugin.
  ///
  /// - [applicationID] is your app's package name and is **required**.
  /// - [initialScreenshotProtection] determines if screenshot protection is active on startup. Defaults to `false`.
  /// - [initialClipboardProtection] sets the initial state for clipboard protection. Defaults to `false`.
  Securx({
    required this.applicationID,
    bool initialScreenshotProtection = false,
    bool initialClipboardProtection = false,
  }) {
    // Set initial protection states from the constructor
    setScreenshotProtection(enabled: initialScreenshotProtection);
    setClipboardProtection(enabled: initialClipboardProtection);
  }

  /// Toggles screenshot and screen recording protection.
  ///
  /// Pass `true` to **enable** protection (disable screenshots).
  /// Pass `false` to **disable** protection (allow screenshots).
  /// This will clear [WindowManager.LayoutParams.FLAG_SECURE] flag on the
  /// current activity, which will allow the device to take screenshot/ screenrecording or screen sharing.
  ///
  /// It uses [ScreenProtectorKit] to enable the screenshot on iOS
  ///
  /// Note that this is a best effort and may not work on all devices or platforms.
  Future<void> setScreenshotProtection({required bool enabled}) {
    if (enabled) {
      return SecurxPlatform.instance.disableScreenshot();
    } else {
      return SecurxPlatform.instance.enableScreenshot();
    }
  }

  /// Toggles the state for clipboard (copy/paste) protection.
  ///
  /// Pass `true` to **enable** protection (disable copy/paste).
  /// Pass `false` to **disable** protection (allow copy/paste).
  ///
  /// This updates the [isClipboardProtected] notifier, which you can use in your UI.
  void setClipboardProtection({required bool enabled}) {
    isClipboardProtected.value = enabled;
  }

  /// Checks if the app is cloned (Android only).
  ///
  /// This uses the `applicationID` provided during initialization.
  Future<bool?> get isAppCloned {
    return SecurxPlatform.instance.isAppCloned(applicationID: applicationID);
  }

  /// Gets the current platform version.
  ///
  /// Returns a string representing the platform version if successful, otherwise
  /// returns null.
  Future<String?> get getPlatformVersion =>
      SecurxPlatform.instance.getPlatformVersion();

  /// Checks if the device is Rooted for Android
  /// Checks if the device is Jailbroken for iOS
  /// Returns a boolean indicating whether the device is rooted/jailbroken.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isDeviceRooted => SecurxPlatform.instance.isDeviceRooted();

  /// Checks if the device is safe for your app to run on.
  ///
  /// It checks for [isDeviceRooted/jailbroken]  devices,
  /// whether the app is running in [isDebuggingModeEnable],
  /// check whether [isDeveloperModeEnabled]on device,
  /// whether the App is running on [isEmulator],
  /// [isVpnEnabled],
  /// and whether the app is cloned.
  /// Returns a boolean after evaluatng all these scenarios to determine whether the device is safe for your app to run on.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isDeviceSafe => SecurxPlatform.instance.isDeviceSafe();

  /// Checks if the device is in debugging mode.
  ///
  /// Returns a boolean indicating whether debugging mode is enabled.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isDebuggingModeEnabled =>
      SecurxPlatform.instance.isDebuggingModeEnable();

  /// Checks if the device developer mode (Only works on Android)
  ///
  /// Returns a boolean indicating whether developer mode is enabled.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isDeveloperModeEnabled =>
      SecurxPlatform.instance.isDeveloperModeEnabled();

  /// Checks if the device is an emulator.
  ///
  /// Returns a boolean indicating whether the device is an emulator.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isEmulator => SecurxPlatform.instance.isEmulator();

  /// Checks if a VPN is enabled.
  ///
  /// Returns a boolean indicating whether a VPN is enabled.
  /// If the platform does not support this operation, it returns null.
  Future<bool?> get isVpnEnabled => SecurxPlatform.instance.isVpnEnabled();
  Future<bool?> get isDebuggerAttached =>
      SecurxPlatform.instance.isDebuggerAttached();
}
