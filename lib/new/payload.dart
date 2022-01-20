///Model for the Payload  that takes in all the needed payment data
class PayloadModel {
  final String currency,
      email,
      description,
      fullName,
      country,
      amount,
      callbackUrl,
      publicKey,
      transRef,
      narrator,
      pocketRef,
      vendorId;
  final String? reportLink;
  PayloadModel({
    required this.currency,
    required this.transRef,
    required this.email,
    required this.description,
    required this.fullName,
    required this.country,
    required this.amount,
    required this.callbackUrl,
    required this.publicKey,
    this.narrator = 'seerbit-react-native',
    this.reportLink = "",
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
      reportLink: json["ReportLink"],
      pocketRef: json["PocketRef"],
      vendorId: json["VendorId"],
      transRef: json['TransRef']);
}
