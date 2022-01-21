///Model for the Payload  that takes in all the needed payment data
import "customization.dart";
class PayloadModel {
  final CustomizationModel? customization;
  final String? currency,
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
  final bool? closeOnSuccess;
  final bool? closePrompt;
  final bool? setAmountByCustomer;
  PayloadModel({
    required this.currency,
    required this.transRef,
     this.email,
     this.description,
     this.fullName,
    required this.country,
    required this.amount,
     this.callbackUrl,
    required this.publicKey,
    this.narrator = 'seerbit-react-native',
    this.reportLink = "",
     this.pocketRef,
     this.vendorId,
     this.closeOnSuccess,
     this.closePrompt,
     this.setAmountByCustomer,
     this.customization
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
      transRef: json['TransRef'],
      setAmountByCustomer: json['SetAmountByCustomer'],
      closePrompt: json['ClosePrompt'],
      closeOnSuccess: json['CloseOnSuccess'],
      customization: json['customization']
      );
}
