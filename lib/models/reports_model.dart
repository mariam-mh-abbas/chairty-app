class ReportsModel {
  final int id;
  final int? campaignId;
  final int? sponsorshipId;
  final String fileUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Campaign? campaign;

  ReportsModel({
    required this.id,
    this.campaignId,
    this.sponsorshipId,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
    this.campaign,
  });

  factory ReportsModel.fromJson(Map<String, dynamic> json) {
    return ReportsModel(
      id: json['id'],
      campaignId: json['campaign_id'],
      sponsorshipId: json['sponsorship_id'],
      fileUrl: json['file_url'],
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
      // json['created_at'],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? '') ?? DateTime.now(),
      // json['updated_at'],
      campaign:
          json['campaign'] != null ? Campaign.fromJson(json['campaign']) : null,
    );
  }
}

class Campaign {
  final int id;
  final String title;
  final String image;
  final int remainingAmount;
  final String? statusLabel;

  Campaign({
    required this.id,
    required this.title,
    required this.image,
    required this.remainingAmount,
    this.statusLabel,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      remainingAmount: json['remaining_amount'],
      statusLabel: json['status_label'],
    );
  }
}
