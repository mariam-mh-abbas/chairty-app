import 'package:meta/meta.dart';
import 'dart:convert';

class Humancasesmodel {
    final int id;
    final int categoryId;
    final String? title;
    final String? description;
    final String? image;
    final int? goalAmount;
    final int? collectedAmount;
    final int? remainingAmount;
    final DateTime startDate;
    final DateTime endDate;

    Humancasesmodel({
        required this.id,
        required this.categoryId,
        required this.title,
        required this.description,
        required this.image,
        required this.goalAmount,
        required this.collectedAmount,
        required this.remainingAmount,
        required this.startDate,
        required this.endDate,
    });

    factory Humancasesmodel.fromJson(String str) => Humancasesmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Humancasesmodel.fromMap(Map<String, dynamic> json) => Humancasesmodel(
        id: json["id"] ,
        categoryId: json["category_id"] ,
        title: json["title"] ?? "",
        description: json["description"]?? "",
        image: json["image"]?? "",
        goalAmount: json["goal_amount"]?? "",
        collectedAmount: json["collected_amount"]?? "",
        remainingAmount: json["remaining_amount"]?? "",
        startDate: DateTime.parse(json["start_date"]) ,
        endDate: DateTime.parse(json["end_date"]),
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
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    };
}
