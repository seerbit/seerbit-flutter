import 'package:example/payloadModel.dart';
import 'package:example/seerbit_bottomsheet.dart';
import 'package:example/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int amount = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sample Checkout'),
            SizedBox(height: 10),
            Text(
              '$amount naira',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            SizedBox(height: 10),
            Container(
              height: 98,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(.1),
              ),
              child: Column(
                children: [
                  Text('Product 1 @ 10 naira each'),
                  Text('A description of product 1'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() {
                          if (amount >= 10) amount -= 10;
                        }),
                        icon: Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () => setState(() => amount += 10),
                        icon: Icon(Icons.add),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SeerbitBottomSheet(
                        onFailure: () =>
                            displaySnack(context, text: 'Payment Failed'),
                        onSuccess: () =>
                            displaySnack(context, text: 'Payment Successful'),
                        payload: PayloadModel(
                            currency: 'NGN',
                            email: "hftserve@gmail.com",
                            description: "Foxsod",
                            fullName: "Combs Combs",
                            country: "NG",
                            amount: "$amount",
                            callbackUrl: "callbackUrl",
                            publicKey:
                                "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
                            narrator: 'seerbit-react-native',
                            reportLink: "",
                            pocketRef: "",
                            vendorId: ""))),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
