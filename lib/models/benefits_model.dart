class BenefitsModel {
  // final int id;
  final String type;
  // final int beneficiaryId;
  final String beneficiaryName;
  final String title;
  final String image;
  final String category;
  // final int? adminId;
  final DateTime date;

  BenefitsModel({
    // required this.id,
    required this.type,
    // required this.beneficiaryId,
    required this.beneficiaryName,
    required this.title,
    required this.image,
    required this.category,
    // this.adminId,
    required this.date,
  });

  factory BenefitsModel.fromJson(Map<String, dynamic> json) {
    return BenefitsModel(
      // id: json["id"],
      type: json["type"] ?? '',
      // beneficiaryId: json["beneficiary_id"],
      beneficiaryName: json["beneficiary_name"] ?? '',
      title: json["title"] ?? '',
      image: json["image"] ?? '',
      category: json["category"] ?? '',
      // adminId: json["admin_id"],
      date: DateTime.tryParse(json["date"] ?? '') ?? DateTime.now(),
    );
  }
}
