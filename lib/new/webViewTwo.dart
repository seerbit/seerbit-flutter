import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/navigationConditions.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/state.dart';

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
      child: Scaffold(
          appBar: AppBar(title: Text("SeerBit WebView 2")),
          body: Column(children: <Widget>[
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
                      // initialData: InAppWebViewInitialData(data: ),
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                        webViewState.setController(controller);

                        controller.addJavaScriptHandler(
                            handlerName: 'success',
                            callback: (_) {
                              print(_);
                              webViewState.setResponse(_);
                            });
                        controller.addJavaScriptHandler(
                            handlerName: 'failure',
                            callback: (_) {
                              print(_);
                              webViewState.setResponse(_);
                            });
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
                        if (shouldSwitchView(url.toString(), widget.payload)) {
                          webViewState.controllerOne!
                              .loadUrl(urlRequest: URLRequest(url: url));

                          webViewState.switchView(true);
                        }
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        webViewState.setConsole(consoleMessage.message);
                      },
                    ),
                    progress < 1.0
                        ? Center(
                            child: CircularProgressIndicator(value: progress))
                        : Container(),
                    // Center(
                    //     child: FutureBuilder(
                    //         future: webViewController?.getUrl(),
                    //         initialData: "s",
                    //         builder: (_, __) => Text(__.data.toString()))),
                    // Center(
                    //   child: Text(webViewState.response.toString()),
                    // )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
