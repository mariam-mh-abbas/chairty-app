class VolunteerRequestModel {
  final String fullName;
  final String gender;
  final String birthDate; 
  final String address;
  final String studyQualification;
  final String? job;
  final String preferredTimes;
  final bool hasPreviousVolunteer;
  final String? previousVolunteer;
  final String phone;
  final String? notes;
  final List<String> days;
  final List<String> types;

  VolunteerRequestModel({
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.studyQualification,
    required this.job,
    required this.preferredTimes,
    required this.hasPreviousVolunteer,
    required this.previousVolunteer,
    required this.phone,
    required this.notes,
    required this.days,
    required this.types,
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "gender": gender,
      "birth_date": birthDate,
      "address": address,
      "study_qualification": studyQualification,
      "job": job,
      "preferred_times": preferredTimes,
      "has_previous_volunteer": hasPreviousVolunteer,
      "previous_volunteer": previousVolunteer,
      "phone": phone,
      "notes": notes,
      "days": days,
      "types": types,
    };
  }
}
