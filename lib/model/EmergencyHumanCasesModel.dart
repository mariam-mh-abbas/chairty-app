import 'dart:convert';

import 'package:flutter/material.dart';

class Emergencyhumancasesmodel {
  
@immutable

  final int id;
  final int categoryId;
  final String title;
  final String description;
  final String? image;
  final int goalAmount;
  final int collectedAmount;
  final int remainingAmount;

  const Emergencyhumancasesmodel({
    required this.id,
     required this.categoryId,
    required this.title,
    required this.description,
    required this.image,
    required this.goalAmount,
    required this.collectedAmount,
    required this.remainingAmount,
  });


  /// تحويل الكائن إلى JSON String
  String toJson() => json.encode(toMap());

  /// Factory لتحويل Map إلى كائن CampaignHome
  factory Emergencyhumancasesmodel.fromMap(Map<String, dynamic> json) {
    return Emergencyhumancasesmodel(
      id: json["id"],
      categoryId : json["category_id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      goalAmount: json["goal_amount"],
      collectedAmount: json["collected_amount"],
      remainingAmount: json["remaining_amount"],
    );
  }

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