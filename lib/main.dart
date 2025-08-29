// import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
// import 'package:charity_project/blocForApp/Gift/bloc/gift_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/InKindDonaition/bloc/in_kind_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
// import 'package:charity_project/blocForApp/PeriodicallyDonaition/bloc/periodically_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/SponsorshipDonaition/bloc/sponsorship_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
// import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
// import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
// import 'package:charity_project/config/service_locater.dart';
// import 'package:charity_project/view/charity_fund_page.dart';
// import 'package:charity_project/view/homa_page.dart';
// import 'package:charity_project/view/inKind_donaition_request.dart';
// import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
// import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_bloc.dart';
// import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
// import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
// import 'package:charity_project/blocs/recharge_bloc/bloc/recharge_bloc.dart';
// import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
// import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';
// import 'package:charity_project/config/shared_prefs.dart';
// import 'package:charity_project/services/auth_service.dart';
// import 'package:charity_project/services/change_language_service.dart';
// import 'package:charity_project/services/donation_service.dart';
// import 'package:charity_project/services/get_my_recharges_service.dart';
// import 'package:charity_project/services/gift_service.dart';
// import 'package:charity_project/services/request_service.dart';
// import 'package:charity_project/services/sponsorships_service.dart';
// import 'package:charity_project/view/main_navBar_page.dart';
// import 'package:charity_project/view/setLanguage.dart';
// import 'package:charity_project/view/periodically_donaition.dart';
// import 'package:charity_project/view/request_help_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:charity_project/view/onboarding_page.dart';
// import 'package:charity_project/view/set_language_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//  await setup();
//   await EasyLocalization.ensureInitialized();
//   runApp(EasyLocalization(
//       supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
//       path: 'assets/translations',
//       fallbackLocale: const Locale('ar', 'AR'),
//       child: const MyApp()));
// }



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

  
//   // final isLoggedIn;
//   final Widget startPage;
//   const MyApp({
//     super.key,
//     required this.startPage,
//     // required this.isLoggedIn
//   });

//   @override
   
//   Widget build(BuildContext context) {
   
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => BlocCartBloc(),
//         ),
//         BlocProvider(
//           create: (context) => GiftDonaitionBloc(),
//         ),
//         BlocProvider(
//           create: (context) => OncePaymentBloc(),
//         ),
//         BlocProvider(
//           create: (context) => SponsorshipDonaitionBloc(),
//         ),
//         BlocProvider(
//           create: (context) => InKindDonaitionBloc(),
//         ),
//          BlocProvider(
//           create: (context) => PeriodicallyDonaitionBloc(),
//         ),
//        BlocProvider(
//           create: (context) => AllCampaignBloc(),
//         ),
//        BlocProvider(
//           create: (context) => AllHumanCasesBloc(),
//         ),
       
//         BlocProvider(
//           create: (context) => CampaignByCategoryIdBloc(),
//         ),
       
//       ],
//       child: MaterialApp(
//         theme: ThemeData(
//             fontFamily: context.locale.languageCode == 'en' ? 'ro' : 'tj'),
//         localizationsDelegates: context.localizationDelegates,
//         supportedLocales: context.supportedLocales,
         
//         locale: context.locale,
       
//         debugShowCheckedModeBanner: false,
//         home: set_language_page(),
//       ),
//     return MaterialApp(
//       title: 'CharityApp',
//       locale: context.locale,
//       supportedLocales: context.supportedLocales,
//       localizationsDelegates: context.localizationDelegates,
//       debugShowCheckedModeBanner: false,
//       home: startPage,
//       //  isLoggedIn ? MainNavbarPage() : set_language_page(),
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   final savedLang = await SharedPrefs.getLanguage() ?? 'en';
//   final startLocale =
//       savedLang == 'ar' ? const Locale('ar', 'AR') : const Locale('en', 'US');
//   final token = await SharedPrefs.getToken();
//   // final onboardingSeen = await SharedPrefs.getOnboardingSeen();

//   Widget startPage;

//   if (token != null) {
//     startPage = const MainNavbarPage();
//   }
//   //  else if (!onboardingSeen) {
//   //   startPage = const Onboarding_Page();
//   // }
//   else {
//     startPage = const set_language_page();
//   }

//   runApp(EasyLocalization(
//     child: MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => AuthBloc(AuthService()),
//         ),
//         BlocProvider(
//           create: (context) => RequestBloc(RequestService())
//             ..add(HelpRequestEvent())
//             ..add(VolunteerRequestEvent()),
//         ),
//         BlocProvider(
//           create: (context) => DonationBloc(DonationService()),
//         ),
//         BlocProvider(
//           create: (context) => RechargeBloc(RechargeService()),
//         ),
//         BlocProvider(
//           create: (_) => GiftBloc(GiftService()),
//         ),
//         BlocProvider(
//           create: (_) => SponsorshipsBloc(SponsorshipsService()),
//         ),
//         BlocProvider(
//           create: (_) => LanguageBloc(LanguageService()),
//         ),
//       ],
//       child: MyApp(
//         startPage: startPage,
//         // isLoggedIn: token != null
//       ),
//     ),
//     supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
//     startLocale: startLocale,
//     path: 'assets/translations',
//   ));
// }



