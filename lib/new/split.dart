class SplitModel {
  final String type;
  final String transactionFee;
  final String bearerSubAccountCode;
  final List<FeeItem> items;

  SplitModel({
    required this.type,
    required this.transactionFee,
    required this.bearerSubAccountCode,
    required this.items,
  });

  factory SplitModel.fromJson(Map<String, dynamic> json) {
    return SplitModel(
      type: json['type'],
      transactionFee: json['transactionFee'],
      bearerSubAccountCode: json['bearerSubAccountCode'],
      items: (json['items'] as List)
          .map((item) => FeeItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'transactionFee': transactionFee,
        'bearerSubAccountCode': bearerSubAccountCode,
        'items': items.map((item) => item.toJson()).toList(),
      };
}

class FeeItem {
  final String subAccountCode;
  final String value;

  FeeItem({
    required this.subAccountCode,
    required this.value,
  });

  factory FeeItem.fromJson(Map<String, dynamic> json) {
    return FeeItem(
      subAccountCode: json['subAccountCode'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'subAccountCode': subAccountCode,
        'value': value,
      };
}
