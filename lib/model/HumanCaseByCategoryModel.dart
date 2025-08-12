import 'package:meta/meta.dart';
import 'dart:convert';

class Humancasebycategorymodel {
    final int id;
    final int categoryId;
    final String? title;
    final String? description;
    final String? image;
    final int? goalAmount;
    final int? collectedAmount;
    final int? remainingAmount;
  

    Humancasebycategorymodel({
        required this.id,
        required this.categoryId,
        required this.title,
        required this.description,
        required this.image,
        required this.goalAmount,
        required this.collectedAmount,
        required this.remainingAmount,
       
    });

    factory Humancasebycategorymodel.fromJson(String str) => Humancasebycategorymodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Humancasebycategorymodel.fromMap(Map<String, dynamic> json) => Humancasebycategorymodel(
        id: json["id"] ,
        categoryId: json["category_id"] ,
        title: json["title"] ?? "",
        description: json["description"]?? "",
        image: json["image"]?? "",
        goalAmount: json["goal_amount"]?? "",
        collectedAmount: json["collected_amount"]?? "",
        remainingAmount: json["remaining_amount"]?? "",
      
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
