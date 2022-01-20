import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/state.dart';

String initRequest(
    PayloadModel model, String reportLink, String x, WebViewState state) {
  return """
                                  <!DOCTYPE html>
                    <html lang="en">
                            <head>
                                    <meta charset="UTF-8">
                                    <meta http-equiv="X-UA-Compatible" content="ie=edge">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>SeerBit</title>
                            </head>
                            <body  onload="paywithSeerbit()" style="background-color:#fff;height:100vh ">
                            <form>
                            <script src="https://checkout.seerbitapi.com/api/v2/seerbit.js"></script>
                             </form>
                             <script>
                             function paywithSeerbit() {
                              SeerbitPay(
                                {
                                  tranref: "${model.transRef}",
                                  currency: "${model.currency}",
                                  description: "${model.description}",
                                  country: "${model.country}",
                                  email:"${model.email}",
                                  amount: "${model.amount}",
                                  close_prompt: true,
                                  close_on_sucess: true,
                                  callbackurl: "${model.callbackUrl}",
                                  narrator:"seerbit-react-native",
                                  // integrationSource : "mobile-sdk",
                                  "report_link":"${state.reportLink}",
                                  public_key: "${model.publicKey}"
                                  //"SBPUBK_1ZAL1HXRQQFKHSHXAQ91KGGWEEUXZK4I"
                                  // "SBTESTPUBK_Gq9XaRKyQ05LQ3XHR9NLNpxBgsmgGzg7"
                                  // replace this with your own public key
                                },
                                function callback(response) {
                                   window.flutter_inappwebview
                                    .callHandler('success', JSON.stringify(response));
                                },
                                function close(close) {
                                   window.flutter_inappwebview
                                    .callHandler('failure', JSON.stringify(response));
                                }
                              );
                            }

                            </script>
                            </body>
                    </html>
                                  """;
}

Uri createUri(PayloadModel payload, WebViewState webViewState) {
  return Uri.dataFromString(initRequest(payload, "==", '', webViewState),
      encoding: Encoding.getByName('utf-8'), mimeType: 'text/html');
}

///Creates a simple snackbr
void displaySnack(BuildContext context,
    {String? text,
    Color? color,
    Function()? onPressed,
    Color textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 40,
    content: Text(
      text!,
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
  ));
}
