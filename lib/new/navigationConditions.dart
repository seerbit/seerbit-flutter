import 'package:seerbit_flutter/new/payload.dart';

///Method that checks if a payment confirmation link has been sent
bool shouldSwitchView(String url, PayloadModel model) {
  if ((url.contains("vers%3Done") || url.contains("vers%3Dtwo") || url.contains("vers=two") || url.contains("vers=one")) &
      url.toLowerCase().contains('pubk')) {
    return true;
  } else {
    return false;
  }
}
