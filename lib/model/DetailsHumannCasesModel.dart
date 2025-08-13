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
        required this.title,
        required this.description,
        required this.image,
        required this.goalAmount,
        required this.collectedAmount,
        required this.campaignId,
        required this.remainingAmount,
    });

    factory Detailshumanncasesmodel.fromJson(String str) => Detailshumanncasesmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Detailshumanncasesmodel.fromMap(Map<String, dynamic> json) => Detailshumanncasesmodel(
        id: json["id"],
        title: json["title"] ?? "",
        description: json["description"]?? "",
        image: json["image"] ?? "",
        goalAmount: json["goal_amount"]?? "",
        collectedAmount: json["collected_amount"]?? "",
        campaignId: json["campaign_id"],
        remainingAmount: json["remaining_amount"]?? "",
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
