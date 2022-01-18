import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewState extends ChangeNotifier {
  String currentUrl = "";
  bool isShowingFirst = true;
  bool isLoading = false;
  dynamic response = {};
  String consoleLog = "Console:";
  InAppWebViewController? controller;
  void switchView(bool value) {
    isShowingFirst = value;
    notifyListeners();
  }

  void setUrl(String value) {
    currentUrl = value;
    notifyListeners();
  }

  void setController(InAppWebViewController control) {
    controller = control;
    notifyListeners();
  }

  void setResponse(dynamic value) {
    response = value;
    notifyListeners();
  }

  void setConsole(String value) {
    consoleLog = "Console: " + value;
    notifyListeners();
  }

  void setProgress(bool status) {
    isLoading = status;
    notifyListeners();
  }
}
