class CustomizationModel {
  final String borderColor, backgroundColor, buttonColor, logo;
  final bool confetti;
  final List<PayChannel> paymentMethod;

  const CustomizationModel(
      {this.borderColor = "#000000",
      this.backgroundColor = "#004C64",
      this.buttonColor = "#0084A0",
      this.logo = "logo_url || base64",
      this.confetti = false,
      this.paymentMethod = const [
        PayChannel.account,
        PayChannel.card,
        PayChannel.transfer,
        PayChannel.ussd,
        PayChannel.momo
      ]});
}

enum PayChannel { card, account, transfer, momo, ussd }

String getPayChannel(PayChannel channel) {
  switch (channel) {
    case PayChannel.account:
      return "account";
    case PayChannel.card:
      return "card";
    case PayChannel.transfer:
      return "transfer";
    case PayChannel.momo:
      return "wallet";
    case PayChannel.ussd:
      return "ussd";
    default:
      return "card";
  }
}
