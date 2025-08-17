import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class PlatformIdentityPlatform extends PlatformInterface {
  PlatformIdentityPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformIdentityPlatform _instance = PlatformIdentityPlatform();
  static PlatformIdentityPlatform get instance => _instance;

  static set instance(PlatformIdentityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  late String platformVersion;
  late String sha1;
  late String sha256;
  late String appVersion;
  late String packageName;

  Future<void> init() async {}

  String getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  String getAppVersion() {
    throw UnimplementedError('getAppVersion() has not been implemented.');
  }

  String getPackageName() {
    throw UnimplementedError('getPackageName() has not been implemented.');
  }

  String getSha1() {
    throw UnimplementedError('getSha1() has not been implemented.');
  }

  String getSha1InHex() {
    throw UnimplementedError('getSha1() has not been implemented.');
  }

  String getSha1InHexNoSemicolons() {
    throw UnimplementedError('getSha1() has not been implemented.');
  }

  String getSha256() {
    throw UnimplementedError('getSha256() has not been implemented.');
  }
}
