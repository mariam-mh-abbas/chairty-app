import 'package:meta/meta.dart';
import 'dart:convert';

class DetailsCampaignModel {
    final int id;
    final int categoryId;
    final String? title;
    final String? description;
    final String? image;
    final int? goalAmount;
    final int? collectedAmount;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? status;
    final int? remainingAmount;
    final String? statusLabel;
    final int? beneficiariesCount;

    DetailsCampaignModel({
        required this.id,
        required this.categoryId,
         this.title,
         this.description,
         this.image,
         this.goalAmount,
         this.collectedAmount,
         this.startDate,
         this.endDate,
         this.status,
         this.remainingAmount,
         this.statusLabel,
         this.beneficiariesCount,
    });

    factory DetailsCampaignModel.fromJson(String str) => DetailsCampaignModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

   factory DetailsCampaignModel.fromMap(Map<String, dynamic> json) => DetailsCampaignModel(
  id: json["id"] ,
  categoryId: json["category_id"],
  title: json["title"] as String?,
  description: json["description"] as String?,
  image: json["image"] as String?,
  goalAmount: json["goal_amount"] as int?,
  collectedAmount: json["collected_amount"] as int?,
  startDate: DateTime.tryParse(json["start_date"] ?? ""),
  endDate: DateTime.tryParse(json["end_date"] ?? ""),
  status: json["status"] as String?,
  remainingAmount: json["remaining_amount"] as int?,
  statusLabel: json["status_label"] as String?,
  beneficiariesCount: json["beneficiaries_count"] as int?,
);


    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "image": image,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "remaining_amount": remainingAmount,
        "status_label": statusLabel,
        "beneficiaries_count": beneficiariesCount,
    };
}
