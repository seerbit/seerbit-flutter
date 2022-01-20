import 'package:flutter/material.dart';
import 'package:seerbit_flutter/display/seerbit_screen.dart';
import 'package:seerbit_flutter/new/payload.dart';

class SeerbitMethod {
  ///Begins the payment by triggering the overlay of the Seerbit Checkout Modal
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

  ///A simple pop context.
  ///It removes the Seerbit Checkout Modal from the current view
  static endPayment(context) {
    Navigator.pop(context);
  }
}
