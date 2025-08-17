import 'package:platform_identity/platform_identity_platform.dart';

export 'package:platform_identity/platform_identity_android_platform.dart';
export 'package:platform_identity/platform_identity_ios_platform.dart'
    if (dart.library.web) 'package:platform_identity/platform_identity_web_platform.dart';

class PlatformIdentity {
  static Future<void> init() => PlatformIdentityPlatform.instance.init();

  static String getPlatformVersion() {
    return PlatformIdentityPlatform.instance.getPlatformVersion();
  }

  static String getAppVersion() {
    return PlatformIdentityPlatform.instance.getAppVersion();
  }

  static String getPackageName() {
    return PlatformIdentityPlatform.instance.getPackageName();
  }

  static String getSha1() {
    return PlatformIdentityPlatform.instance.getSha1();
  }

  static String getSha256() {
    return PlatformIdentityPlatform.instance.getSha256();
  }

  static String getSha1InHex() {
    return PlatformIdentityPlatform.instance.getSha1InHex();
  }
  static String getSha1InHexNoSemicolons() {
    return PlatformIdentityPlatform.instance.getSha1InHexNoSemicolons();
  }
}
