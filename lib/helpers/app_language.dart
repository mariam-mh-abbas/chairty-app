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

// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';

// class LangHelper {
//   static String currentLangCode = 'ar';

//   static void updateLangCode(BuildContext context) {
//     try {
//       currentLangCode = context.locale.languageCode;
//     } catch (e) {
//       print('LangHelper Error (updateLangCode): $e');
//     }
//   }

//   static bool isArabic(BuildContext context) {
//     try {
//       return context.locale.languageCode == "ar";
//     } catch (e) {
//       print('LangHelper Error (locale access): $e');
//       return false;
//     }
//   }

//   static bool isArabicText(String text) {
//     return RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text);
//   }

//   static bool isEnglishText(String text) {
//     return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
//   }

//   static bool isTextMatchingCurrentLanguage(String text, BuildContext context) {
//     return isArabic(context) ? isArabicText(text) : isEnglishText(text);
//   }

//   static String getTranslatedPeriod(String? period) {
//     if (period == null) return "";
//     final key = 'period.$period';
//     return key.tr();
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LangHelper {
//   static const String _langKey = 'app_language';

//   // Get current language code from SharedPreferences
//   static Future<String> getLanguageCode() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString(_langKey) ?? 'en'; // Default to English
//     } catch (e) {
//       print('LangHelper Error (getLanguageCode): $e');
//       return 'en';
//     }
//   }

//   // Save language code to SharedPreferences
//   static Future<void> saveLanguageCode(String code) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(_langKey, code);
//     } catch (e) {
//       print('LangHelper Error (saveLanguageCode): $e');
//     }
//   }

//   // Check if current language is Arabic
//   static bool isArabic(BuildContext context) {
//     try {
//       return context.locale.languageCode == "ar";
//     } catch (e) {
//       print('LangHelper Error (isArabic): $e');
//       return false;
//     }
//   }

//   // Check if text contains Arabic characters
//   static bool isArabicText(String text) {
//     return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
//   }

//   // Check if text contains only English characters
//   static bool isEnglishText(String text) {
//     return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
//   }

//   // Validate text matches current app language
//   static bool isTextMatchingCurrentLanguage(String text, BuildContext context) {
//     if (text.isEmpty) return true;

//     final bool isAr = isArabic(context);
//     final bool hasArabic = isArabicText(text);
//     final bool hasEnglish = isEnglishText(text);

//     // If app is in Arabic, text should contain Arabic characters
//     if (isAr && hasArabic && !hasEnglish) return true;

//     // If app is in English, text should contain only English characters
//     if (!isAr && hasEnglish && !hasArabic) return true;

//     // Mixed language text is not allowed
//     if (hasArabic && hasEnglish) return false;

//     // Text doesn't match expected language
//     return false;
//   }

//   // Get error message for language validation
//   static String getLanguageErrorMessage(BuildContext context) {
//     return isArabic(context)
//         ? "من فضلك اكتب النص باللغة العربية"
//         : "Please enter text in English";
//   }

//   // Get translated period
//   static String getTranslatedPeriod(String? period) {
//     if (period == null) return "";
//     final key = 'period.$period';
//     return key.tr();
//   }
// }
