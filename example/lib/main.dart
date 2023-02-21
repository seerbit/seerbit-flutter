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
  SeerbitTest({Key? key}) : super(key: key);
  SeerbitMethod SeerBit = new SeerbitMethod();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 1000,
      width: 500,
      child: Center(
        child: TextButton(
          onPressed: () => paymentStart(context),
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  paymentStart(context) {
    PayloadModel payload = PayloadModel(
        currency: 'NGN',
        email: "hellxo@gmxail.com",
        description: "Sneakers",
        fullName: "General ZxXXod",
        country: "NG",
        amount: "102",
        transRef: Random().nextInt(2000).toString(),
        publicKey: "merchant_public_key",
        pocketRef: "",
        vendorId: "vendorId",
        closeOnSuccess: false,
        closePrompt: false,
        setAmountByCustomer: false,
        tokenize: false,
        customization: CustomizationModel(
          borderColor: "#000000",
          backgroundColor: "#004C64",
          buttonColor: "#0084A0",
          paymentMethod: [
            PayChannel.account,
            PayChannel.transfer,
            PayChannel.card,
            PayChannel.momo
          ],
          confetti: false,
          logo: "logo_url || base64",
        ));
    SeerBit.startPayment(context, payload: payload, onSuccess: (_) {
      print(_);
    }, onCancel: (_) {
      print('*' * 400);
    });
  }
}
