class GiftModel {
  final int amount;
  final String recipient_name;
  final String donated_at;

  GiftModel({
    required this.amount,
    required this.recipient_name,
    required this.donated_at,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      amount: json['amount'] ?? 0,
      recipient_name: json['recipient_name'] ?? 'recipient_name',
      donated_at: json['donated_at'] ?? '2025',
    );
  }
}
