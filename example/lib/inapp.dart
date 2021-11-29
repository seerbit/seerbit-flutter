// import 'package:example/html.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class SeerWebview extends StatefulWidget {
//   const SeerWebview({Key? key}) : super(key: key);

//   @override
//   _SeerWebviewState createState() => _SeerWebviewState();
// }

// class _SeerWebviewState extends State<SeerWebview> {
//   late WebViewController webViewController;
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
//             child: SizedBox(
//               height: height,
//               width: width,
//               child: WebView(
//                 onWebViewCreated: (controller) =>
//                     webViewController = controller,
//                 initialUrl: initialHtml(),
//                 javascriptMode: JavascriptMode.unrestricted,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
