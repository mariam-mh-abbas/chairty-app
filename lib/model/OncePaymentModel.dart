import 'package:meta/meta.dart';
import 'dart:convert';

class OncePaymentmodel {
    final int? campaignId;
    final int? boxId;
    final int amount;

    OncePaymentmodel({
        required this.campaignId,
        required this.boxId,
        required this.amount,
    });

    factory OncePaymentmodel.fromJson(String str) => OncePaymentmodel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OncePaymentmodel.fromMap(Map<String, dynamic> json) => OncePaymentmodel(
        campaignId: json["campaign_id"],
        boxId: json["box_id"],
        amount: json["amount"],
    );

    Map<String, dynamic> toMap() => {
        "campaign_id": campaignId,
        "box_id": boxId,
        "amount": amount,
    };
}
