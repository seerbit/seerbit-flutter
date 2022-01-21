import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/payload.dart';

import 'state.dart';
import 'webViewOne.dart';
import 'webViewTwo.dart';

class WebViewSwitcher extends StatefulWidget {
  const WebViewSwitcher(
      {Key? key,
      required this.payload,
      required this.onSuccess,
      required this.onCancel})
      : super(key: key);
  final PayloadModel payload;
  final ValueSetter<Map> onSuccess;
  final ValueSetter<dynamic>onCancel;
  @override
  _WebViewSwitcherState createState() => _WebViewSwitcherState();
}

class _WebViewSwitcherState extends State<WebViewSwitcher> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    WebViewState webViewState = Provider.of<WebViewState>(context);
    return Container(
      height: height,
      width: width,
      child: IndexedStack(
        children: [
          WebViewOne(
              payload: widget.payload,
              onSuccess: widget.onSuccess,
              onCancel: widget.onCancel),
          WebViewTwo(payload: widget.payload) ,
          Text(
            webViewState.currentUrl,
            style: TextStyle(fontSize: 12),
          ),
        ],
        index: webViewState.isShowingFirst ? 0 : 1,
      ),
    );
  }
}
