import 'package:seerbit_flutter/new/payload.dart';

bool shouldSwitchView(String url, PayloadModel model) {
  if ((url.contains("vers%3Done") || url.contains("vers%3Dtwo")) &
      url.toLowerCase().contains('pubk')) {
    return true;
  } else {
    return false;
  }
}
