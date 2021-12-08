import 'package:seerbit_flutter/models/payload.dart';

String initRequest(PayloadModel payload, String reportLink, String x) {
  String strVar = "";
  strVar += "<!DOCTYPE html>";
  strVar += "<html lang=\"en\">";
  strVar += "";
  strVar += "<head>";
  strVar += "    <meta charset=\"UTF-8\">";
  strVar += "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">";
  strVar +=
      "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
  strVar += "    <title>SeerBit<\/title>";
  strVar += "<\/head>";
  strVar += "";
  strVar +=
      "<body onload=\"paywithSeerbit()\" style=\"background-color:#fff;height:100vh \">";
  strVar += "    <form>";
  strVar +=
      "        <script src=\"https:\/\/checkout.seerbitapi.com\/api\/v2\/seerbit.js\"><\/script>";
  strVar += "    <\/form>";
  strVar += "    <script>";
  strVar += "        function paywithSeerbit() {";
  strVar += "            SeerbitPay({";
  strVar +=
      "                \"tranref\": \"${DateTime.now().millisecondsSinceEpoch}\",";
  strVar += "                \"currency\": \"${payload.currency}\",";
  strVar += "                \"email\": \"${payload.email}\",";
  strVar += "                \"description\": \"${payload.description}\",";
  strVar += "                \"full_name\": \"${payload.fullName}\",";
  strVar += "                \"country\": \"${payload.country}\",";
  strVar += "                \"amount\": \"${payload.amount}\",";
  strVar += "                \"callbackurl\": \"${payload.callbackUrl}\",";
  strVar += "                \"public_key\": \"${payload.publicKey}\",";
  strVar += "                \"narrator\": \"${payload.narrator}\",";
  strVar += "                \"report_link\": \"${payload.reportLink}\",";
  strVar += "                \"pocketReference\": \"${payload.pocketRef}\",";
  strVar += "                \"vendorId\": \"${payload.vendorId}\",";
  strVar += "                \"version\": \"0.2.0\"";
  strVar += "            },";
  strVar += "                function callback(response) {";
  strVar += "                    var resp = { event: 'callback', response };";
  strVar +=
      "                    window.Success.postMessage(JSON.stringify(resp))";
  strVar += "                },";
  strVar += "                function close(close) {";
  strVar += "                    var resp = { event: 'cancelled' };";
  strVar +=
      "                    window.Failure.postMessage(JSON.stringify(resp))";
  strVar += "                })";
  strVar += "        }";
  strVar += "    <\/script>";
  strVar += "<\/body>";
  strVar += "";
  strVar += "<\/html>";

  return strVar;
}
