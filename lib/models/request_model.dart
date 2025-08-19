class RequestModel {
  final int id;
  final String name;
  final String status;
  final DateTime createdAt;

  RequestModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime.now(),
      // json['created_at'] ?? '',
    );
  }
}
