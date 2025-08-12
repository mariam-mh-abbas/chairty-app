part of 'change_passwrd_bloc.dart';

@immutable
sealed class ChangePasswrdEvent {}

class SubmitChangePasswordEvent extends ChangePasswrdEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  SubmitChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
