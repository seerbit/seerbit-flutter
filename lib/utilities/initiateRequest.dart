String initRequest(dynamic payload, String reportLink) {
  return "<!DOCTYPE html> \n" +
      '<html lang="en">\n' +
      "<head>" +
      '<meta charset="UTF-8">\n' +
      '<meta http-equiv="X-UA-Compatible" content="ie=edge">\n' +
      '<meta name="viewport" content="width=device-width, initial-scale=1.0">\n' +
      '<title>SeerBit</title>\n' +
      "</head>\n" +
      '<body  onload="paywithSeerbit()" style="background-color:#fff;height:100vh ">\n' +
      '<form>\n' +
      '<script src="https://checkout.seerbitapi.com/api/v2/seerbit.js"></script>\n' +
      '</form>\n' +
      '<script>\n' +
      "function paywithSeerbit() {\n" +
      'SeerbitPay({\n' +
      '"tranref": "${payload.transaction_reference}",\n' +
      '"currency": "${payload.currency}",\n' +
      '"email": "${payload.email ? payload.email : ''}",\n' +
      '"description":"${payload.description}",\n' +
      '"full_name":"${payload.full_name ? payload.full_name : ''}",\n' +
      '"country": "${payload.country}",\n' +
      '"amount": "${payload.amount}",\n' +
      '"callbackurl": "${payload.callbackurl}",\n' +
      '"public_key":"${payload.public_key}",\n' +
      '"narrator":"seerbit-react-native",\n' +
      '"report_link":"$reportLink",\n' +
      '"pocketReference":"${payload.pocket_reference}",\n' +
      '"vendorId":"${payload.vendor_id}",\n' +
      '"version": "0.2.0"\n' +
      '}, ' +
      'function callback(response) {' +
      "var resp = {event:'callback', response};" +
      'console.log(JSON.stringify(resp))\n' +
      '}, \n' +
      'function close(close) {\n' +
      "var resp = {event:'cancelled'};\n" +
      "console.log(JSON.stringify(resp))\n" +
      "})\n" +
      "}\n" +
      "</script>\n" +
      "</body>\n" +
      "</html>\n";
}
