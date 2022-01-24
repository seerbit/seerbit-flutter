import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewState extends ChangeNotifier {
  ///The Url currently on the webview
  String currentUrl = "about:blank";

  ///controls if the first webview is being displayed
  bool isShowingFirst = true;

  ///Controls if the webview is still loading
  bool isLoading = false;

  ///the report link contains the url for the confirmation of transaction
  String reportLink = "";

  ///the response object
  dynamic response = {};

  ///Logs the console information
  String consoleLog = "Console:";

  ///the controller for the second webview
  InAppWebViewController? controller;

  ///the controller for the first webview
  InAppWebViewController? controllerOne;

  ///switches from one of the webviews to another
  void switchView(bool value) {
    isShowingFirst = value;
    notifyListeners();
  }

  /// sets the state of the current url
  void setUrl(String value) {
    currentUrl = value;
    notifyListeners();
  }

  ///Sets the second webview controller
  void setController(InAppWebViewController control) {
    controller = control;
    notifyListeners();
  }

  ///Sets the controller for the first webview
  void setControllerOne(InAppWebViewController control) {
    controllerOne = control;
    notifyListeners();
  }

  ///Sets the response object state
  void setResponse(dynamic value) {
    response = value;
    notifyListeners();
  }

  /// Sets the console logger
  void setConsole(String value) {
    consoleLog = "Console: " + value;
    notifyListeners();
  }

  ///monitors the loading progress of the webviews
  void setProgress(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void setReportLink(String link) {
    reportLink = link;
    notifyListeners();
  }
}
