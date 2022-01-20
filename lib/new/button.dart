import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seerbit_flutter/display/seerbit_screen.dart';
import 'package:seerbit_flutter/new/payload.dart';

class SeerbitButton extends StatefulWidget {
  ///A Simple customizable button that triggers an overlay for the Seerbit Payment Widget
  const SeerbitButton(
      {Key? key,
      required this.payload,
      required this.onSuccess,
      this.buttonStyle,
      this.text = "Make Payment",
      required this.onCancel})
      : super(key: key);

  ///The data that parsed to the Seerbit API
  ///this specifies the customer data and the amount to be paid
  final PayloadModel payload;

  ///A function to determine what happens when the transaction is completed
  final ValueSetter<Map> onSuccess;
  final ValueSetter<dynamic> onCancel;

  ///The styling for the Seerbit button defaults to
  ///```dart
  ///ButtonStyle(
  /// backgroundColor: MaterialStateProperty.all(Colors.red),
  ///  )
  ///```
  final ButtonStyle? buttonStyle;

  ///Text to be displayed on the  button
  final String text;

  @override
  _SeerbitButtonState createState() => _SeerbitButtonState();
}

class _SeerbitButtonState extends State<SeerbitButton> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: widget.buttonStyle ??
          ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return SeerbitPayment(
                  payload: widget.payload,
                  onSuccess: widget.onSuccess,
                  onCancel: widget.onCancel);
            });
      },
      child: Text(
        widget.text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
