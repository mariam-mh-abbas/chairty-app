class DayModel {
  final int? id;
  final String name;
  DayModel({required this.id, required this.name});
  factory DayModel.fromJson(Map<String, dynamic> j) =>
      DayModel(id: j['id'], name: j['name']);
}

class TypeModel {
  final int id;
  final String name;
  TypeModel({required this.id, required this.name});
  factory TypeModel.fromJson(Map<String, dynamic> j) =>
      TypeModel(id: j['id'], name: j['name']);
}

class VolunteerRequestDetailModel {
  final int? id;
  final int? userId;
  final int? adminId;
  final String? name;
  final String? gender;
  final DateTime birthDate;
  final String? address;
  final String? studyQualification;
  final String? job;
  final String? preferredTimes;
  final int? hasPreviousVolunteer;
  final String? previousVolunteer;
  final String? phone;
  final String? notes;
  final String? status;
  final String? reasonOfRejection;
  final List<DayModel> days;
  final List<TypeModel> types;
  final DateTime createdAt;

  VolunteerRequestDetailModel({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.name,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.studyQualification,
    this.job,
    this.preferredTimes,
    required this.hasPreviousVolunteer,
    this.previousVolunteer,
    required this.phone,
    this.notes,
    required this.status,
    this.reasonOfRejection,
    required this.days,
    required this.types,
    required this.createdAt,
  });

  factory VolunteerRequestDetailModel.fromJson(Map<String, dynamic> json) {
    return VolunteerRequestDetailModel(
      id: json['id'],
      userId: json['user_id'],
      adminId: json['admin_id'],
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      birthDate: DateTime.tryParse(json["birth_date"] ?? '') ?? DateTime.now(),
      //  json['birth_date'] != null
      //     ? DateTime.parse(json['birth_date'])
      //     : null,
      address: json['address'] ?? '',
      studyQualification: json['study_qualification'] ?? '',
      job: json['job'] ?? '',
      preferredTimes: json['preferred_times'] ?? '',
      hasPreviousVolunteer: (json['has_previous_volunteer']),
      previousVolunteer: json['previous_volunteer'] ?? '',
      phone: json['phone'] ?? '',
      notes: json['notes'] ?? '',
      status: (json['status']) ?? '',
      reasonOfRejection: json['reason_of_rejection'] ?? '',
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => DayModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => TypeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
      //  json.containsKey('created_at') && json['created_at'] != null
      //     ? DateTime.parse(json['created_at'])
      //     : null,
    );
  }
}
