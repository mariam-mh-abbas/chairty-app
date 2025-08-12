part of 'change_passwrd_bloc.dart';

@immutable
sealed class ChangePasswrdState {}

final class ChangePasswrdInitial extends ChangePasswrdState {}

class ChangePasswordSuccess extends ChangePasswrdState {
  // final String message;
  // ChangePasswordSuccess(this.message);
}

class ChangePasswordFailure extends ChangePasswrdState {
  final String message;
  ChangePasswordFailure(this.message);
}
