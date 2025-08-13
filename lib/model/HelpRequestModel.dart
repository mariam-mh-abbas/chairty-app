// HelpRequestModel.dart
class HelpRequestModel {
  final String name;
  final String fatherName;
  final String motherName;
  final String gender;
  final DateTime birthDate;
  final String maritalStatus;
  final int numOfMembers;
  final String study;
  final bool hasJob;
  final String? job;
  final String housingType;
  final bool hasFixedIncome;
  final String? fixedIncome;
  final String address;
  final String phone;
  final String mainCategory;
  final String subCategory;
  final String notes;
  final List<Detail> details;

  HelpRequestModel({
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.birthDate,
    required this.maritalStatus,
    required this.numOfMembers,
    required this.study,
    required this.hasJob,
    required this.job,
    required this.housingType,
    required this.hasFixedIncome,
    required this.fixedIncome,
    required this.address,
    required this.phone,
    required this.mainCategory,
    required this.subCategory,
    required this.notes,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "mother_name": motherName,
      "father_name": fatherName,
      "gender": gender,
      "birth_date": birthDate.toIso8601String().split('T')[0], // تحويل التاريخ إلى YYYY-MM-DD
      "marital_status": maritalStatus,
      "num_of_members": numOfMembers,
      "study": study,
      "has_job": hasJob,
      "job": job,
      "housing_type": housingType,
      "has_fixed_income": hasFixedIncome,
      "fixed_income": fixedIncome,
      "address": address,
      "phone": phone,
      "main_category": mainCategory,
      "sub_category": subCategory,
      "notes": notes,
      "details": details.map((detail) => detail.toJson()).toList(), // تحويل التفاصيل إلى JSON
    };
  }
}

class Detail {
  final String fieldName;
  final String fieldValue;

  Detail({
    required this.fieldName,
    required this.fieldValue,
  });

 
  Map<String, dynamic> toJson() {
    return {
      "field_name": fieldName,
      "field_value": fieldValue,
    };
  }
}