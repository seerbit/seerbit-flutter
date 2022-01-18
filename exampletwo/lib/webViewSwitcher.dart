// import 'package:exampletwo/state.dart';
// import 'package:exampletwo/webViewOne.dart';
// import 'package:exampletwo/webViewTwo.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WebViewSwitcher extends StatefulWidget {
//   const WebViewSwitcher({Key? key}) : super(key: key);

//   @override
//   _WebViewSwitcherState createState() => _WebViewSwitcherState();
// }

// class _WebViewSwitcherState extends State<WebViewSwitcher> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     WebViewState webViewState = Provider.of<WebViewState>(context);
//     return Container(
//       height: height,
//       width: width,
//       child: IndexedStack(
//         children: [
//           WebViewOne(),
//           WebViewTwo(),
//           Text(
//             webViewState.currentUrl,
//             style: TextStyle(fontSize: 12),
//           ),
//         ],
//         index: webViewState.isShowingFirst ? 0 : 1,
//       ),
//     );
//   }
// }
