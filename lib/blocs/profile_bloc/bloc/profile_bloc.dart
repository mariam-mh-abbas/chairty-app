import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:charity_project/models/profile_model.dart';
import 'package:charity_project/services/profile_service.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ShowProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await ShowProfile();
        if (profile == null) {
          emit(ShowProfileError("please sign in"));
          return;
        } else
          emit(ShowProfileLoaded(profile));
      } catch (e) {
        emit(ShowProfileError(e.toString()));
      }
    });
    on<UpdateProfileEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final token = await SharedPrefs.getToken() ?? '';

      try {
        final updatedProfile = await updateProfile(
          name: event.name,
          image: event.image,
          token: token,
        );

        emit(ProfileUpdateSuccess(updatedProfile));

        final profile = await ShowProfile();
        emit(ShowProfileLoaded(profile!));
      } catch (e) {
        emit(ProfileUpdateFailure(e.toString()));
      }
    });
  }
}
