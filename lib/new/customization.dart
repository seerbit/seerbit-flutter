class CustomizationModel {

  final String? borderColor, 
  backgroundColor,
  buttonColor,
  logo;
  final bool? confetti;
  final List<String>? paymentMethod;

  CustomizationModel({
    this.borderColor,
    this.backgroundColor,
    this.buttonColor,
    this.logo,
    this.confetti,
    this.paymentMethod
  });
}