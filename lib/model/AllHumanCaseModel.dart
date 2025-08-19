import 'package:meta/meta.dart';
import 'dart:convert';

class AllHumancasesmodel {
    final int? id;
    final int? categoryId;
    final String? title;
    final String? description;
    final String? image;
    final int? goalAmount;
    final int? collectedAmount;
    final int? remainingAmount;

    AllHumancasesmodel({
         this.id,
         this.categoryId,
         this.title,
         this.description,
         this.image,
         this.goalAmount,
         this.collectedAmount,
         this.remainingAmount,
    });

    factory AllHumancasesmodel.fromJson(String str) => AllHumancasesmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllHumancasesmodel.fromMap(Map<String, dynamic> json) => AllHumancasesmodel(
        id: json["id"] as int?,
        categoryId: json["category_id"] as int?,
        title: json["title"] as String?,
        description: json["description"]as String?,
        image: json["image"]as String?,
        goalAmount: json["goal_amount"] as int?,
        collectedAmount: json["collected_amount"]as int?,
        remainingAmount: json["remaining_amount"]as int?,
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "image": image,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "remaining_amount": remainingAmount,
    };
}
