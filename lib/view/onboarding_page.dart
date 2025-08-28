import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

PageController onBoardingController = PageController();

class Onboarding_Page extends StatelessWidget {
  const Onboarding_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: onBoardingController,
        physics: const BouncingScrollPhysics(),
        children: const [
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  // width: 350,
                  height: 230,
                  child: Image.asset(
                    'assets/images/page3.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: Text(
                  'Start Doing Good'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Give the way you prefer:'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Recurring donation, Zakat, Sadaqah, or a gift.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Save your donations in the “Goodness Box”.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Track your impact with clear reports.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              OutlinedButton(
                onPressed: () {
                  onBoardingController.animateToPage(1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                },
                child: Text(
                  'Next'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  fixedSize: Size(200, 50),
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await SharedPrefs.setOnboardingSeen();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => sign_in_page()));
                },
                child: Text(
                  'Get Started'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    fixedSize: Size(200, 50),
                    foregroundColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SizedBox(
                  width: 350,
                  height: 230,
                  child: Image.asset(
                    'assets/images/page1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: Text(
                  'Give What You Can'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'You don’t need money to help!'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Donate items like clothes, furniture, toys..'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Every donation reaches those who need it most.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    // Text(
                    //   'Track your impact with clear and transparent reports.',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       color: AppColors.unselected,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              OutlinedButton(
                onPressed: () {
                  onBoardingController.animateToPage(2,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                },
                child: Text(
                  'Next'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  fixedSize: Size(200, 50),
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await SharedPrefs.setOnboardingSeen();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => sign_in_page()));
                },
                child: Text(
                  'Get Started'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    fixedSize: Size(200, 50),
                    foregroundColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 95),
                child: SizedBox(
                  // width: 370,
                  // height: 250,
                  child: Image.asset(
                    'assets/images/page2.png'.tr(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 70,
                width: 350,
                child: Text(
                  'Donate, Volunteer, or Get Support'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Apply to volunteer based on your time and skills.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Request support confidentially and securely.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      'Track your donations with full transparency.'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.unselected,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    // Text(
                    //   'Track your impact with clear and transparent reports.',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //       color: AppColors.unselected,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
              ),
              ElevatedButton(
                onPressed: () async {
                  await SharedPrefs.setOnboardingSeen();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => sign_in_page()));
                },
                child: Text(
                  'Get Started'.tr(),
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    fixedSize: Size(200, 50),
                    foregroundColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
