class CampaignInfo {
  final int id;
  final String status;

  CampaignInfo({required this.id, required this.status});

  factory CampaignInfo.fromJson(Map<String, dynamic> json) {
    return CampaignInfo(
      id: json['id'],
      status: json['status'] ?? '',
    );
  }
}

class CategoryInfo {
  final int id;
  final String name;

  CategoryInfo({required this.id, required this.name});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}

class InKindModel {
  final int id;
  final String address;
  final CampaignInfo campaign;
  final CategoryInfo category;

  InKindModel({
    required this.id,
    required this.address,
    required this.campaign,
    required this.category,
  });

  factory InKindModel.fromJson(Map<String, dynamic> json) {
    return InKindModel(
      id: json['id'],
      address: json['address'] ?? '',
      campaign: CampaignInfo.fromJson(json['campaign']),
      category: CategoryInfo.fromJson(json['category']),
    );
  }
}
