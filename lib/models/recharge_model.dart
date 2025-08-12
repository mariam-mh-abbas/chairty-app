class RechargeModel {
  final int amount;
  final String date;

  RechargeModel({
    required this.amount,
    required this.date,
  });

  factory RechargeModel.fromJson(Map<String, dynamic> json) {
    return RechargeModel(
      amount: json['amount'] ?? 0,
      date: json['date'] ?? 2025,
    );
  }
}
