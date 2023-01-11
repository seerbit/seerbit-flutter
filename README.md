<p align="center">
<img width="400" valign="top" src="https://assets.seerbitapi.com/images/seerbit_logo_type.png" data-canonical-src="https://res.cloudinary.com/dpejkbof5/image/upload/v1620323718/Seerbit_logo_png_ddcor4.png" style="max-width:100%; ">
</p>
 
# Seerbit Flutter SDK
 
Seerbit Flutter SDK can be used to integrate the SeerBit payment gateway into your flutter application.
 
## Requirements
 
Register for a merchant account on [Seerbit Merchant Dashboard](https://dashboard.seerbitapi.com) to get started.
 
```
   Dart sdk: ">=2.12.0-0 <3.0.0"
   Flutter: ">=1.22.2"
   Android: minSdkVersion 17 and add support for androidx (see AndroidX Migration to migrate an existing app)
   iOS: --ios-language swift, Xcode version >= 12
```
 
```bash
flutter pub get seerbit_flutter
```
 
## API Documentation
 
https://doc.seerbit.com
 
## Support
 
If you have any problems, questions or suggestions, create an issue here or send your inquiry to care@seerbit.com
 
## Implementation
 
You should already have your API keys. If not, go to [dashboard.seerbitapi.com](https://dashboard.seerbitapi.com).
 
## Properties
 
| Property               | Type      | Required | Default              | Desc                                                      |
| ---------------------- | ----------| -------- | -------------------- | --------------------------------------------------------- |
| currency               | `String`  | Optional | NGN                  | The currency for the transaction e.g NGN                  |
| email                  | `String`  | Required | None                 | The email of the user to be charged                       |
| description            | `String`  | Optional | None                 | The transaction description which is optional             |
| fullName               | `String`  | Optional | None                 | The fullname of the user to be charged                    |
| country                | `String`  | Optional | None                 | Transaction country which can be optional                 |
| transRef               | `String`  | Required | None                 | Set a unique transaction reference for every transaction  |
| amount                 | `String`  | Required | None                 | The transaction amount in kobo                            |
| callbackUrl            | `String`  | Optional | None                 | This is the redirect url when transaction is successful   |
| publicKey              | `String`  | Required | None                 | Your Public key or see above step to get yours            |
| closeOnSuccess         | `Boolean` | Optional | False                | Close checkout when trasaction is successful              |
| closePrompt            | `Boolean` | Optional | False                | Close the checkout page if transaction is not initiated   |
| setAmountByCustomer    | `Boolean` | Optional | False                | Set to true if you want user to enter transaction amount  |
| pocketRef              | `String`  | Optional | None                 | This is your pocket reference for vendors with pocket     |
| vendorId               | `String`  | Optional | None                 | This is the vendorId of your business using pocket        |
| customization          | `Method`  | Optional | CustomizationModel() | CustomizationMode( borderColor: "#000000",                |
|                        |           |          |                      | backgroundColor: "#004C64", buttonColor: "#0084A0",       |
|                        |           |          |                      | paymentMethod:                                            |
|                        |           |          |                      | [PayChannel.card,PayChannel.account, PayChannel.transfer] |
|                        |           |          |                      | confetti: false,                                         |
|                        |           |          |                      | logo: "logo_url  | base64",)                              |    
| onSuccess              | `Function`| Optional | None                 | Callback function if transaction was successful           |
| onCancel               | `Function`| Optional | None                 | Callback function if transaction was cancelled            |
 
## Usage
 
```dart
import 'package:flutter/material.dart';
import 'package:seerbit_flutter/seerbit_flutter.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);
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


  paymentStart(context){
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
    customization: CustomizationModel(
      borderColor: "#000000",
      backgroundColor: "#004C64",
      buttonColor: "#0084A0",
      paymentMethod: [PayChannel.account, PayChannel.transfer, PayChannel.card],
      confetti: false,
      logo: "logo_url || base64",
    ));
    SeerBit.startPayment(context, payload: payload,
     onSuccess: (_) {
            print(_);
          }, onCancel: (_) {
            print('*' * 400);
          });
  }
}
 
```
 
`OnSuccess` you will recieve a Map containing the response from the payment request.
 
During the payment process you can simply end the process by calling
 
```dart
   SeerbitMethod.endPayment(context);
```
 
This ends the payment and removes the checkout view from the screen.
 
## Contributors
 
<span>
<a href="https://github.com/onuohasilver">
 <img src="https://github.com/onuohasilver.png?size=50">
</a>
</span>
 






