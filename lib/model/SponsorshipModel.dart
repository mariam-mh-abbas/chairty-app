import 'package:meta/meta.dart';
import 'dart:convert';
class SponsorshipModel {
  final int id;
  final int? categoryId;
  final String? title;
  final String? description;
  final int? monthlyAmount;
  final int? remainingAmount;
  final String? image;

  SponsorshipModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.monthlyAmount,
    required this.remainingAmount,
    required this.image,
  });

  factory SponsorshipModel.fromMap(Map<String, dynamic> json) => SponsorshipModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    monthlyAmount: json["monthly_amount"] ?? 0,
    remainingAmount: json["remaining_amount"] ?? 0,
    image: json["image"] ?? "",
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
