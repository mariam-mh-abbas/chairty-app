import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt serviceLocater = GetIt.instance;

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();

  serviceLocater.registerLazySingleton<SharedPreferences>(() => prefs);
}

Future<void> SaveSelectedLanguage (String language)async{
  await serviceLocater<SharedPreferences>().setString("Language", language);
}

String GetSelectedLanguage() {
 return  serviceLocater<SharedPreferences>().getString("Language") ?? "en";
}



class SharedPrefs {
  static const _langKey = 'language';
  static const _tokenKey = 'access_token';
  static const _onboardingKey = 'onboarding_seen';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveLanguageLocally(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }

  static Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey);
  }

  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<bool> getOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<bool> clearOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_onboardingKey);
  }
}