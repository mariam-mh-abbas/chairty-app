import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

@immutable
sealed class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final Locale locale;
  LanguageLoaded(this.locale);
}

class LanguageFailure extends LanguageState {
  final String message;
  LanguageFailure(this.message);
}
