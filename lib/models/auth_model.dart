class User {
  final int id;
  final String name;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // يجب أن يكون السيرفر يرجع id
      name: json['name'],
      phone: json['phone'],
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
