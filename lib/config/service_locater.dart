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



