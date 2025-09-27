import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/Activity_Expanded.dart';
import 'package:charity_project/view/ArchivedTabbarPage.dart';
import 'package:charity_project/view/Settings_Expandable.dart';
import 'package:charity_project/view/about_us_page.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/contact_us_page.dart';
import 'package:charity_project/view/d.dart';
import 'package:charity_project/view/frequently_question_page.dart';
import 'package:charity_project/view/log_out.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/onboarding_page.dart';
import 'package:charity_project/view/profile_page.dart';
import 'package:charity_project/view/transparency_file_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainNavbarPage()),
                    (route) => false,
                  );
                },
                icon: Icon(Icons.arrow_back)),
            title: Text(
              'My List'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
            backgroundColor: AppColors.white,
            // elevation: 2,
            // shadowColor: AppColors.unselected,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 500,
                  child: Card(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User'.tr(),
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (context) =>
                                        ProfileBloc()..add(ShowProfileEvent()),
                                    child: profile_page(),
                                  ),
                                ),
                              );
                              // context
                              //     .read<ProfileBloc>()
                              //     .add(ShowProfileEvent());
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => profile_page()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Profile'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          SettingsExpandable(),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          ActivityExpandable(),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Association'.tr(),
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => About_us_page()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('About us'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Archivedtabbarpage()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.article_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Archived'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Frequently_questions_page()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.help_outline_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Frequently questions'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => contact_us_page()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Contact us'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Account Actions'.tr(),
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              )),
                          SizedBox(
                            height: 10,
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
                                    content: log_out(),
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Log out'.tr(),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
