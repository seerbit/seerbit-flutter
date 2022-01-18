import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewState extends ChangeNotifier {
  String currentUrl = "";
  bool isShowingFirst = true;
  bool isLoading = false;
  String reportLink = "";
  dynamic response = {};
  String consoleLog = "Console:";
  InAppWebViewController? controller;
  InAppWebViewController? controllerOne;
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

  void setControllerOne(InAppWebViewController control) {
    controllerOne = control;
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

  void setReportLink(String link) {
    reportLink = link;
    notifyListeners();
  }
}
