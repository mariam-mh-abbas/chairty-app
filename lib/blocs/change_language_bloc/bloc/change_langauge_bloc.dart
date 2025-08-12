// change_language_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_event.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_state.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/services/change_language_service.dart';

import 'package:flutter/material.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageService languageService;

  LanguageBloc(this.languageService) : super(LanguageInitial()) {
    on<LoadLanguage>((event, emit) async {
      final saved = await SharedPrefs.getLanguage() ?? 'en';
      final locale = Locale(saved);
      emit(LanguageLoaded(locale));
    });

    on<ChangeLanguage>((event, emit) async {
      emit(LanguageLoading());
      final localeCode = event.localeCode;
      final locale = localeCode == 'ar'
          ? const Locale('ar', 'AR')
          : const Locale('en', 'US');
      await SharedPrefs.saveLanguageLocally(localeCode);
      emit(LanguageLoaded(locale));

      final token = await SharedPrefs.getToken();
      if (token != null) {
        try {
          await languageService.ChangeLanguage(localeCode);
        } catch (e) {
          emit(LanguageFailure('Sync failed: ${e.toString()}'));
        }
      }
    });
  }
}
