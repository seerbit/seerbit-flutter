import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seerbit_flutter/display/seerbit_bottom_sheet.dart';
import 'package:seerbit_flutter/display/seerbit_snack.dart';
import 'package:seerbit_flutter/models/payload.dart';

class SeerBitPayment {
  static Future checkout(BuildContext context, PayloadModel payload,
      {Function()? onFailure, Function()? onSuccess}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SeerbitBottomSheet(
            onFailure: onFailure ??
                () => displaySnack(context, text: 'Payment Failed'),
            onSuccess: onFailure ??
                () => displaySnack(context, text: 'Payment Successful'),
            payload: payload));
  }
}
