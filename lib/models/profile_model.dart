import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';

class ProfileModel {
  final String name;
  final String? phone;
  final String? profileImage;
  final String? email;
  final int balance;

  ProfileModel({
    required this.name,
    required this.phone,
    this.profileImage,
    this.email,
    required this.balance,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      profileImage: _formatImage(json['profile_image']),
      email: json['email'] ?? '',
      balance: json['balance'] ?? 0,
    );
  }
  static String _formatImage(dynamic img) {
    if (img == null) return '';
    if (img.toString().startsWith('http')) {
      return img;
    }

    return '$baseUrl/storage/$img';
  }
}
