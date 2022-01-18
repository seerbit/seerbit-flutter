import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter/new/methods.dart';
import 'package:seerbit_flutter/new/payload.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: SeerbitTest()));
}

class SeerbitTest extends StatelessWidget {
  const SeerbitTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 1000,
        width: 500,
        child: Center(
            child: TextButton(
                onPressed: () => SeerbitMethod.startPayment(context,
                        payload: payload, onSuccess: (_) {
                      print(_);
                    }, onCancel: (_) {}),
                child: Text("Checkout"))));
  }
}

PayloadModel payload = PayloadModel(
    currency: 'NGN',
    email: "hello@gmail.com",
    description: "Sneakers",
    fullName: "General Zod",
    country: "NG",
    amount: "100",
    transRef: Random().nextInt(5000200).toString(),
    callbackUrl: "callbackUrl",
    publicKey: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
    pocketRef: "",
    vendorId: "Freedah");
