class CustomizationModel {
  final String borderColor, backgroundColor, buttonColor, logo;
  final bool confetti;
  final List<String>? paymentMethod;

  const CustomizationModel(
      {this.borderColor = "#000000",
      this.backgroundColor = "#004C64",
      this.buttonColor = "#0084A0",
      this.logo = "logo_url || base64",
      this.confetti = false,
      this.paymentMethod});
}
