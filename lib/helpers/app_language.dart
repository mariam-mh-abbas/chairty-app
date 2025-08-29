import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LangHelper {
 
  static String currentLangCode = 'ar'; 

  static void updateLangCode(BuildContext context) {
    try {
      currentLangCode = context.locale.languageCode;
    } catch (e) {
      print('LangHelper Error (updateLangCode): $e');
    }
  }

  static bool isArabic(BuildContext context) {
    try {   
      return context.locale.languageCode == "ar";
    } catch (e) {
      print('LangHelper Error (locale access): $e');
      return false;
    }
  }

  static bool isArabicText(String text) {
    return RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text);
  }

  static bool isEnglishText(String text) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
  }

  static bool isTextMatchingCurrentLanguage(String text, BuildContext context) {
    return isArabic(context) ? isArabicText(text) : isEnglishText(text);
  }
    static String getTranslatedPeriod(String? period) {
    if (period == null) return "";
    final key = 'period.$period';
    return key.tr();
  }
}
