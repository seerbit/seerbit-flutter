import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SecondWebView extends StatefulWidget {
  const SecondWebView({Key? key}) : super(key: key);

  @override
  _SecondWebViewState createState() => _SecondWebViewState();
}

class _SecondWebViewState extends State<SecondWebView> {
  late WebViewController webViewController, secondWebViewController;
  bool showFirst = true;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Flexible(
          child: Container(
            height: height,
            width: width,
            color: Colors.green,
            padding: EdgeInsets.all(width * .07),
            child: WebView(
                gestureRecognizers: gestureRecognizers,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) =>
                    secondWebViewController = controller,
                initialUrl:
                    ModalRoute.of(context)!.settings.arguments! as String),
          ),
        ),
      ],
    );
  }
}
