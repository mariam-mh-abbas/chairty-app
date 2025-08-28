class VolunteeringModel {
  // final int campaignId;
  final String campaignTitle;
  final String campaignImage;
  final DateTime campaignDate;
  // final int volunteerId;
  final String volunteerName;
  final List<String> volunteeringType;

  VolunteeringModel({
    // required this.campaignId,
    required this.campaignTitle,
    required this.campaignImage,
    required this.campaignDate,
    // required this.volunteerId,
    required this.volunteerName,
    required this.volunteeringType,
  });

  factory VolunteeringModel.fromJson(Map<String, dynamic> json) {
    return VolunteeringModel(
      // campaignId: json["campaign_id"] ,
      campaignTitle: json["campaign_title"] ?? '',
      campaignImage: json["campaign_image"] ?? '',
      campaignDate:
          DateTime.tryParse(json["campaign_date"] ?? '') ?? DateTime.now(),
      // json["campaign_date"],
      // volunteerId: json["volunteer_id"],
      volunteerName: json["volunteer_name"] ?? '',
      volunteeringType: List<String>.from(json["volunteering_type"]) ?? [],
    );
  }
}
