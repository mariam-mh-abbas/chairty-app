import 'package:meta/meta.dart';
import 'dart:convert';

class ArchivedCampaignsModel {
    final int id;
    final String? title;
    final String? description;
    final int? categoryId;
    final int goalAmount;
    final int collectedAmount;
    final DateTime startDate;
    final DateTime endDate;
    final String? status;
    final String? statusLabel;
    final String? image;

    ArchivedCampaignsModel({
        required this.id,
        required this.title,
        required this.description,
        required this.categoryId,
        required this.goalAmount,
        required this.collectedAmount,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.statusLabel,
        required this.image,
    });

    factory ArchivedCampaignsModel.fromJson(String str) => ArchivedCampaignsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ArchivedCampaignsModel.fromMap(Map<String, dynamic> json) => ArchivedCampaignsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        goalAmount: json["goal_amount"],
        collectedAmount: json["collected_amount"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
        statusLabel: json["status_label"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": status,
        "status_label": statusLabel,
        "image": image,
    };
}
