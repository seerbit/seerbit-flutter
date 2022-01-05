import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SecondWebview extends StatefulWidget {
  const SecondWebview({Key? key, this.url = 'wwww.google.com'})
      : super(key: key);
  final String url;
  @override
  _SecondWebviewState createState() => _SecondWebviewState();
}

class _SecondWebviewState extends State<SecondWebview> {
  String currentUrl = '';
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();

  bool isInitialized = false;
  bool isLoading = false;
  String response = 'Scales';
  String currentObject = '';
  String event = 'Events';
  bool isCancelled = false;
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // if(Platform.isIOS) WebView.platform=WkWeb
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          CircularProgressIndicator(),
          Column(
            children: [
              Flexible(
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  // padding: EdgeInsets.all(width * .07),
                  child: WebView(
                      gestureRecognizers: gestureRecognizers,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) => {
                            webViewController = controller,
                            setState(() => isInitialized = true)
                          },
                      javascriptChannels: Set.from([
                        JavascriptChannel(
                            name: 'Success',
                            onMessageReceived: (JavascriptMessage message) {
                              setState(() {
                                response =
                                    jsonDecode(message.message)['response'];

                                event = message.message.toString();
                              });

                              if (RegExp(
                                      r"^((ftp|http|https):\/\/)|www\.?([a-zA-Z]+)\.([a-zA-Z]{2,})\$\/")
                                  .hasMatch(response)) {
                                webViewController.loadUrl(response);
                              }
                            }),
                        JavascriptChannel(
                            name: 'Failure',
                            onMessageReceived: (JavascriptMessage message) {
                              setState(() {
                                response =
                                    jsonDecode(message.message)['response'];
                                event = message.message.toString();
                              });
                              if (jsonDecode(message.message)['event'] ==
                                  'cancelled') Navigator.pop(context);
                              if (RegExp(
                                      r"^((ftp|http|https):\/\/)|www\.?([a-zA-Z]+)\.([a-zA-Z]{2,})\$\/")
                                  .hasMatch(response)) {
                                webViewController.loadUrl(response);
                              } else {
                                Navigator.pop(context);
                              }
                            })
                      ]),
                      navigationDelegate: (nav) {
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (_) {
                        setState(() {
                          isLoading = false;
                          webViewController.currentUrl().then(
                              (value) => currentObject = value.toString());
                        });
                      },
                      onPageStarted: (_) {
                        setState(() {
                          isLoading = true;
                          webViewController.currentUrl().then(
                              (value) => currentObject = value.toString());
                        });
                      },
                      onProgress: (_) {
                        setState(() => isLoading = true);
                      },
                      initialUrl: widget.url),
                ),
              ),
            ],
          ),
          IgnorePointer(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Reponse:$event')),
          ),
          Center(child: isLoading ? CircularProgressIndicator() : Container()),
          Positioned(
            top: height * .05,
            left: width * .03,
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context)),
            ),
          )
        ],
      ),
    );
  }
}
