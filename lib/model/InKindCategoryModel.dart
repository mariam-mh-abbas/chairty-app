import 'package:meta/meta.dart';
import 'dart:convert';

class InKindCategorymodel {
    final String address;
    final String phone;
    final String otp;
    final List<int> categoryIds;

    InKindCategorymodel({
        required this.address,
        required this.phone,
        required this.otp,
        required this.categoryIds,
    });

    factory InKindCategorymodel.fromJson(String str) => InKindCategorymodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InKindCategorymodel.fromMap(Map<String, dynamic> json) => InKindCategorymodel(
        address: json["address"],
        phone: json["phone"],
        otp: json["otp"],
        categoryIds: List<int>.from(json["category_ids"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "phone": phone,
        "otp": otp,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
    };
}
