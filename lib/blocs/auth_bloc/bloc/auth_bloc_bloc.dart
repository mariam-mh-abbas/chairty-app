// import 'dart:ui';

// import 'package:bloc/bloc.dart';
// import 'package:charity_project/services/auth_service.dart';
// import 'package:charity_project/config/shared_prefs.dart';
// import 'package:charity_project/view/set_language_page.dart';
// import 'package:meta/meta.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// part 'auth_bloc_event.dart';
// part 'auth_bloc_state.dart';

// class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
//   final AuthService authService;

//   AuthBloc(this.authService) : super(RegisterInitial()) {
//     on<RegisterUser>(_onRegisterUser);
//     on<LoginUser>(_onLoginUser);
//     on<LogoutUser>(_onLogoutUser);
//     on<LoginWithGoogle>(_onLoginWithGoogle);
//   }
//   Future<void> _onRegisterUser(
//       RegisterUser event, Emitter<AuthBlocState> emit) async {
//     emit(RegisterLoading());
//     try {
//       final response = await authService.registerUser(
//         name: event.name,
//         phone: event.phone,
//         password: event.password,
//         passwordConfirmation: event.confirmPassword,
//         otp: event.otp,
//         preferredLanguage: event.preferredLanguage,
//       );

//       await SharedPrefs.saveToken(response.accessToken);
//       await SharedPrefs.saveLanguageLocally(event.preferredLanguage);

//       // await SharedPrefs.saveLanguageLocally(event.preferredLanguage);

//       emit(RegisterSuccess());
//     } catch (e) {
//       emit(RegisterFailure(e.toString()));
//     }
//   }

//   Future<void> _onLoginUser(
//       LoginUser event, Emitter<AuthBlocState> emit) async {
//     emit(LoginLoading());
//     try {
//       final response = await authService.loginUser(
//         phone: event.phone,
//         password: event.password,
//       );

//       await SharedPrefs.saveToken(response.accessToken);

//       emit(LoginSuccess());
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }

//   Future<void> _onLogoutUser(
//       LogoutUser event, Emitter<AuthBlocState> emit) async {
//     emit(LogoutLoading());
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await SharedPrefs.clearToken();
//       // await SharedPrefs.clearOnboardingSeen();

//       emit(LogoutSuccess());
//     } catch (e) {
//       emit(LogoutFailure("Logout failed: ${e.toString()}"));
//     }
//   }

//   Future<void> _onLoginWithGoogle(
//       LoginWithGoogle event, Emitter<AuthBlocState> emit) async {
//     emit(GoogleLoading());
//     try {
//       final response = await authService.loginWithGoogle(
//         accessToken: event.accessToken,
//         preferredLanguage: event.preferredLanguage,
//       );

//       await SharedPrefs.saveToken(response.accessToken);

//       emit(GoogleSuccess());
//     } catch (e) {
//       emit(GoogleFailure("Google login failed: ${e.toString()}"));
//     }
//   }
// }
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(RegisterInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
    on<LoginWithGoogle>(_onLoginWithGoogle);
  }

  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<AuthBlocState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await authService.registerUser(
        name: event.name,
        phone: event.phone,
        password: event.password,
        passwordConfirmation: event.confirmPassword,
        otp: event.otp,
        preferredLanguage: event.preferredLanguage,
      );

      await SharedPrefs.saveToken(response.accessToken);
      await SharedPrefs.saveUserId(response.user.id);
      await SharedPrefs.saveLanguageLocally(event.preferredLanguage);

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> _onLoginUser(
      LoginUser event, Emitter<AuthBlocState> emit) async {
    emit(LoginLoading());
    try {
      final response = await authService.loginUser(
        phone: event.phone,
        password: event.password,
      );

      // تخزين التوكن و المعرف
      await SharedPrefs.saveToken(response.accessToken);
      await SharedPrefs.saveUserId(response.user.id);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogoutUser(
      LogoutUser event, Emitter<AuthBlocState> emit) async {
    emit(LogoutLoading());
    try {
      await SharedPrefs.clearToken(); // يمسح التوكن و اليوزر ID
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure("Logout failed: ${e.toString()}"));
    }
  }

  Future<void> _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<AuthBlocState> emit) async {
    emit(GoogleLoading());
    try {
      final response = await authService.loginWithGoogle(
        accessToken: event.accessToken,
        preferredLanguage: event.preferredLanguage,
      );

      // تخزين التوكن و المعرف
      await SharedPrefs.saveToken(response.accessToken);
      await SharedPrefs.saveUserId(response.user.id);

      emit(GoogleSuccess());
    } catch (e) {
      emit(GoogleFailure("Google login failed: ${e.toString()}"));
    }
  }
}
