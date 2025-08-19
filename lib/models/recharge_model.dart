class RechargeModel {
  final int amount;
  final DateTime date;

  RechargeModel({
    required this.amount,
    required this.date,
  });

  factory RechargeModel.fromJson(Map<String, dynamic> json) {
    return RechargeModel(
      amount: json['amount'] ?? 0,
      date: DateTime.tryParse(json["date"] ?? '') ?? DateTime.now(),
    );
  }
}
