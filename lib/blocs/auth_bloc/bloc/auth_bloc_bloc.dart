import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:charity_project/models/auth_model.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/services/device_service.dart';
import 'package:charity_project/services/google_auth_sevice.dart';
import 'package:charity_project/services/notification_service.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthService authService;

  AuthBloc(this.authService, this.googleAuthService)
      : super(RegisterInitial()) {
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
      await SharedPrefs.saveLanguageLocally(event.preferredLanguage);
      await SharedPrefs.saveUserId(response.user.id);

      final fcm = await NotificationService().getFcmTokenSafe();
      print("📌 FCM Token: $fcm");
      if (fcm != null) {
        await DeviceService().registerDevice(
          fcmToken: fcm,
        );
      }

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

      await SharedPrefs.saveToken(response.accessToken);
      await SharedPrefs.saveUserId(response.user.id);

      final fcm = await NotificationService().getFcmTokenSafe();
      print("📌 FCM Token: $fcm");
      if (fcm != null) {
        await DeviceService().registerDevice(
          fcmToken: fcm,
        );
      }

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogoutUser(
      LogoutUser event, Emitter<AuthBlocState> emit) async {
    emit(LogoutLoading());
    try {
      final prefs = await SharedPreferences.getInstance();

      final fcm = await NotificationService().getFcmTokenSafe();
      print("📌 FCM Token: $fcm");
      if (fcm != null) {
        await DeviceService().deregisterDevice(
          fcmToken: fcm,
        );
      }
      await SharedPrefs.clearToken();
      //  //////
      // await SharedPrefs.clearOnboardingSeen();
      //  //////
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure("Logout failed: ${e.toString()}"));
    }
  }

  final GoogleAuthService googleAuthService;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<AuthBlocState> emit) async {
    emit(GoogleLoading());
    try {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(GoogleFailure("Google login failed"));
        return;
      }
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      if (accessToken == null) {
        emit(GoogleFailure("No Access Token"));
        return;
      }

      final response = await authService.loginWithGoogle(
          accessToken: accessToken, preferredLanguage: event.preferredLanguage);

      await SharedPrefs.saveToken(response.accessToken);
      await SharedPrefs.saveUserId(response.user.id);

      final fcm = await NotificationService().getFcmTokenSafe();
      print("📌 FCM Token: $fcm");
      if (fcm != null) {
        await DeviceService().registerDevice(
          fcmToken: fcm,
        );
      }

      emit(GoogleSuccess(response.user));
    } catch (e) {
      emit(GoogleFailure("Google login failed: ${e.toString()}"));
    }
  }
}
