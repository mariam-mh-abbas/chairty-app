class DetailItem {
  final int? id;
  final String fieldName;
  final String fieldValue;

  DetailItem({
    required this.id,
    required this.fieldName,
    required this.fieldValue,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) {
    return DetailItem(
      id: json['id'],
      fieldName: json['field_name'] ?? '',
      fieldValue: json['field_value'] ?? '',
    );
  }

  DetailItem copyWith({
    String? fieldName,
    String? fieldValue,
  }) {
    return DetailItem(
      id: id,
      fieldName: fieldName ?? this.fieldName,
      fieldValue: fieldValue ?? this.fieldValue,
    );
  }
}

class HelpRequestDetailModel {
  final int? id;
  final int? userId;
  final int? adminId;
  final String? name;
  final String? fatherName;
  final String? motherName;
  final String? gender;
  final DateTime? birthDate;
  final String? maritalStatus;
  final int? numOfMembers;
  final String? study;
  final bool hasJob;
  final String? job;
  final String? housingType;
  final bool hasFixedIncome;
  final String? fixedIncome;
  final String? address;
  final String? phone;
  final String? mainCategory;
  final String? subCategory;
  final String? notes;
  final String status;
  final String? reasonOfRejection;
  final DateTime? createdAt;
  final List<DetailItem> details;

  HelpRequestDetailModel({
    required this.id,
    required this.userId,
    this.adminId,
    this.name,
    this.fatherName,
    this.motherName,
    this.gender,
    this.birthDate,
    this.maritalStatus,
    this.numOfMembers,
    this.study,
    required this.hasJob,
    this.job,
    this.housingType,
    required this.hasFixedIncome,
    this.fixedIncome,
    this.address,
    this.phone,
    this.mainCategory,
    this.subCategory,
    this.notes,
    required this.status,
    this.reasonOfRejection,
    this.createdAt,
    required this.details,
  });

  factory HelpRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return HelpRequestDetailModel(
      id: json['id'],
      userId: json['user_id'],
      adminId: json['admin_id'],
      name: json['name'] ?? 'name',
      fatherName: json['father_name'] ?? 'father_name',
      motherName: json['mother_name'] ?? 'mother_name',
      gender: json['gender'] ?? 'gender',
      birthDate: json.containsKey('birth_date') && json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      maritalStatus: json['marital_status'] ?? '',
      numOfMembers: json['num_of_members'] ?? 0,
      study: json['study'] ?? 'study',
      hasJob: (json['has_job'] is int
          ? (json['has_job'] as int) != 0
          : (json['has_job'] as bool? ?? false)),
      job: json['job'] ?? "-",
      housingType: json['housing_type'],
      hasFixedIncome: (json['has_fixed_income'] is int
          ? (json['has_fixed_income'] as int) != 0
          : (json['has_fixed_income'] as bool? ?? false)),
      fixedIncome: json['fixed_income'] ?? '-',
      address: json['address'] ?? 'address',
      phone: json['phone'] ?? 0,
      mainCategory: json['main_category'] ?? 'main_category',
      subCategory: json['sub_category'] ?? 'sub_category',
      notes: json['notes'] ?? '-',
      status: (json['status']) ?? 'status',
      reasonOfRejection: json['reason_of_rejection'],
      createdAt: json.containsKey('created_at') && json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      details: (json['details'] as List<dynamic>?)
              ?.map((e) => DetailItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  HelpRequestDetailModel copyWith({
    String? name,
    String? fatherName,
    String? motherName,
    String? gender,
    DateTime? birthDate,
    String? maritalStatus,
    int? numOfMembers,
    String? study,
    bool? hasJob,
    String? job,
    String? housingType,
    bool? hasFixedIncome,
    String? fixedIncome,
    String? address,
    String? phone,
    String? mainCategory,
    String? subCategory,
    String? notes,
    String? status,
    String? reasonOfRejection,
    DateTime? createdAt,
    List<DetailItem>? details,
  }) {
    return HelpRequestDetailModel(
      id: id,
      userId: userId,
      adminId: adminId,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      numOfMembers: numOfMembers ?? this.numOfMembers,
      study: study ?? this.study,
      hasJob: hasJob ?? this.hasJob,
      job: job ?? this.job,
      housingType: housingType ?? this.housingType,
      hasFixedIncome: hasFixedIncome ?? this.hasFixedIncome,
      fixedIncome: fixedIncome ?? this.fixedIncome,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      reasonOfRejection: reasonOfRejection ?? this.reasonOfRejection,
      createdAt: createdAt ?? this.createdAt,
      details: details ?? this.details,
    );
  }
}
