import 'package:meta/meta.dart';

class BoxModel {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final List<BoxModel> children;

  BoxModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.price,
    required this.children,
  });

  factory BoxModel.fromMap(Map<String, dynamic> json) => BoxModel(
    id: json['id'] ?? "",
    name: json['name'] ?? '',
    description: json['description'],
    image: json['image'] ?? "",
    price: json['price']?.toString(),
    children: (json['children'] as List<dynamic>? ?? [])
        .map((e) => BoxModel.fromMap(e))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "children": children.map((e) => e.toMap()).toList(),
  };
}
