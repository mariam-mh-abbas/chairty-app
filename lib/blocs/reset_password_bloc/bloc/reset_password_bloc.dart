import 'package:bloc/bloc.dart';
import 'package:charity_project/services/reset_password_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<SubmitResetPassword>((event, emit) async {
      try {
        final response = await resetPassword(
          phone: event.phone,
          password: event.password,
          passwordConfirmation: event.passwordConfirmation,
          otp: event.otp,
        );
        await SharedPrefs.saveToken(response.token);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(e.toString()));
      }
    });
  }
}
