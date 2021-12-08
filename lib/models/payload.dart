class PayloadModel {
  final String currency,
      email,
      description,
      fullName,
      country,
      amount,
      callbackUrl,
      publicKey,
      narrator,
      reportLink,
      pocketRef,
      vendorId;

  PayloadModel({
    required this.currency,
    required this.email,
    required this.description,
    required this.fullName,
    required this.country,
    required this.amount,
    required this.callbackUrl,
    required this.publicKey,
    required this.narrator,
    required this.reportLink,
    required this.pocketRef,
    required this.vendorId,
  });

  factory PayloadModel.fromJson(Map json) => PayloadModel(
      currency: json["Currency"],
      email: json["Email"],
      description: json["Description"],
      fullName: json['FullName'],
      country: json["Country"],
      amount: json["Amount"],
      callbackUrl: json["CallbackUrl"],
      publicKey: json["PublicKey"],
      narrator: json["Narrator"],
      reportLink: json["ReportLink"],
      pocketRef: json["PocketRef"],
      vendorId: json["VendorId"]);
}
