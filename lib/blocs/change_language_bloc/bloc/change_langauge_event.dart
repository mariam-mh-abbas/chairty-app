import 'package:meta/meta.dart';

@immutable
sealed class LanguageEvent {}

class LoadLanguage extends LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String localeCode;
  ChangeLanguage(this.localeCode);
}
