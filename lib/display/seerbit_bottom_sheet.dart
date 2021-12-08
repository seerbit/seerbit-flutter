import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seerbit_flutter/models/payload.dart';
import 'package:seerbit_flutter/utilities/checkForPublicKey.dart';
import 'package:seerbit_flutter/utilities/initiateRequest.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SeerbitBottomSheet extends StatefulWidget {
  const SeerbitBottomSheet(
      {Key? key,
      required this.payload,
      this.onFailure,
      this.onSuccess,
      this.closeOnFinish = true})
      : super(key: key);

  final Function()? onSuccess;
  final Function()? onFailure;
  final bool closeOnFinish;
  final PayloadModel payload;

  @override
  _SeerbitBottomSheetState createState() => _SeerbitBottomSheetState();
}

class _SeerbitBottomSheetState extends State<SeerbitBottomSheet> {
  String currentUrl = '';
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();

  bool isInitialized = false;
  bool isLoading = false;
  String? mimeType = 'text/html';
  String response = 'Scales';
  late WebViewController webViewController;

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
                              webViewController.loadUrl(response);
                            }),
                        JavascriptChannel(
                            name: 'Failure',
                            onMessageReceived: (JavascriptMessage message) {
                              setState(() {
                                response =
                                    jsonDecode(message.message)['response'];
                              });
                              webViewController.loadUrl(response);
                            })
                      ]),
                      navigationDelegate: (nav) {
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (_) {
                        setState(() {
                          mimeType = 'text/css';
                          isLoading = false;
                        });
                      },
                      onPageStarted: (_) {
                        setState(() => isLoading = true);
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
              : SizedBox(),
          Center(child: isLoading ? CircularProgressIndicator() : Container())
        ],
      ),
    );
  }
}
