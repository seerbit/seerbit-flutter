import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter/new/customization.dart';
import 'package:seerbit_flutter/new/payload.dart';
import 'package:seerbit_flutter/new/state.dart';

String paymentMethods = "card";

///Creates an HTML string with information from that parsed Payload model
String initRequest(
    PayloadModel model, String reportLink, String x, WebViewState state) {
  List<String> paymentMethods = List.generate(
      model.customization.paymentMethod.length,
      (index) => getPayChannel(model.customization.paymentMethod[index]));

  if (paymentMethods.length < 5) {
    paymentMethods
        .addAll(List.generate(5 - paymentMethods.length, (index) => ""));
  }

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
                                  full_name: "${model.fullName}",
                                  close_prompt: ${model.closePrompt},
                                  close_on_success: ${model.closeOnSuccess},
                                  setAmountByCustomer: ${model.setAmountByCustomer},
                                  callbackurl: "${model.callbackUrl}",
                                  narrator:"seerbit-react-native",
                                  // integrationSource : "mobile-sdk",
                                  "report_link":"${state.reportLink}",
                                  public_key: "${model.publicKey}",
                                   tokenize: ${model.tokenize},
                                   planId: "${model.planId}",
                                   customization: {
                                      theme: {
                                        border_color: "${model.customization.borderColor}",
                                        background_color: "${model.customization.backgroundColor}",
                                        button_color: "${model.customization.buttonColor}",
                                      },
                                      payment_method: 
                                      """ +
      """
                                      ["${paymentMethods[0]}","${paymentMethods[1]}","${paymentMethods[2]}","${paymentMethods[3]}","${paymentMethods[4]}"],""" +
      """
                                      confetti: ${model.customization.confetti}, // false;
                                      logo: "${model.customization.logo}",
                                    }
                                  ,
                                },
                                function callback(response) {
                                   window.flutter_inappwebview
                                    .callHandler('success', JSON.stringify(response));
                                },
                                function close(close) {
                                   window.flutter_inappwebview
                                    .callHandler('failure', JSON.stringify(close));
                                }
                              );
                            }

                            </script>
                            </body>
                    </html>
                                  """;
}

///Generates A Uri from a raw HtML string
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
