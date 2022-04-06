import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter/new/customization.dart';
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
          onPressed: () => SeerbitMethod.startPayment(context, payload: payload,
              onSuccess: (_) {
            print(_);
          }, onCancel: (_) {
            print('*' * 400);
            print('*' * 400);
            print(_);
            print('*' * 400);
            print('*' * 400);
          }),
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

PayloadModel payload = PayloadModel(
    currency: 'NGN',
    email: "hellxo@gmxail.com",
    description: "Sneakers",
    fullName: "General ZxXXod",
    country: "NG",
    amount: "102",
    transRef: Random().nextInt(2000).toString(),
    callbackUrl: "callbackUrl",
    publicKey: "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
    pocketRef: "",
    vendorId: "Freedah",
    closeOnSuccess: false,
    closePrompt: false,
    setAmountByCustomer: false,
    customization: CustomizationModel(
      borderColor: "#000000",
      backgroundColor: "#004C64",
      buttonColor: "#0084A0",
      paymentMethod: [PayChannel.account, PayChannel.transfer, PayChannel.card],
      confetti: false,
      logo: "logo_url || base64",
    ));
