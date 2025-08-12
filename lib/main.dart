import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_bloc.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
import 'package:charity_project/blocs/recharge_bloc/bloc/recharge_bloc.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/services/change_language_service.dart';
import 'package:charity_project/services/donation_service.dart';
import 'package:charity_project/services/get_my_recharges_service.dart';
import 'package:charity_project/services/gift_service.dart';
import 'package:charity_project/services/request_service.dart';
import 'package:charity_project/services/sponsorships_service.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/onboarding_page.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  // final isLoggedIn;
  final Widget startPage;
  const MyApp({
    super.key,
    required this.startPage,
    // required this.isLoggedIn
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CharityApp',
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      home: startPage,
      //  isLoggedIn ? MainNavbarPage() : set_language_page(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedLang = await SharedPrefs.getLanguage() ?? 'en';
  final startLocale =
      savedLang == 'ar' ? const Locale('ar', 'AR') : const Locale('en', 'US');
  final token = await SharedPrefs.getToken();
  // final onboardingSeen = await SharedPrefs.getOnboardingSeen();

  Widget startPage;

  if (token != null) {
    startPage = const MainNavbarPage();
  }
  //  else if (!onboardingSeen) {
  //   startPage = const Onboarding_Page();
  // }
  else {
    startPage = const set_language_page();
  }

  runApp(EasyLocalization(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(AuthService()),
        ),
        BlocProvider(
          create: (context) => RequestBloc(RequestService())
            ..add(HelpRequestEvent())
            ..add(VolunteerRequestEvent()),
        ),
        BlocProvider(
          create: (context) => DonationBloc(DonationService()),
        ),
        BlocProvider(
          create: (context) => RechargeBloc(RechargeService()),
        ),
        BlocProvider(
          create: (_) => GiftBloc(GiftService()),
        ),
        BlocProvider(
          create: (_) => SponsorshipsBloc(SponsorshipsService()),
        ),
        BlocProvider(
          create: (_) => LanguageBloc(LanguageService()),
        ),
      ],
      child: MyApp(
        startPage: startPage,
        // isLoggedIn: token != null
      ),
    ),
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
    startLocale: startLocale,
    path: 'assets/translations',
  ));
}
