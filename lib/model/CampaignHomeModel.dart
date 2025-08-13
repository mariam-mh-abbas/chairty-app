// import 'package:meta/meta.dart';
// import 'dart:convert';

// @immutable
// class CampaignHomeModel {
//   final int id;
//   final String title;
//   final String description;
//   final String? image;
//   final int goalAmount;
//   final int collectedAmount;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String status;
//   final int remainingAmount;
//   final String statusLabel;

//   const CampaignHomeModel ({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.goalAmount,
//     required this.collectedAmount,
//     required this.startDate,
//     required this.endDate,
//     required this.status,
//     required this.remainingAmount,
//     required this.statusLabel,
//   });

//   /// Factory لتحويل JSON String إلى كائن CampaignHome
//   factory CampaignHomeModel .fromJson(String str) =>
//       CampaignHomeModel .fromMap(json.decode(str));

//   /// تحويل الكائن إلى JSON String
//   String toJson() => json.encode(toMap());

//   /// Factory لتحويل Map إلى كائن CampaignHome
//   factory CampaignHomeModel .fromMap(Map<String, dynamic> json) {
//     return CampaignHomeModel (
//       id: json["id"] ,
//       title: json["title"] ,
//       description: json["description"] ,
//       image: json["image"], // قد تكون null
//       goalAmount: json["goal_amount"] ,
//       collectedAmount: json["collected_amount"] ,
//       startDate: DateTime.tryParse(json["start_date"] ?? '') ?? DateTime.now(),
//       endDate: DateTime.tryParse(json["end_date"] ?? '') ?? DateTime.now(),
//       status: json["status"] ,
//       remainingAmount: json["remaining_amount"] ,
//       statusLabel: json["status_label"] ,
//     );
//   }

//   /// تحويل الكائن إلى Map لسهولة الإرسال/الحفظ
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "image": image,
//         "goal_amount": goalAmount,
//         "collected_amount": collectedAmount,
//         "start_date": startDate.toIso8601String(),
//         "end_date": endDate.toIso8601String(),
//         "status": status,
//         "remaining_amount": remainingAmount,
//         "status_label": statusLabel,
//       };
// }

import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class CampaignHomeModel {
  final int id;
  final String title;
  final String description;
  final String? image;
  final int goalAmount;
  final int collectedAmount;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int remainingAmount;
  final String statusLabel;

  const CampaignHomeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.goalAmount,
    required this.collectedAmount,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.remainingAmount,
    required this.statusLabel,
  });

  /// 🔥 يمكنك حذف هذا إذا لم تعد تستخدمه
  // factory CampaignHomeModel.fromJson(String str) =>
  //     CampaignHomeModel.fromMap(json.decode(str));

  /// تحويل الكائن إلى JSON String
  String toJson() => json.encode(toMap());

  /// Factory لتحويل Map إلى كائن CampaignHome
  factory CampaignHomeModel.fromMap(Map<String, dynamic> json) {
    return CampaignHomeModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      goalAmount: json["goal_amount"],
      collectedAmount: json["collected_amount"],
      startDate: DateTime.tryParse(json["start_date"] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json["end_date"] ?? '') ?? DateTime.now(),
      status: json["status"],
      remainingAmount: json["remaining_amount"],
      statusLabel: json["status_label"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "goal_amount": goalAmount,
        "collected_amount": collectedAmount,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": status,
        "remaining_amount": remainingAmount,
        "status_label": statusLabel,
      };
}
