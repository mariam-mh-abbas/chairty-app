part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

class RegisterInitial extends AuthBlocState {}

class RegisterLoading extends AuthBlocState {}

class RegisterSuccess extends AuthBlocState {}

class RegisterFailure extends AuthBlocState {
  final String message;

  RegisterFailure(
    this.message,
  );
}

class LoginInitial extends AuthBlocState {}

class LoginLoading extends AuthBlocState {}

class LoginSuccess extends AuthBlocState {}

class LoginFailure extends AuthBlocState {
  final String message;

  LoginFailure(
    this.message,
  );
}

class LogoutInitial extends AuthBlocState {}

class LogoutLoading extends AuthBlocState {}

class LogoutSuccess extends AuthBlocState {}

class LogoutFailure extends AuthBlocState {
  final String message;

  LogoutFailure(
    this.message,
  );
}

class GoogleInitial extends AuthBlocState {}

class GoogleLoading extends AuthBlocState {}

class GoogleSuccess extends AuthBlocState {
  final UserModel user;
  GoogleSuccess(this.user);
}

class GoogleFailure extends AuthBlocState {
  final String message;

  GoogleFailure(
    this.message,
  );
}
