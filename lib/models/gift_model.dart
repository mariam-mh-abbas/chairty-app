class GiftModel {
  final int amount;
  final String recipient_name;
  final DateTime donated_at;
  final String? pdfUrl;

  GiftModel({
    required this.amount,
    required this.recipient_name,
    required this.donated_at,
    this.pdfUrl,
  });

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      amount: json['amount'] ?? 0,
      recipient_name: json['recipient_name'] ?? 'recipient_name',
      donated_at: DateTime.tryParse(json["donated_at"] ?? '') ?? DateTime.now(),
      //  json['donated_at'] ?? '2025',
      pdfUrl: json['pdf_url'],
    );
  }
}
