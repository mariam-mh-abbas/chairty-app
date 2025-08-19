import 'package:meta/meta.dart';
import 'dart:convert';

class Detailshumanncasesmodel {
    final int id;
    final String? title;
    final String? description;
    final String? image;
    final int? goalAmount;
    final int? collectedAmount;
    final int campaignId;
    final int? remainingAmount;

    Detailshumanncasesmodel({
        required this.id,
         this.title,
         this.description,
         this.image,
         this.goalAmount,
         this.collectedAmount,
        required this.campaignId,
         this.remainingAmount,
    });

    factory Detailshumanncasesmodel.fromJson(String str) => Detailshumanncasesmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Detailshumanncasesmodel.fromMap(Map<String, dynamic> json) => Detailshumanncasesmodel(
        id: json["id"],
        title: json["title"] as String?,
        description: json["description"]as String?,
        image: json["image"] as String?,
        goalAmount: json["goal_amount"]as int?,
        collectedAmount: json["collected_amount"]as int?,
        campaignId: json["campaign_id"],
        remainingAmount: json["remaining_amount"]as int?,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "campaign_id":campaignId,
        "remaining_amount": remainingAmount,
    };
}
