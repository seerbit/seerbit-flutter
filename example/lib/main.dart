import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter/new/customization.dart';
import 'package:seerbit_flutter/new/methods.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/split.dart';

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
        transRef: DateTime.now().millisecondsSinceEpoch.toString(),
        publicKey: "SBTESTPUBK_wLVXnn6YuGaTlOpUESrR7TzFwaDb2auC",
        pocketRef: "",
        vendorId: "",
        setAmountByCustomer: false,
        tokenize: false,
        planId: "",
        metaData: {
          "orderId": "12345",
          "productName": "Sneakers",
        },
        //  splits: SplitModel(
        //   type: "FLAT", //FLAT, PERCENTAGE
        //   transactionFee: "SUB_ACCOUNT", //  ALL_ACCOUNTS, PROPORTIONATE, SUB_ACCOUNT, PARENT_ACCOUNT
        //   bearerSubAccountCode: "SUBACCT001",
        //   items: [
        //     FeeItem(subAccountCode: "SUBACCT001", value: "3.01"),
        //     FeeItem(subAccountCode: "ops-costs-2sD4kA", value: "2.00")
        //   ]
        // ),
        customization: const CustomizationModel(
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
    SeerBit.startPayment(context, payload: payload, onSuccess: (response) {
      print(response);
      Future.delayed(const Duration(milliseconds: 3000), () {
        SeerbitMethod.endPayment(context);
      });
    }, onCancel: (_) {
      print('*' * 400);
    });
  }
}
