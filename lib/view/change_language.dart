import 'dart:io';

import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_bloc.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_event.dart';
import 'package:charity_project/blocs/change_language_bloc/bloc/change_langauge_state.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class change_language extends StatefulWidget {
  const change_language({super.key});

  @override
  State<change_language> createState() => _change_languageState();
}

class _change_languageState extends State<change_language> {
  String? selectedCode;

  @override
  void initState() {
    super.initState();
    final state = context.read<LanguageBloc>().state;
    if (state is LanguageLoaded) {
      selectedCode = state.locale.languageCode;
    } else {
      selectedCode = 'en';
    }
  }

  Future<void> _changeLanguage(String code) async {
    if (selectedCode == code) return;

    context.read<LanguageBloc>().add(ChangeLanguage(code));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) async {
        if (state is LanguageFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to change language'.tr()),
              // backgroundColor: Colors.red,
            ),
          );
        } else if (state is LanguageLoaded) {
          Navigator.of(context).pop();
          final code = state.locale.languageCode;
          final locale = code == 'ar'
              ? const Locale('ar', 'AR')
              : const Locale('en', 'US');
          if (context.locale != locale) {
            await context.setLocale(locale);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Language changed successfully'.tr()),
                backgroundColor: AppColors.primary,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainNavbarPage()),
              (route) => false,
            );
          }
          // if (context.locale != locale) {
          //   WidgetsBinding.instance.addPostFrameCallback((_) async {
          //     await context.setLocale(locale);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //           content: Text('Language changed successfully'.tr()),
          //           backgroundColor: Colors.green),
          //     );
          //   });
          // }
        }
      },
      builder: (context, state) {
        bool isLoading = state is LanguageLoading;
        return Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(
            //   'Please select',
            //   style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.primary),
            // ),
            SizedBox(
              height: 15,
            ),
            Text(
              'change the application language to:'.tr(),
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary),
            ),
            SizedBox(
              height: 40,
            ),
            if (isLoading) const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          _changeLanguage('en');
                        },
                  child: Text('English'.tr()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      fixedSize: Size(110, 40),
                      foregroundColor: AppColors.white),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          _changeLanguage('ar');
                        },
                  child: Text('Arabic'.tr()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      fixedSize: Size(110, 40),
                      foregroundColor: AppColors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
