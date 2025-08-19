import 'package:meta/meta.dart';
import 'dart:convert';
class SponsorshipModel {
  final int id;
  final int categoryId;
  final String? title;
  final String? description;
  final int? monthlyAmount;
  final int? remainingAmount;
  final String? image;

  SponsorshipModel({
    required this.id,
    required this.categoryId,
     this.title,
     this.description,
     this.monthlyAmount,
     this.remainingAmount,
     this.image,
  });

  factory SponsorshipModel.fromMap(Map<String, dynamic> json) => SponsorshipModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"] as String?,
    description: json["description"] as String?,
    monthlyAmount: json["monthly_amount"] as int?,
    remainingAmount: json["remaining_amount"] as int?,
    image: json["image"] as String?,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "description": description,
    "monthly_amount": monthlyAmount,
    "remaining_amount": remainingAmount,
    "image": image,
  };
}
