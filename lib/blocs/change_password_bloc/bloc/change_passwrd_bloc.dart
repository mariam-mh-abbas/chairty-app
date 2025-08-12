import 'package:bloc/bloc.dart';
import 'package:charity_project/services/change_password_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_passwrd_event.dart';
part 'change_passwrd_state.dart';

class ChangePasswrdBloc extends Bloc<ChangePasswrdEvent, ChangePasswrdState> {
  ChangePasswrdBloc() : super(ChangePasswrdInitial()) {
    on<SubmitChangePasswordEvent>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = await SharedPrefs.getToken() ?? '';

        final response = await changePassword(
          token: token,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
          newPasswordConfirmation: event.confirmPassword,
        );

        emit(ChangePasswordSuccess());
      } catch (e) {
        emit(ChangePasswordFailure(e.toString()));
      }
    });
  }
}
