import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:seerbit_flutter/display/seerbit_screen.dart';
import 'package:seerbit_flutter/new/payload.dart';

class SeerbitButton extends StatefulWidget {
  const SeerbitButton(
      {Key? key,
      required this.payload,
      required this.onSuccess,
      required this.onCancel})
      : super(key: key);
  final PayloadModel payload;
  final ValueSetter<Map> onSuccess, onCancel;

  @override
  _SeerbitButtonState createState() => _SeerbitButtonState();
}

class _SeerbitButtonState extends State<SeerbitButton> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
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
        'Make Payment',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
