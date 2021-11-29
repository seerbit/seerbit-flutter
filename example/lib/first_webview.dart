// import 'package:example/html.dart';
// import 'package:example/payloadModel.dart';
// import 'package:flutter/material.dart';
// import 'package:webviewx/webviewx.dart';

// class MyWebView extends StatefulWidget {
//   const MyWebView({Key? key}) : super(key: key);

//   @override
//   _MyWebViewState createState() => _MyWebViewState();
// }

// class _MyWebViewState extends State<MyWebView> {
//   late WebViewXController webviewController;
//   @override
//   Widget build(BuildContext context) {
//     return WebViewX(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       initialContent: initRequest(
//           PayloadModel(
//               currency: 'NGN',
//               email: "hftserve@gmail.com",
//               description: "Foxsod",
//               fullName: "Combs Combs",
//               country: "NG",
//               amount: "100",
//               callbackUrl: "callbackUrl",
//               publicKey:
//                   // "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
//                   "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
//               narrator: 'seerbit-react-native',
//               reportLink: "",
//               pocketRef: "",
//               vendorId: ""),
//           "==",
//           ''),
//       initialSourceType: SourceType.html,
      
//       onWebViewCreated: (controller) => webviewController = controller,
//     );
//   }
// }
