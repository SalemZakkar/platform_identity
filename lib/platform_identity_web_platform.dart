import 'dart:convert';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:http/http.dart' as http;
import 'package:platform_identity/platform_identity_platform.dart';
import 'package:web/web.dart' as web;

class PlatformIdentityWebPlatform extends PlatformIdentityPlatform {
  Future<Map<String, dynamic>> getVersionMap() async {
    final baseUrl = web.window.document.baseURI;
    final url = "${baseUrl}version.json";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  static void registerWith(Registrar registrar) {
    PlatformIdentityPlatform.instance = PlatformIdentityWebPlatform();
  }

  @override
  Future<void> init() async {
    var res = await getVersionMap();
    appVersion = res['version'];
  }

  @override
  String getAppVersion() {
    return appVersion;
  }
}
