import 'package:seerbit_flutter/new/payload.dart';

bool shouldSwitchView(String url, PayloadModel model) {
  if ((url.contains("vers=one") || url.contains("vers=two")) &
      url.contains(model.publicKey)) {
    return true;
  }
  return false;
}
