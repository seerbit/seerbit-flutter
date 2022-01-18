import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/state.dart';
import 'package:seerbit_flutter/new/webViewSwitcher.dart';

class SeerbitPayment extends StatefulWidget {
  const SeerbitPayment({Key? key, required this.payload}) : super(key: key);
  final PayloadModel payload;
  @override
  _SeerbitPaymentState createState() => _SeerbitPaymentState();
}

class _SeerbitPaymentState extends State<SeerbitPayment> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<WebViewState>(
              create: (context) => WebViewState()),
        ],
        child: WebViewSwitcher(
          payload: widget.payload,
        ));
  }
}
