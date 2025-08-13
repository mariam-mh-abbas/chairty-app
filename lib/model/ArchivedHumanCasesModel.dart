import 'package:meta/meta.dart';
import 'dart:convert';

class ArchivedHumanCasesModel {
    final int? id;
    final int? isEmergency;
    final String? title;
    final String? description;
    final int? categoryId;
    final int goalAmount;
    final int collectedAmount;
    final String? image;

    ArchivedHumanCasesModel({
        required this.id,
        required this.isEmergency,
        required this.title,
        required this.description,
        required this.categoryId,
        required this.goalAmount,
        required this.collectedAmount,
        required this.image,
    });

    factory ArchivedHumanCasesModel.fromJson(String str) => ArchivedHumanCasesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ArchivedHumanCasesModel.fromMap(Map<String, dynamic> json) => ArchivedHumanCasesModel(
        id: json["id"],
        isEmergency: json["is_emergency"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        goalAmount: json["goal_amount"],
        collectedAmount: json["collected_amount"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "is_emergency": isEmergency,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "image": image,
    };
}
