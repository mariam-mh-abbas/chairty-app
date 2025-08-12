import 'package:charity_project/app_colors.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FaqItem {
  final String question;
  final String answer;
  FaqItem({required this.question, required this.answer});
}

class Frequently_questions_page extends StatefulWidget {
  const Frequently_questions_page({super.key});

  @override
  State<Frequently_questions_page> createState() =>
      _Frequently_questions_pageState();
}

class _Frequently_questions_pageState extends State<Frequently_questions_page> {
  final List<FaqItem> _faqItems = [
    FaqItem(
      question: "How can I create an account in the app?".tr(),
      answer:
          "You can create a new account by tapping 'Sign Up' on the home screen, entering your basic information (name, phone, email, password), and confirming via the verification message you receive."
              .tr(),
    ),
    FaqItem(
      question: "What donation methods are available?".tr(),
      answer:
          "The app supports one-time donations, recurring donations, Zakat, Sadaqah, in-kind donations, and gifting. You can complete payments using the available electronic methods."
              .tr(),
    ),
    FaqItem(
      question:
          "How can I be sure my donation reaches the right beneficiaries?".tr(),
      answer:
          "We commit to full transparency. Track your donation's impact via regular reports in the 'My Activity' section, and review documented receipts for every transaction."
              .tr(),
    ),
    FaqItem(
      question: "How do I apply for assistance?".tr(),
      answer:
          "Go to the 'Request Assistance' section, fill out the required form with accurate details, and submit. Your request will be reviewed by the administration, and you will be notified of the outcome."
              .tr(),
    ),
    FaqItem(
      question: "Can I volunteer with the organization?".tr(),
      answer:
          "Yes. Submit a volunteer application in the 'Volunteer' section, specifying your availability and preferred type of work."
              .tr(),
    ),
    FaqItem(
      question: "How do I change my settings (language/password)?".tr(),
      answer:
          "From your profile settings, you can switch language, and update your password either by entering the current one or using a verification code."
              .tr(),
    ),
    FaqItem(
      question: "How can I contact the organization?".tr(),
      answer:
          "Use the 'Contact Us' form, provide your name, phone number, and message. The administration will respond as soon as possible."
              .tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.unselected,
            title: Text(
              'Frequently questions'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _faqItems.length,
              itemBuilder: (context, index) {
                final item = _faqItems[index];
                return Card(
                  elevation: 3,
                  color: AppColors.white,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: AppColors.secondary,
                    ),
                    title: Text(
                      item.question,
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.answer,
                          style: TextStyle(
                              color: AppColors.unselected,
                              fontWeight: FontWeight.w600,
                              height: 1.4),
                        ),
                      ),
                    ],
                    trailing: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.unselected,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
