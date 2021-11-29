// import 'dart:convert';

// import 'package:example/payloadModel.dart';
// import 'package:example/snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import 'html.dart';

// class CommunityWebView extends StatefulWidget {
//   const CommunityWebView({Key? key}) : super(key: key);

//   @override
//   _CommunityWebViewState createState() => _CommunityWebViewState();
// }

// class _CommunityWebViewState extends State<CommunityWebView> {
//   String? mimeType = 'text/html';
//   String response = 'sd';
//   final flutterWebViewPlugin = FlutterWebviewPlugin();
//   @override
//   void initState() {
//     flutterWebViewPlugin.onUrlChanged.listen((event) {
//       displaySnack(context, text: 'Event');
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       height: height,
//       width: width,
//       child: Column(
//         children: [
//           Flexible(
//               child: WebviewScaffold(
//             javascriptChannels: Set.from([
//               JavascriptChannel(
//                   name: 'Success',
//                   onMessageReceived: (JavascriptMessage message) {
//                     setState(() {
//                       response = jsonDecode(message.message)['response'];
//                     });
//                     displaySnack(context, text: response);
//                     // webViewController.loadUrl(response);
//                   }),
//               JavascriptChannel(
//                   name: 'Failure',
//                   onMessageReceived: (JavascriptMessage message) {
//                     setState(() {
//                       response = jsonDecode(message.message)['response'];
//                     });
//                     displaySnack(context, text: response);

//                     // webViewController.loadUrl(response);
//                   })
//             ]),
//             url: Uri.dataFromString(
//                     initRequest(
//                         PayloadModel(
//                             currency: 'NGN',
//                             email: "hftserve@gmail.com",
//                             description: "Foxsod",
//                             fullName: "Combs Combs",
//                             country: "NG",
//                             amount: "100",
//                             callbackUrl: "callbackUrl",
//                             publicKey:
//                                 // "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
//                                 "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
//                             narrator: 'seerbit-react-native',
//                             reportLink: "",
//                             pocketRef: "",
//                             vendorId: ""),
//                         "==",
//                         ''),
//                     mimeType: mimeType)
//                 .toString(),
//           ))
//         ],
//       ),
//     );
//   }
// }
