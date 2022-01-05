import 'dart:async';
import 'dart:io';

import 'package:exampletwo/payload.dart';
import 'package:exampletwo/req.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Official InAppWebView website")),
          body: SafeArea(
              child: Column(children: <Widget>[
            // TextField(
            //   decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
            //   controller: urlController,
            //   keyboardType: TextInputType.url,
            //   onSubmitted: (value) {
            //     var url = Uri.parse(value);
            //     if (url.scheme.isEmpty) {
            //       url = Uri.parse("https://www.google.com/search?q=" + value);
            //     }
            //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
            //   },
            // ),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: createUri()),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    // initialData: InAppWebViewInitialData(data: ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;

                      // controller.addJavaScriptHandler(
                      //     handlerName: 'failure',
                      //     callback: (_) {
                      //       print(_);
                      //       controller.loadUrl(
                      //           urlRequest: URLRequest(url: Uri.parse(_[0])));
                      //     });
                      // controller.addJavaScriptHandler(
                      //     handlerName: 'success',
                      //     callback: (_) {
                      //       print(_);
                      //       controller.loadUrl(
                      //           urlRequest: URLRequest(url: Uri.parse(_[0])));
                      //     });
                      // controller.addWebMessageListener(WebMessageListener(
                      //     jsObjectName: "Success",
                      //     allowedOriginRules: Set.from(['*']),
                      //     onPostMessage:
                      //         (message, sourceOrigin, isMainFrame, replyProxy) {
                      //       print(message);
                      //     }));
                      // controller.addWebMessageListener(WebMessageListener(
                      //     jsObjectName: "Failure",
                      //     onPostMessage:
                      //         (message, sourceOrigin, isMainFrame, replyProxy) {
                      //       print(message);
                      //     }));
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;

                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunch(url)) {
                          // Launch the App
                          await launch(
                            url,
                          );
                          // and cancel the request
                          return NavigationActionPolicy.CANCEL;
                        }
                      }

                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) async {
                      pullToRefreshController.endRefreshing();
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {
                        pullToRefreshController.endRefreshing();
                      }
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = this.url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      String resp = consoleMessage.toJson()['message'];
                      if (resp.contains('http')) {
                        controller.loadUrl(
                            urlRequest: URLRequest(url: Uri.parse(resp)));
                      } else {
                        print("Else: $resp");
                      }
                      print("Console: ${consoleMessage.toJson()}");
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            ),
          ]))),
    );
  }
}

PayloadModel model = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    description: "Sneakers",
    fullName: "General Zod",
    country: "NG",
    amount: "10",
    callbackUrl: "https://google.com",
    publicKey: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
    pocketRef: "",
    vendorId: "Freedah");
