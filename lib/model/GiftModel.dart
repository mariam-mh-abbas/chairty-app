import 'package:meta/meta.dart';
import 'dart:convert';

class Giftmodel {
    final int amount;
    final String recipientName;
    final String recipientPhone;
    final String? message;
    final bool isHide;

    Giftmodel({
        required this.amount,
        required this.recipientName,
        required this.recipientPhone,
        required this.message,
        required this.isHide,
    });

    factory Giftmodel.fromJson(String str) => Giftmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Giftmodel.fromMap(Map<String, dynamic> json) => Giftmodel(
        amount: json["amount"],
        recipientName: json["recipient_name"],
        recipientPhone: json["recipient_phone"],
        message: json["message"] ?? null,
        isHide: json["is_hide"],
    );

    Map<String, dynamic> toMap() => {
        "amount": amount,
        "recipient_name": recipientName,
        "recipient_phone": recipientPhone,
        "message": message,
        "is_hide": isHide,
    };
}
