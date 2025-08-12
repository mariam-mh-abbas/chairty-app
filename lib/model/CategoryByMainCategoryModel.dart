// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categorybymaincategorymodel {
  int id;
  String name;
  String main_category;
  Categorybymaincategorymodel({
    required this.id,
    required this.name,
    required this.main_category,
  });

  Categorybymaincategorymodel copyWith({
    int? id,
    String? name,
    String? main_category,
  }) {
    return Categorybymaincategorymodel(
      id: id ?? this.id,
      name: name ?? this.name,
      main_category: main_category ?? this.main_category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'main_category': main_category,
    };
  }

  factory Categorybymaincategorymodel.fromMap(Map<String, dynamic> map) {
    return Categorybymaincategorymodel(
      id: map['id'] as int,
      name: map['name'] as String,
      main_category: map['main_category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorybymaincategorymodel.fromJson(String source) => Categorybymaincategorymodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Categorybymaincategorymodel(id: $id, name: $name, main_category: $main_category)';

  @override
  bool operator ==(covariant Categorybymaincategorymodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.main_category == main_category;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ main_category.hashCode;
}
