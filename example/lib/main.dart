
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:platform_identity/platform_identity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlatformIdentity.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  String? k = await PlatformIdentity.getAppVersion();
                  log(k);
                },
                child: Text('get app version'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  String? k = await PlatformIdentity.getPlatformVersion();
                  log(k);
                },
                child: Text('get android version'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  String? k = await PlatformIdentity.getPackageName();
                  log(k);
                },
                child: Text('get package name'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  String? k = await PlatformIdentity.getSha1();
                  log(k);
                },
                child: Text('get sha1 '),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  String? k = await PlatformIdentity.getSha256();
                  log(k);
                },
                child: Text('get sha256 version'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
