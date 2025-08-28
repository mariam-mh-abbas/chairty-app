class RegularModel {
  final String title;
  final String? image;
  final double amount;
  final DateTime date;
  final String? pdfUrl;

  RegularModel({
    required this.title,
    required this.image,
    required this.amount,
    required this.date,
    required this.pdfUrl,
  });

  factory RegularModel.fromJson(Map<String, dynamic> json) {
    return RegularModel(
      title: json['title'] ?? '',
      image: json['image'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.tryParse(json["date"] ?? '') ?? DateTime.now(),
      pdfUrl: json['pdf_url'],
    );
  }
}
