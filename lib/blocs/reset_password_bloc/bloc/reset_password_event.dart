part of 'reset_password_bloc.dart';

@immutable
sealed class ResetPasswordEvent {}

class SubmitResetPassword extends ResetPasswordEvent {
  final String phone;
  final String password;
  final String passwordConfirmation;
  final String otp;

  SubmitResetPassword({
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    required this.otp,
  });
}
