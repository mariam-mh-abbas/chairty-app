class RegisterModel {
  final String name;
  final String phone;
  final String password;
  final String passwordConfirmation;
  final String otp;

  RegisterModel({
    required this.name,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'otp': otp,
    };
  }
}
