import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class About_us_page extends StatelessWidget {
  const About_us_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.unselected,
              title: Text(
                'About us'.tr(),
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 3,
                color: AppColors.white,
                margin: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                      child: Text(
                          "Our charity organization is a non-profit humanitarian entity dedicated to extending a helping hand to those in need by providing financial and in-kind assistance, as well as implementing developmental and relief projects. We focus on supporting orphans, low-income families, and people with special needs, in addition to contributing to vital sectors such as education, healthcare, food, and clean water. We are committed to promoting the values of solidarity and cooperation within the community,  ensuring that aid reaches its rightful beneficiaries with full transparency and safety. Through this application, we offer you multiple ways to donate and allow you to track the impact of your contributions through regular reports, while providing clear channels to contact us and participate in charitable initiatives. Our vision is to build a united community where everyone takes part in doing good, and our mission is to turn every donation into a new story of hope."
                              .tr(),
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )),
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }
}
