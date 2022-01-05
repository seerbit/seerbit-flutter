import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seerbit_flutter/seerbit_flutter.dart';

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
  int amount = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sample Checkout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            Container(
                width: width,
                height: height * .15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[200]!,
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: height * .15,
                      width: width * .24,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://ng.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/28/921237/1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: width * .02),
                    Container(
                      width: width * .3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fashion Sneakers',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('A description of the product  '),
                          Text('₦10 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$amount  pcs.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: Colors.grey[200],
                              type: MaterialType.circle,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => setState(() {
                                  if (amount >= 2) amount -= 1;
                                }),
                                icon: Icon(Icons.remove),
                              ),
                            ),
                            Material(
                              color: Colors.grey[200],
                              type: MaterialType.circle,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => setState(() => amount += 1),
                                icon: Icon(Icons.add),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TOTAL',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(
                  width: width * .03,
                ),
                Text('₦${amount} ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ],
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: () => SeerBitPayment.checkout(
                      context,
                      PayloadModel(
                          currency: 'NGN',
                          email: "hello@gmail.com",
                          description: "Sneakers",
                          fullName: "General Zod",
                          country: "NG",
                          amount: "$amount",
                          callbackUrl: "callbackUrl",
                          publicKey:
                              "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7",
                          // "SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I",
                          // narrator: 'seerbit-react-native',
                          // reportLink: "",
                          pocketRef: "",
                          vendorId: "Freedah"),
                      // onFailure: () =>
                      //     displaySnack(context, text: 'Payment Failed'),
                      // onSuccess: () =>
                      //     displaySnack(context, text: 'Payment Successful'),
                    ),
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
  