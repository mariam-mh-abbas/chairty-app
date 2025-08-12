class RequestModel {
  final int id;
  final String name;
  final String status;
  final String createdAt;

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
      createdAt: json['created_at'] ?? '',
    );
  }
}
