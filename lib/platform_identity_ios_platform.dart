import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform_identity/platform_identity_platform.dart';

class PlatformIdentityIosPlatform extends PlatformIdentityPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_identity');

  static void registerWith() {
    PlatformIdentityPlatform.instance = PlatformIdentityIosPlatform();
  }

  @override
  Future<void> init() async {
    packageName =
        (await (methodChannel.invokeMethod<String>('getIosBundleId')))!;
    appVersion = (await (methodChannel.invokeMethod<String>('getAppVersion')))!;
    platformVersion =
        (await methodChannel.invokeMethod<String>('getPlatformVersion'))!;
  }

  @override
  String getPackageName() {
    return packageName;
  }

  @override
  String getAppVersion() {
    return appVersion;
  }

  @override
  String getPlatformVersion() {
    return platformVersion;
  }
}
