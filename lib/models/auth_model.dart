// class User {
//   final String name;
//   final String phone;
//   final int id;

//   User({
//     required this.name,
//     required this.phone,
//     required this.id,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//     );
//   }
// }
class User {
  final String name;
  final String? phone; // كان String
  final int id;

  User({
    required this.name,
    this.phone,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      phone: json['phone'], // nullable
    );
  }
}

class Auth_model {
  final String accessToken;
  final User user;

  Auth_model({required this.accessToken, required this.user});

  factory Auth_model.fromJson(Map<String, dynamic> json) {
    return Auth_model(
      accessToken: json['access_token'],
      user: User.fromJson(json['user']),
    );
  }
}

class Auth_model1 {
  final String accessToken;
  final User user;

  Auth_model1({required this.accessToken, required this.user});

  factory Auth_model1.fromJson(Map<String, dynamic> json) {
    return Auth_model1(
      accessToken: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

// class UserModel {
//   final int id;
//   final String name;
//   final String? phone;
//   final String email;
//   final String? googleId;
//   final String? profileImage;
//   final String preferredLanguage;
//   final int balance;

//   UserModel({
//     required this.id,
//     required this.name,
//     this.phone,
//     required this.email,
//     this.googleId,
//     this.profileImage,
//     required this.preferredLanguage,
//     required this.balance,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//       email: json['email'],
//       googleId: json['google_id'],
//       profileImage: json['profile_image'],
//       preferredLanguage: json['preferred_language'],
//       balance: json['balance'],
//     );
//   }
// }
class UserModel {
  final int id;
  final String name;
  final String? phone;
  final String email;
  final String? googleId;
  final String? profileImage;
  final String preferredLanguage;
  final int balance;

  UserModel({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    this.googleId,
    this.profileImage,
    required this.preferredLanguage,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      phone: json['phone'], // nullable
      email: json['email'] ?? "",
      googleId: json['google_id'], // nullable
      profileImage: json['profile_image'], // nullable
      preferredLanguage: json['preferred_language'] ?? "en",
      balance:
          int.tryParse(json['balance']?.toString() ?? "0") ?? 0, // safe parse
    );
  }
}

class GoogleLoginResponse {
  final String message;
  final String accessToken;
  final UserModel user;

  GoogleLoginResponse({
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory GoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    return GoogleLoginResponse(
      message: json['message'],
      accessToken: json['access_token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