import 'package:charity_project/blocForApp/AllSponsorships/bloc/all_sponsorships_bloc_bloc.dart';
import 'package:charity_project/blocForApp/ArchivedCampaigns/bloc/archived_campaigns_bloc.dart';
import 'package:charity_project/blocForApp/ArchivedHumanCases/bloc/archived_humancases_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipsByCategory/bloc/sponsorships_by_category_bloc_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipsDetails/bloc/sponsorship_details_bloc.dart';
import 'package:charity_project/blocForApp/blocDetailsCampaign/bloc/bloc_details_campaign_bloc.dart';
import 'package:charity_project/blocForApp/blocEmergencyHumanCases/bloc/bloc_emergency_human_cases_bloc.dart';
import 'package:charity_project/blocForApp/blocHomeCampaign/bloc/campaign_home_bloc.dart';
import 'package:charity_project/blocForApp/blocHumanCaseByCategory/bloc/humancase_by_category_bloc.dart';
import 'package:charity_project/blocForApp/blocHumanCaseDetails/bloc/bloc_humancase_details_bloc.dart';
import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_bloc.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
import 'package:charity_project/blocs/recharge_bloc/bloc/recharge_bloc.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';

import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/Gift/bloc/gift_donaition_bloc.dart';
import 'package:charity_project/blocForApp/InKindDonaition/bloc/in_kind_donaition_bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/PeriodicallyDonaition/bloc/periodically_donaition_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipDonaition/bloc/sponsorship_donaition_bloc.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/service_locater.dart' as service_locator;
import 'package:charity_project/config/service_locater.dart';

import 'package:charity_project/config/shared_prefs.dart' as prefs;


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
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/inKind_donaition_request.dart';

import 'package:charity_project/view/periodically_donaition.dart';
import 'package:charity_project/view/request_help_page.dart';
import 'package:charity_project/view/splash_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup(); 
  await EasyLocalization.ensureInitialized();

  final savedLang = await prefs.SharedPrefs.getLanguage() ?? 'en';
  final startLocale =
      savedLang == 'ar' ? const Locale('ar', 'AR') : const Locale('en', 'US');

  final token = await prefs.SharedPrefs.getToken();

  Widget startPage;
   startPage = Splash_Screen();
  // if (token != null) {
  //   startPage = const MainNavbarPage();
  // } else {
  //   startPage =  set_language_page();
  // }

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
    startLocale: startLocale,
    path: 'assets/translations',
    fallbackLocale: const Locale('ar', 'AR'),
    child: MyApp(startPage: startPage),
  ));
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  const MyApp({super.key, required this.startPage});


@override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // من فرع main
        BlocProvider(create: (_) => AuthBloc(AuthService())),
        BlocProvider(
          create: (context) => RequestBloc(RequestService())
            ..add(HelpRequestEvent())
            ..add(VolunteerRequestEvent()),
        ),
        BlocProvider(create: (context) => DonationBloc(DonationService())),
        BlocProvider(create: (context) => RechargeBloc(RechargeService())),
        BlocProvider(create: (_) => GiftBloc(GiftService())),
        BlocProvider(create: (_) => SponsorshipsBloc(SponsorshipsService())),
        BlocProvider(create: (_) => LanguageBloc(LanguageService())),

        
        BlocProvider(create: (context) => BlocCartBloc()),
        BlocProvider(create: (context) => GiftDonaitionBloc()),
        BlocProvider(create: (context) => OncePaymentBloc()),
        BlocProvider(create: (context) => SponsorshipDonaitionBloc()),
        BlocProvider(create: (context) => InKindDonaitionBloc()),
        BlocProvider(create: (context) => PeriodicallyDonaitionBloc()),
        BlocProvider(create: (context) => AllCampaignBloc()),
        BlocProvider(create: (context) => AllHumanCasesBloc()),
         BlocProvider(create: (context) => AllSponsorshipsBlocBloc()),
          BlocProvider(create: (context) => SponsorshipsByCategoryBlocBloc()),
            BlocProvider(create: (context) => CampaignByCategoryIdBloc()),
                BlocProvider(create: (context) => HumancaseByCategoryBloc()),
        BlocProvider(create: (context) => CampaignByCategoryIdBloc()),
        BlocProvider(create: (context) => CampaignHomeBloc()),
        BlocProvider(create: (context) => BlocDetailsCampaignBloc()),
         BlocProvider(create: (context) => BlocHumancaseDetailsBloc()),
         BlocProvider(create: (context) => SponsorshipDetailsBloc()),
        BlocProvider(create: (context) => BlocEmergencyHumanCasesBloc()),
        BlocProvider(create: (context) => ArchivedCampaignsBloc()),
        BlocProvider(create: (context) => ArchivedHumancasesBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: context.locale.languageCode == 'en' ? 'ro' : 'tj',
        ),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        home: startPage
      ),
    );
  }
}