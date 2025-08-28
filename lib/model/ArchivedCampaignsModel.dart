import 'package:meta/meta.dart';
import 'dart:convert';

class ArchivedCampaignsModel {
    final int? id;
    final String? title;
    final String? description;
    final int? categoryId;
    final int? goalAmount;
    final int? collectedAmount;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? status;
    final String? statusLabel;
    final String? image;

    ArchivedCampaignsModel({
         this.id,
         this.title,
         this.description,
         this.categoryId,
         this.goalAmount,
         this.collectedAmount,
         this.startDate,
         this.endDate,
         this.status,
         this.statusLabel,
         this.image,
    });

    factory ArchivedCampaignsModel.fromJson(String str) => ArchivedCampaignsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ArchivedCampaignsModel.fromMap(Map<String, dynamic> json) => ArchivedCampaignsModel(
        id: json["id"] as int?,
        title: json["title"] as String?,
        description: json["description"] as String?,
        categoryId: json["category_id"] as int?,
        goalAmount: json["goal_amount"] as int?,
        collectedAmount: json["collected_amount"] as int?,
        startDate: json["start_date"] != null
          ? DateTime.tryParse(json["start_date"])
          : null,
      endDate: json["end_date"] != null
          ? DateTime.tryParse(json["end_date"])
          : null,
        status: json["status"] as String?,
        statusLabel: json["status_label"] as String?,
        image: json["image"] as String?,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "status": status,
        "status_label": statusLabel,
        "image": image,
    };
}
