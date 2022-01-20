import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/navigationConditions.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/state.dart';

import 'req.dart';

class WebViewTwo extends StatefulWidget {
  const WebViewTwo({Key? key, required this.payload}) : super(key: key);
  final PayloadModel payload;
  @override
  _WebViewTwoState createState() => new _WebViewTwoState();
}

class _WebViewTwoState extends State<WebViewTwo> {
  // final GlobalKey webViewKeyX = GlobalKey();

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

  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  bool loader = true;
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
                    initialUrlRequest:
                        URLRequest(url: Uri.parse(webViewState.currentUrl)),
                    initialOptions: options,
                    gestureRecognizers:
                        [Factory(() => EagerGestureRecognizer())].toSet(),
                    // initialData: InAppWebViewInitialData(data: ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      webViewState.setController(controller);
                    },

                    onProgressChanged: (controller, progress) {
                      if (progress == 100) {}
                      setState(() {
                        this.progress = progress / 100;
                        urlController.text = this.url;
                      });
                    },
                    onUpdateVisitedHistory:
                        (controller, url, androidIsReload) async {
                      webViewState.setReportLink(url.toString());
                      if (shouldSwitchView(url.toString(), widget.payload)) {
                        webViewState.setReportLink(url.toString());
                        webViewState.controllerOne!.loadUrl(
                            urlRequest: URLRequest(
                                url: createUri(widget.payload, webViewState)));
                        webViewState.setReportLink('');

                        ///FIXME:

                        webViewState.switchView(true);
                      }
                      setState(() {
                        this.url = url.toString();
                        urlController.text = this.url;
                      });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      print(consoleMessage.message);
                      webViewState.setConsole(consoleMessage.message);
                    },
                  ),
                  progress < 1.0
                      ? Center(
                          child: CircularProgressIndicator(value: progress))
                      : Container(),
                  // Center(child: Text(webViewState.reportLink.toString()))
                ],
              ),
            ),
          ),
        ]));
  }
}
