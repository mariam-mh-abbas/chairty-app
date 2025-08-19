 import 'dart:convert';

import 'package:flutter/material.dart';
class Allcampaignmodel {
 

@immutable

  final int? id;
  final int? categoryId;
  final String? title;
  final String? description;
  final String? image;
  final int? goalAmount;
  final int? collectedAmount;

  final int? remainingAmount;
  

  const Allcampaignmodel({
    this.id,
     this.categoryId,
     this.title,
     this.description,
     this.image,
     this.goalAmount,
     this.collectedAmount,
    
     this.remainingAmount,
    
  });


  String toJson() => json.encode(toMap());

  
  factory Allcampaignmodel.fromMap(Map<String, dynamic> json) {
    return Allcampaignmodel(
      id: json["id"] as int?,
      categoryId : json["category_id"] as int?,
      title: json["title"]as String?,
      description: json["description"] as String?,
      image: json["image"] as String?,
      goalAmount: json["goal_amount"] as int?,
      collectedAmount: json["collected_amount"] as int?,
    
      remainingAmount: json["remaining_amount"] as int?,
      
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

