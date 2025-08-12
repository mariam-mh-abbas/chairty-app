part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class RegisterUser extends AuthBlocEvent {
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;
  final String preferredLanguage;
  final String otp;

  RegisterUser(
      {required this.name,
      required this.phone,
      required this.password,
      required this.confirmPassword,
      required this.otp,
      required this.preferredLanguage});
}

class LoginUser extends AuthBlocEvent {
  final String phone;
  final String password;

  LoginUser({
    required this.phone,
    required this.password,
  });
}

class LogoutUser extends AuthBlocEvent {}

class LoginWithGoogle extends AuthBlocEvent {
  final String accessToken;
  final String preferredLanguage;

  LoginWithGoogle({
    required this.accessToken,
    required this.preferredLanguage,
  });
}
