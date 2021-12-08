import 'package:flutter/material.dart';
import 'package:seerbit_flutter/seerbit_flutter.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => SeerBitPayment.checkout(
              context,
              PayloadModel(
                  currency: 'NGN',
                  email: "hftserve@gmail.com",
                  description: "Foxsod",
                  fullName: "Combs Combs",
                  country: "NG",
                  amount: "100",
                  callbackUrl: "callbackUrl",
                  publicKey: "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
                  narrator: 'seerbit-react-native',
                  reportLink: "",
                  pocketRef: "",
                  vendorId: ""),
              onFailure: () {},
              onSuccess: () {},
            ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
        child: Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ));
  }
}
