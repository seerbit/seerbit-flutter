import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/req.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

class WebViewOne extends StatefulWidget {
  const WebViewOne({Key? key, required this.payload}) : super(key: key);
  final PayloadModel payload;

  @override
  _WebViewOneState createState() => new _WebViewOneState();
}

class _WebViewOneState extends State<WebViewOne> {
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
  bool loader = true;

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
    WebViewState webViewState = Provider.of<WebViewState>(context);

    return WillPopScope(
        onWillPop: () async {
          webViewController!.goBack();
          return false;
        },
        child: SafeArea(
            child: Column(children: <Widget>[
          WillPopScope(
            onWillPop: () async {
              webViewController!.goBack();
              return false;
            },
            child: Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest:
                        URLRequest(url: createUri(widget.payload)),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,
                    // initialData: InAppWebViewInitialData(data: ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;

                      controller.addJavaScriptHandler(
                          handlerName: 'success',
                          callback: (_) {
                            print(_[0]);
                            print(_);
                            webViewState.setResponse(_);

                            webViewState.setUrl(
                                _[0].toString().substring(1, _[0].length - 1));
                            webViewState.switchView(false);
                            webViewState.controller!.loadUrl(
                                urlRequest: URLRequest(
                                    url: Uri.parse(webViewState.currentUrl)));
                          });
                      controller.addJavaScriptHandler(
                          handlerName: 'failure',
                          callback: (_) {
                            print(_[0]);
                            print(_);
                            webViewState.setResponse(_);
                            webViewState.setUrl(
                                _[0].toString().substring(1, _[0].length - 1));
                            webViewState.switchView(false);
                          });
                    },
                    onLoadStart: (controller, url) {
                      webViewState.setProgress(true);
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
                      webViewState.setProgress(false);
                    },

                    onLoadError: (controller, url, code, message) {
                      webViewState.switchView(true);
                      webViewState.setProgress(false);
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
                      String resp = consoleMessage.toJson().toString();
                      webViewState.setConsole(resp);
                    },
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                  // Center(child: Text(webViewState.consoleLog))
                ],
              ),
            ),
          ),
        ])));
  }
}

PayloadModel model = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    transRef: DateTime.now().toIso8601String(),
    description: "Sneakers",
    fullName: "General Zod",
    country: "NG",
    amount: "10",
    callbackUrl: "https://google.com",
    publicKey: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
    pocketRef: "",
    vendorId: "Freedah");
