import 'package:flutter/material.dart';
import 'package:seerbit_flutter/display/seerbit_screen.dart';
import 'package:seerbit_flutter/new/payload.dart';

class SeerbitMethod {
  static startPayment(context,
      {required PayloadModel payload,
      required Function(Map) onSuccess,
      required Function(Map) onCancel}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return SeerbitPayment(
              payload: payload, onSuccess: onSuccess, onCancel: onCancel);
        });
  }

  static endPayment(context) {
    Navigator.pop(context);
  }
}
