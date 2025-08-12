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
import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/inKind_donaition_request.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/setLanguage.dart';
import 'package:charity_project/view/periodically_donaition.dart';
import 'package:charity_project/view/request_help_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await setup();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'AR'),
      child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
   
  Widget build(BuildContext context) {
   
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BlocCartBloc(),
        ),
        BlocProvider(
          create: (context) => GiftDonaitionBloc(),
        ),
        BlocProvider(
          create: (context) => OncePaymentBloc(),
        ),
        BlocProvider(
          create: (context) => SponsorshipDonaitionBloc(),
        ),
        BlocProvider(
          create: (context) => InKindDonaitionBloc(),
        ),
         BlocProvider(
          create: (context) => PeriodicallyDonaitionBloc(),
        ),
       BlocProvider(
          create: (context) => AllCampaignBloc(),
        ),
       BlocProvider(
          create: (context) => AllHumanCasesBloc(),
        ),
       
        BlocProvider(
          create: (context) => CampaignByCategoryIdBloc(),
        ),
       
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: context.locale.languageCode == 'en' ? 'ro' : 'tj'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
         
        locale: context.locale,
       
        debugShowCheckedModeBanner: false,
        home: set_language_page(),
      ),
    );
  }
}
