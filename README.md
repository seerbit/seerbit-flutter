<p align="center">
<img width="500" valign="top" src="https://res.cloudinary.com/dpejkbof5/image/upload/v1620323718/Seerbit_logo_png_ddcor4.png" data-canonical-src="https://res.cloudinary.com/dpejkbof5/image/upload/v1620323718/Seerbit_logo_png_ddcor4.png" style="max-width:100%; ">
</p>

# Seerbit Flutter SDK

Seerit Flutter SDK can be used to integrate the SeerBit payment gateway into your flutter application. 

## Requirements 
Register for a merchant account on [Seerbit Merchant Dashboard](https://dashboard.seerbitapi.com) to get started. 

```bash
flutter pub get seerbit_flutter
```

## API Documentation 
   https://doc.seerbit.com

## Support 
If you have any problems, questions or suggestions, create an issue here or send your inquiry to care@seerbit.com

## Implementation
You should already have your API keys. If not, go to [dashboard.seerbitapi.com](https://dashboard.seerbitapi.com).
```dart
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
                  publicKey: "YOUR PUBIC KEY",
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

```
## Contributors
<span>
<a href="https://github.com/onuohasilver">
  <img src="https://github.com/onuohasilver.png?size=50">
</a>
</span>
