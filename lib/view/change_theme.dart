import 'package:charity_project/app_colors.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class change_theme extends StatefulWidget {
  const change_theme({super.key});

  @override
  State<change_theme> createState() => _change_languageState();
}

class _change_languageState extends State<change_theme> {
  @override
  Widget build(BuildContext context) {
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
          'change the application theme to:'.tr(),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Dark'.tr()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  fixedSize: Size(100, 40),
                  foregroundColor: AppColors.white),
            ),
            SizedBox(
              width: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Light'.tr()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  fixedSize: Size(100, 40),
                  foregroundColor: AppColors.white),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
