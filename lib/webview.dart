import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'draggable_floating_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

final GlobalKey _parentKey = GlobalKey();

class _WebViewAppState extends State<WebViewApp> {
  // late final WebViewController controller;
  bool loadstop = false;
  bool isClicked = false;
  InAppWebViewController? webController;

  @override
  void initState() {
    SmartDialog.showLoading();
    super.initState();
    var systemVersion = getSystemVersion();
    print(systemVersion);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
      bottom: MediaQuery.of(context).padding.bottom,
    );
    return SafeArea(
        child: Stack(
      key: _parentKey,
      children: [
        WillPopScope(
            onWillPop: () async {
              if (webController != null) {
                if (await webController!.canGoBack()) {
                  webController!.goBack();
                  return false;
                }
              }
              return true;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  loadstop == false
                      ? Container(
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        )
                      : Container(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: WebUri('https://gold948.com/')),
                          initialSettings: InAppWebViewSettings(
                              useHybridComposition: true,
                              domStorageEnabled: true,
                              databaseEnabled: true,
                              userAgent: Platform.isIOS
                                  ? 'Mozilla/5.0 (iPhone; U; iOS ${getSystemVersion()}; iPhone SDK built for x86 Build/RSR1.210210.001.A1; Version_1.0.0)'
                                  : 'Dalvik/2.1.0 (Linux; U; Android 13; Android SDK built for x86 Build/RSR1.210210.001.A1; Version_1.0.0)',
                              transparentBackground: false,
                              mediaPlaybackRequiresUserGesture: false,
                              allowUniversalAccessFromFileURLs: true,
                              allowsInlineMediaPlayback: true,
                              javaScriptCanOpenWindowsAutomatically: true,
                              javaScriptEnabled: true,
                              preferredContentMode:
                                  UserPreferredContentMode.MOBILE),
                          onLoadStart:
                              (InAppWebViewController? controller, Uri? url) {
                            print(url);
                            if (url?.toString() ==
                                'https://line.me/R/ti/p/@588win') {
                              // 在此處執行您想要的操作，例如阻止跳轉或導向其他頁面
                              controller?.stopLoading();
                              _launchUrl('line://ti/p/@588win');
                            }
                            if (url?.toString() ==
                                'https://direct.lc.chat/9279400/') {
                              // 在此處執行您想要的操作，例如阻止跳轉或導向其他頁面
                              controller?.stopLoading();
                              _launchUrl('https://direct.lc.chat/9279400/');
                            }
                            if (url?.toString() ==
                                'https://instagram.com/gdf99_jdf88?utm_medium=copy_link') {
                              // 在此處執行您想要的操作，例如阻止跳轉或導向其他頁面
                              controller?.stopLoading();
                              _launchUrl(
                                  'https://instagram.com/gdf99_jdf88?utm_medium=copy_link');
                            }
                          },
                          onLoadStop:
                              (InAppWebViewController? controller, Uri? url) {
                            // print(url);
                            setState(() {
                              loadstop = true;
                            });
                            SmartDialog.dismiss();
                          },
                          onWebViewCreated:
                              (InAppWebViewController? controller) {
                            webController = controller;
                            setState(() {});
                            SmartDialog.showLoading();
                          }),
                    ),
                  ),
                ],
              ),
            )),
        DraggableFloatingActionButton(
          initialOffset: const Offset(0, 0),
          parentKey: _parentKey,
          onPressed: () async {
            // _showAttach(context);
          },
          child: Container(
            width: 65,
            height: 65,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isClicked
                  ? Color.fromRGBO(1, 152, 78, 1)
                  : Color.fromRGBO(1, 152, 78, 1).withOpacity(0.5),
            ),
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                setState(() {
                  isClicked = true;
                });
              },
              onTapUp: (TapUpDetails details) {
                _showAttach(context);
                setState(() {
                  isClicked = false;
                });
              },
              onTapCancel: () {
                setState(() {
                  isClicked = false;
                });
              },
              child: ClipOval(
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset(
                    "assets/images/splash.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  String getSystemVersion() {
    var osVersion = Platform.operatingSystemVersion;
    var versionRegex = RegExp(r'(\d+)\.(\d+)'); // 正则表达式匹配主要版本号和次要版本号
    var matches = versionRegex.firstMatch(osVersion);

    if (matches != null && matches.groupCount >= 2) {
      var majorVersion = matches.group(1);
      var minorVersion = matches.group(2);
      var patchVersion = '0';

      return '${majorVersion}_${minorVersion}_$patchVersion';
    }

    return '';
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch');
    }
  }

  void _showAttach(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: Text('提示'),
          content: Text('是否返回，金大發娛樂城！'),
          actions: [
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(ctx).pop('取消');
              },
            ),
            CupertinoDialogAction(
              child: Text('立即前往'),
              onPressed: () {
                Navigator.of(ctx).pop('取消');
                SmartDialog.showLoading();
                webController?.loadUrl(
                    urlRequest: URLRequest(
                  url: WebUri('https://gold948.com/'),
                ));
              },
              isDestructiveAction: true,
            ),
          ],
        );
      },
    ).then((value) {
      // if (value != null) {
      //   print(value);
      //   setState(() {
      //     // 执行相关操作
      //   });
      // }
    });
  }
}
