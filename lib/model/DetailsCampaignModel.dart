import 'package:meta/meta.dart';
import 'dart:convert';

class DetailsCampaignModel {
    final int id;
    final int categoryId;
    final String title;
    final String description;
    final String image;
    final int goalAmount;
    final int collectedAmount;
    final DateTime startDate;
    final DateTime endDate;
    final String? status;
    final int remainingAmount;
    final String? statusLabel;
    final int beneficiariesCount;

    DetailsCampaignModel({
        required this.id,
        required this.categoryId,
        required this.title,
        required this.description,
        required this.image,
        required this.goalAmount,
        required this.collectedAmount,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.remainingAmount,
        required this.statusLabel,
        required this.beneficiariesCount,
    });

    factory DetailsCampaignModel.fromJson(String str) => DetailsCampaignModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DetailsCampaignModel.fromMap(Map<String, dynamic> json) => DetailsCampaignModel(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        goalAmount: json["goal_amount"],
        collectedAmount: json["collected_amount"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"]?? "null",
        remainingAmount: json["remaining_amount"],
        statusLabel: json["status_label"] ?? "null",
        beneficiariesCount: json["beneficiaries_count"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "image": image,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": status,
        "remaining_amount": remainingAmount,
        "status_label": statusLabel,
        "beneficiaries_count": beneficiariesCount,
    };
}
