///Model for the Payload  that takes in all the needed payment data
import "customization.dart";
import "split.dart";

class PayloadModel {
  final CustomizationModel customization;
  final SplitModel? splits;
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
      vendorId,
      planId;
  final String? reportLink;

  final bool? closeOnSuccess;
  final bool? closePrompt;
  final bool? setAmountByCustomer;
  final bool? tokenize;
  final Map<String, dynamic>? metaData;

  PayloadModel(
      {required this.currency,
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
      this.tokenize = false,
      this.planId,
      this.metaData,
      this.customization = const CustomizationModel(),
      this.splits});

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
      tokenize: json['tokenize'],
      customization: json['customization'],
      planId: json['planId'],
      metaData: json['metaData'],
      splits: json['splits']);
}
