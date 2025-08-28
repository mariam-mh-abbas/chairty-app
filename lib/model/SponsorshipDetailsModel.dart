import 'package:meta/meta.dart';
import 'dart:convert';

class SponsorshipDetailsmodel {
    final int? id;
    final int? categoryId;
    final String? categoryName;
    final String? title;
    final String? description;
    final int? monthlyAmount;
    final int? remainingAmount;
    final int? collectedAmount;
    final String? image;
    final String? beneficiaryGender;
    final int? campaignId;
    final DateTime? beneficiaryBirthDate;

    SponsorshipDetailsmodel({
         this.id,
         this.categoryId,
         this.categoryName,
         this.title,
         this.description,
         this.monthlyAmount,
         this.remainingAmount,
         this.collectedAmount,
         this.image,
         this.campaignId,
         this.beneficiaryGender,
         this.beneficiaryBirthDate,
    });

    factory SponsorshipDetailsmodel.fromJson(String str) => SponsorshipDetailsmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SponsorshipDetailsmodel.fromMap(Map<String, dynamic> json) => SponsorshipDetailsmodel(
  id: json["id"] as int?,
  categoryId: json["beneficiary_id"] as int?, // حسب البيانات الجديدة
  categoryName: json["type"] as String?,
  title: json["title"] as String?,
  description: json["description"]as String?,
  monthlyAmount: json["goal_amount"]as int?,
  remainingAmount: json["remaining_amount"]as int?,
  collectedAmount: json["collected_amount"]as int?,
  image: json["image"]as String?,
  campaignId: json["campaign_id"]as int?,
  beneficiaryGender: json["gender"] != null && json["gender"] != "" ? json["gender"] : null,
  beneficiaryBirthDate: json["birth_date"] != null ? DateTime.tryParse(json["birth_date"]) : null,
);

    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "category_name": categoryName,
        "title": title,
        "description": description,
        "goal_amount": monthlyAmount,
        "remaining_amount": remainingAmount,
        "collected_amount": collectedAmount,
        "image": image,
         "campaign_id":campaignId,
        "beneficiary_gender": beneficiaryGender,
       "beneficiary_birth_date": beneficiaryBirthDate != null
    ? "${beneficiaryBirthDate!.year.toString().padLeft(4, '0')}-${beneficiaryBirthDate!.month.toString().padLeft(2, '0')}-${beneficiaryBirthDate!.day.toString().padLeft(2, '0')}"
    : null,
    };
}
