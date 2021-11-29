import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'html.dart';
import 'payloadModel.dart';
import 'snackbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SeerbitBottomSheet()],
        ),
      ),
    );
  }
}

class SeerbitBottomSheet extends StatefulWidget {
  const SeerbitBottomSheet({Key? key}) : super(key: key);

  @override
  _SeerbitBottomSheetState createState() => _SeerbitBottomSheetState();
}

class _SeerbitBottomSheetState extends State<SeerbitBottomSheet> {
  String response = 'Scales';
  String? mimeType = 'text/html';
  String currentUrl = '';
  late WebViewController webViewController, secondWebViewController;
  bool showFirst = true;
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
          Visibility(
            visible: showFirst,
            child: Column(
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
                        onWebViewCreated: (controller) =>
                            webViewController = controller,
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
                          if (nav.url.contains('seerbitapigateway')) {
                            displaySnack(context, text: 'Somewhere');
                          } else {
                            displaySnack(context, text: 'Nowehre');
                          }
                          return NavigationDecision.navigate;
                        },
                        onPageFinished: (_) {
                          setState(() {
                            mimeType = 'text/css';
                          });
                        },
                        initialUrl: Uri.dataFromString(
                                initRequest(
                                    PayloadModel(
                                        currency: 'NGN',
                                        email: "hftserve@gmail.com",
                                        description: "Foxsod",
                                        fullName: "Combs Combs",
                                        country: "NG",
                                        amount: "100",
                                        callbackUrl: "callbackUrl",
                                        publicKey:
                                            // "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
                                            "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
                                        narrator: 'seerbit-react-native',
                                        reportLink: "",
                                        pocketRef: "",
                                        vendorId: ""),
                                    "==",
                                    ''),
                                mimeType: mimeType)
                            .toString()),
                  ),
                ),
              ],
            ),
          ),
          Center(child: Text(mimeType!))
        ],
      ),
    );
  }
}
