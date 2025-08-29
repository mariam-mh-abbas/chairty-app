import 'package:meta/meta.dart';
import 'dart:convert';

class ArchivedHumanCasesModel {
    final int? id;
    final int? isEmergency;
    final String? title;
    final String? description;
    final int? categoryId;
    final int? goalAmount;
    final int? collectedAmount;
    final String? image;

    ArchivedHumanCasesModel({
         this.id,
         this.isEmergency,
         this.title,
         this.description,
         this.categoryId,
         this.goalAmount,
         this.collectedAmount,
         this.image,
    });

    factory ArchivedHumanCasesModel.fromJson(String str) => ArchivedHumanCasesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ArchivedHumanCasesModel.fromMap(Map<String, dynamic> json) => ArchivedHumanCasesModel(
        id: json["id"] as int?,
        isEmergency: json["is_emergency"] as int?,
        title: json["title"]as String?,
        description: json["description"] as String?,
        categoryId: json["category_id"] as int?,
        goalAmount: json["goal_amount"] as int?,
        collectedAmount: json["collected_amount"] as int?,
        image: json["image"] as String?,
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
