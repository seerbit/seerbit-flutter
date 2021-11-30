import 'dart:convert';
import 'dart:io';

import 'package:example/html.dart';
import 'package:example/payloadModel.dart';
import 'package:example/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeerbitBottomSheet extends StatefulWidget {
  const SeerbitBottomSheet(
      {Key? key,
      required this.payload,
      this.onFailure,
      this.onSuccess,
      this.closeOnFinish = true})
      : super(key: key);
  final PayloadModel payload;
  final Function()? onSuccess;
  final Function()? onFailure;
  final bool closeOnFinish;

  @override
  _SeerbitBottomSheetState createState() => _SeerbitBottomSheetState();
}

class _SeerbitBottomSheetState extends State<SeerbitBottomSheet> {
  String response = 'Scales';
  String? mimeType = 'text/html';
  String currentUrl = '';
  late WebViewController webViewController;
  bool isInitialized = false;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
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
          Column(
            children: [
              Flexible(
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.all(width * .07),
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
                              });
                              displaySnack(context, text: response);
                              webViewController.loadUrl(response);
                            }),
                        JavascriptChannel(
                            name: 'Failure',
                            onMessageReceived: (JavascriptMessage message) {
                              setState(() {
                                response =
                                    jsonDecode(message.message)['response'];
                              });
                              displaySnack(context, text: response);
                              webViewController.loadUrl(response);
                            })
                      ]),
                      navigationDelegate: (nav) {
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (_) {
                        setState(() {
                          mimeType = 'text/css';
                        });
                      },
                      initialUrl: Uri.dataFromString(
                              initRequest(widget.payload, "==", ''),
                              mimeType: mimeType)
                          .toString()),
                ),
              ),
            ],
          ),
          isInitialized
              ? Positioned.fill(
                  bottom: height * .06,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FutureBuilder<String?>(
                          future: webViewController.currentUrl(),
                          builder: (context, snapshot) {
                            return snapshot.data != null
                                ? Visibility(
                                    visible: containsPublicKey(
                                        snapshot.data!, widget.payload),
                                    child: TextButton(
                                        onPressed: () async => Future.delayed(
                                                Duration(milliseconds: 10),
                                                isSuccessful(snapshot.data!)
                                                    ? widget.onSuccess
                                                    : widget.onFailure)
                                            .then((value) =>
                                                widget.closeOnFinish
                                                    ? Navigator.pop(context)
                                                    : null),
                                        child: SizedBox(
                                          width: width * .8,
                                          height: height * .07,
                                          child: Material(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Center(
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: width * .05),
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                : SizedBox();
                          })),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

bool containsPublicKey(String data, PayloadModel payload) =>
    data.contains(payload.publicKey) &
    data.contains('vers') &
    (data.contains('two') || data.contains('one'));
bool isSuccessful(String data) => data.toLowerCase().contains('success');
