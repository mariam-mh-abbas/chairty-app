import 'package:charity_project/models/auth_model.dart';

class ResetPasswordModel {
  final String message;
  final String token;
  final User user;

  ResetPasswordModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
