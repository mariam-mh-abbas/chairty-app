import 'package:charity_project/app_colors.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/change_language.dart';
import 'package:charity_project/view/change_password_page.dart';
import 'package:charity_project/view/change_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsExpandable extends StatefulWidget {
  const SettingsExpandable({super.key});

  @override
  State<SettingsExpandable> createState() => _SettingsExpandableState();
}

class _SettingsExpandableState extends State<SettingsExpandable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Settings'.tr(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: AppColors.unselected,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // title: Center(child: Text('رمز التحقق')),
                          content: change_language(),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'Language'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),

                // TextButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //           // title: Center(child: Text('رمز التحقق')),
                //           content: change_language(),
                //         );
                //       },
                //     );
                //   },
                //   child: Text(
                //     'Language',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => change_password_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'Password'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => change_password_page()));
                //   },
                //   child: Text(
                //     'Password',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //           // title: Center(child: Text('رمز التحقق')),
                //           content: change_theme(),
                //         );
                //       },
                //     );
                //   },
                //   child: SizedBox(
                //     height: 25,
                //     width: 270,
                //     child: Text(
                //       'Theme'.tr(),
                //       style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //           color: AppColors.black),
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return AlertDialog(
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(15),
                //           ),
                //           // title: Center(child: Text('رمز التحقق')),
                //           content: change_theme(),
                //         );
                //       },
                //     );
                //   },
                //   child: Text(
                //     'Theme',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // )
              ],
            ),
          ),
      ],
    );
  }
}
