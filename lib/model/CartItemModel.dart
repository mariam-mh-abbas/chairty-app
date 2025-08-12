// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartItemModel {
  final int? id;
  final int? Campainid;
  final int? boxId;
final String? name;

final int? Amount;
final String? image;
final String? donationType;
final String? periodic;

  CartItemModel({
    this.id,
    this.name,
    this.Amount,
    this.image,
   
    this.Campainid,
    this.boxId,
     this.donationType,
    this.periodic,
  });

  CartItemModel copyWith({
    int? id,
    String? name,
  
    int? Amount,
    String? image,
     int? boxId,
    int? Campainid,
     String? donationType,
      String? periodic
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
       
      Amount: Amount ?? this.Amount,
      image: image ?? this.image,
      Campainid: Campainid ?? this.Campainid,
      boxId: boxId ?? this.boxId,
      donationType: donationType ?? this.donationType,
      periodic: periodic ?? this.periodic
    );
  }
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      
      'amount': Amount,
      'image': image,
      'campaign_id':Campainid,
      'box_id':boxId,
      'periodic':periodic,
      'donaition_type':donationType,

    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
         
      Amount: map['amount'] != null ? map['amount'] as int : null,
       image: map['image'] != null ? map['image'] as String : null,
       Campainid: map['campaign_id'] != null ? map['campaign_id'] as int : null,
       boxId: map['box_id'] != null ? map['box_id'] as int : null,
        donationType: map['donaition_type'] != null ? map['donaition_type'] as String : null,
        periodic: map['periodic'] != null ? map['periodic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) => CartItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Oncepaymentmodel(id: $id, name: $name, amount: $Amount,image: $image,campaign_id: $Campainid,box_id: $boxId,donaition_type: $donationType,periodic: $periodic,)';

  @override
  bool operator ==(covariant CartItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
    
      other.Amount == Amount&&
      other.image == image&&
      other.Campainid == Campainid&&
      other.boxId == boxId&&
      other.periodic == periodic&&
      other.donationType == donationType;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ Amount.hashCode^ image.hashCode^ Campainid.hashCode^ boxId.hashCode^ periodic.hashCode^ donationType.hashCode;




}


