import 'dart:async';
import 'dart:io';

import 'package:flutter_app_guard/app_guard_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_guard_platform_interface.dart';

/// An implementation of [AppGuardPlatform] that uses method channels.
class MethodChannelAppGuard extends AppGuardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_app_guard');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> isDeviceRooted() async {
    final rooted = await methodChannel.invokeMethod<bool>('isDeviceRooted');
    return rooted;
  }

  @override
  Future<bool?> isDeviceSafe() async {
    final safe = await methodChannel.invokeMethod<bool>('isDeviceSafe');
    return safe;
  }

  @override
  Future<bool?> isDebuggingModeEnable() async {
    final usbDebug = await methodChannel.invokeMethod<bool>('isDebuggingModeEnable');
    return usbDebug;
  }

  @override
  Future<bool?> isDeveloperModeEnabled() async {
    final developerMode = await methodChannel.invokeMethod<bool>('isDeveloperModeEnabled');
    return developerMode;
  }

  @override
  Future<bool?> isEmulator() async {
    final emulator = await methodChannel.invokeMethod<bool>('isEmulator');
    return emulator;
  }

  @override
  Future<bool?> isVpnEnabled() async {
    try {
      final interfaces = await NetworkInterface.list();

      return interfaces.any((interface) {
        return commonVpnInterfaceNamePatterns.any((pattern) {
          if (Platform.isIOS &&
              (interface.name.toLowerCase().contains('ipsec') ||
                  interface.name.toLowerCase().contains('utun6') ||
                  interface.name.toLowerCase().contains('ikev2') ||
                  interface.name.toLowerCase().contains('l2tp'))) {
            return false;
          }
          return interface.name.toLowerCase().contains(pattern);
        });
      });
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> disableScreenshot() async {
    await methodChannel.invokeMethod<void>('disableScreenshot');
  }

  @override
  Future<void> enableScreenshot() async {
    await methodChannel.invokeMethod<void>('enableScreenshot');
  }

  @override
  Future<bool?> isDebuggerAttached() async {
    final rooted = await methodChannel.invokeMethod<bool>('isDebuggerAttached');
    return rooted;
  }

  @override
  Future<bool?> isAppCloned({required String applicationID}) async {
    // Pass the applicationID to the native side.
    final isCloned = await methodChannel.invokeMethod<bool>('isAppCloned', {
      'applicationID': applicationID,
    });
    return isCloned;
  }
}
