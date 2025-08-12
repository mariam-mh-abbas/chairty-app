import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/onboarding_page.dart';
import 'package:charity_project/view/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class set_language_page extends StatelessWidget {
  const set_language_page({super.key});

  void _selectLanguage(BuildContext context, String code, Locale locale) async {
    await SharedPrefs.saveLanguageLocally(code);
    await context.setLocale(locale);
    final onboardingSeen = await SharedPrefs.getOnboardingSeen();
    if (onboardingSeen == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => sign_in_page()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Onboarding_Page()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    'Please select the application language'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Text(
                //   'the application language',
                //   style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       color: AppColors.primary),
                // ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _selectLanguage(
                            context, 'en', const Locale('en', 'US'));
                      },
                      child: Text('English'.tr()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size(105, 40),
                          foregroundColor: AppColors.white),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _selectLanguage(
                            context, 'ar', const Locale('ar', 'AR'));
                      },
                      child: Text('Arabic'.tr()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size(105, 40),
                          foregroundColor: AppColors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
