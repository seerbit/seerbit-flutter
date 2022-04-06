import 'dart:convert';

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
  final ValueSetter<dynamic> onCancel;

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
          webViewController?.goBack();
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
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      webViewState.setControllerOne(controller);
                      controller.addJavaScriptHandler(
                          handlerName: 'success',
                          callback: (_) {
                            webViewState.setResponse(_);
                            print('Success 0');
                            // print('*' * 400);
                            // print(webViewState.reportLink);
                            // print(_.toString());
                            // print('*' * 400);
                            if (webViewState.reportLink == "about:blank") {
                              print('Success 1');
                              if (_[0].toString().contains('code')) {
                                print('Success 2');
                                widget.onSuccess(jsonDecode(_[0]));
                              } else {
                                print('Success 3');
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
                              print('Success 4');
                              widget.onSuccess(jsonDecode(_[0]));
                              if (widget.payload.closeOnSuccess ?? false) {
                                Navigator.pop(context);
                              }
                            }
                          });
                      controller.addJavaScriptHandler(
                          handlerName: 'failure',
                          callback: (_) {
                            print('Failure 0');
                            widget.onCancel(jsonDecode(_[0]));
                            Navigator.pop(context);
                            // Navigator.pop(context);
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
                      Navigator.pop(context);
                    },
                    onProgressChanged: (controller, progress) {
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = this.url;
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      print('Update History' * 24);
                      print(url);
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                      webViewState.setReportLink('about:blank');
                    },
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
