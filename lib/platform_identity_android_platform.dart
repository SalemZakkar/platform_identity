import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform_identity/platform_identity_platform.dart';

class PlatformIdentityAndroidPlatform extends PlatformIdentityPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_identity');

  static void registerWith() {
    PlatformIdentityPlatform.instance = PlatformIdentityAndroidPlatform();
  }

  @override
  Future<void> init() async {
    packageName =
        (await (methodChannel.invokeMethod<String>('getPackageName')))!;
    appVersion = (await (methodChannel.invokeMethod<String>('getAppVersion')))!;
    sha1 = (await (methodChannel.invokeMethod<String>('getSHA1')))!;
    sha256 = (await (methodChannel.invokeMethod<String>('getSHA256')))!;
    platformVersion =
        (await methodChannel.invokeMethod<String>('getPlatformVersion'))!;
  }

  @override
  String getPlatformVersion() {
    return platformVersion;
  }

  @override
  String getAppVersion() {
    return appVersion;
  }

  @override
  String getPackageName() {
    return packageName;
  }

  @override
  String getSha1() {
    return sha1;
  }

  @override
  String getSha256() {
    return sha256;
  }

  @override
  String getSha1InHex() {
    Uint8List bytes = base64Decode(sha1);
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');
  }

  @override
  String getSha1InHexNoSemicolons() {
    Uint8List bytes = base64Decode(sha1);
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
