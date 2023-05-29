import 'dart:math';

import 'package:bgjdf/splash.dart';
import 'package:bgjdf/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:async';

// Main
String? userAgent;

Future<void> main() async {
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); // 隐藏状态栏
}

String skipLastChar(String text) {
  return text.substring(0, max(0, text.length - 1));
}

// MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        }

        // Main
        else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: WebViewApp(key: UniqueKey()),
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
          );
        }
      },
    );
  }
}
