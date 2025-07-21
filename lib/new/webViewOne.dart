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
        useShouldOverrideUrlLoading: false,
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
    child: Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              gestureRecognizers: {
                Factory(() => EagerGestureRecognizer()),
              },
              initialUrlRequest: URLRequest(
                url: WebUri(
                  createUri(widget.payload, webViewState).toString(),
                ),
              ),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
                webViewState.setControllerOne(controller);
                controller.addJavaScriptHandler(
                  handlerName: 'success',
                  callback: (_) {
                    webViewState.setResponse(_);
                    if (webViewState.reportLink == "about:blank") {
                      if (_[0].toString().contains('code')) {
                        widget.onSuccess(jsonDecode(_[0]));
                      } else {
                        webViewState.setUrl(
                          _[0].toString().substring(1, _[0].length - 1),
                        );
                        webViewState.switchView(false);
                        webViewState.controller!.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri(webViewState.currentUrl),
                          ),
                        );
                      }
                    } else {
                      widget.onSuccess(jsonDecode(_[0]));
                      
                      if (widget.payload.closeOnSuccess ?? false) {
                        Navigator.pop(context);
                      }
                    }
                  },
                );

                controller.addJavaScriptHandler(
                  handlerName: 'failure',
                  callback: (_) {
                    widget.onCancel(jsonDecode(_[0]));
                    Navigator.pop(context);
                  },
                );
              },
              onLoadStart: (controller, url) {
                webViewState.setProgress(true);
              },
              onLoadStop: (controller, url) {
                webViewState.setProgress(false);
              },
              onLoadError: (controller, url, code, message) {
                webViewState.setProgress(false);
                Navigator.pop(context);
              },
              onProgressChanged: (controller, p) {
                setState(() {
                  progress = p / 100;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                });
                webViewState.setReportLink('about:blank');
              },
            ),

            // Top loading indicator respecting SafeArea
            if (progress < 1.0)
              Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(value: progress),
              ),
          ],
        ),
      ),
    ),
  );
}

}
