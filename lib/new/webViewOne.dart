import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/req.dart';

import 'state.dart';

class WebViewOne extends StatefulWidget {
  const WebViewOne(
      {Key? key,
      required this.payload,
      required this.onSuccess,
      required this.onCancel})
      : super(key: key);
  final PayloadModel payload;

  final ValueSetter<Map> onSuccess;
  final ValueSetter<Map> onCancel;

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
                    gestureRecognizers:
                        [Factory(() => EagerGestureRecognizer())].toSet(),
                    initialUrlRequest: URLRequest(
                        url: createUri(widget.payload, webViewState)),
                    initialOptions: options,
                    pullToRefreshController: pullToRefreshController,

                    // initialData: InAppWebViewInitialData(data: ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      webViewState.setControllerOne(controller);

                      controller.addJavaScriptHandler(
                          handlerName: 'success',
                          callback: (_) {
                            webViewState.setResponse(_);
                            if (webViewState.reportLink == "about:blank") {
                              print(_[0]);
                              if (_[0].toString().contains('code')) {
                                widget.onSuccess(jsonDecode(_[0]));
                                // webViewController!.loadUrl(
                                //     urlRequest: URLRequest(
                                //         url: Uri.parse(_[0]
                                //             .toString()
                                //             .substring(1, _[0].length - 1))));
                              } else {
                                webViewState.setUrl(_[0]
                                    .toString()
                                    .substring(1, _[0].length - 1));
                                webViewState.switchView(false);

                                webViewState.controller!.loadUrl(
                                    urlRequest: URLRequest(
                                        url: Uri.parse(
                                            webViewState.currentUrl)));
                              }
                            } else {
                              widget.onSuccess(jsonDecode(_[0]));
                              // print(jsonDecode(_[0]));
                            }
                          });
                      controller.addJavaScriptHandler(
                          handlerName: 'failure',
                          callback: (_) {
                            webViewState.setResponse(_);

                            if (webViewState.reportLink == "about:blank") {
                              webViewState.setUrl(_[0]
                                  .toString()
                                  .substring(1, _[0].length - 1));
                              webViewState.switchView(false);
                            } else {
                              widget.onCancel(jsonDecode(_[0]));
                              Navigator.pop(context);
                              // print(jsonDecode(_[0]));
                            }
                          });
                    },

                    onLoadStart: (controller, url) {
                      webViewState.setProgress(true);
                    },
                    onLoadStop: (controller, url) async {
                      webViewState.setProgress(false);
                    },

                    onLoadError: (controller, url, code, message) {
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

                    onConsoleMessage: (controller, consoleMessage) {},
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
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
