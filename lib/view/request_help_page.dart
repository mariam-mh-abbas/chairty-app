import 'package:charity_project/app_colors.dart';
import 'package:charity_project/service/HelpRequestService.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/model/HelpRequestModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LangHelper {
  // تحديد ما إذا كانت اللغة الحالية عربية
  static bool isArabic(BuildContext context) {
    try {
      return context.locale.languageCode == "ar";
    } catch (e) {
      print('LangHelper Error (locale access): $e');
      return false;
    }
  }

  // يتحقق إن النص مكتوب بالعربية فقط
  static bool isArabicText(String text) {
    return RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text);
  }

  // يتحقق إن النص مكتوب بالإنجليزية فقط
  static bool isEnglishText(String text) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
  }

  // يتحقق إن النص مكتوب بنفس لغة الواجهة الحالية
  static bool isTextMatchingCurrentLanguage(String text, BuildContext context) {
    return isArabic(context) ? isArabicText(text) : isEnglishText(text);
  }
}

class RequestHelpPage extends StatefulWidget {
  RequestHelpPage({super.key});

  @override
  State<RequestHelpPage> createState() => _RequestHelpPageState();
}

class _RequestHelpPageState extends State<RequestHelpPage> {
  final _formKey = GlobalKey<FormState>();
  bool? employmentStatus;
  String? livingStatus;
  String? maritalStatus;
  String? selectedStudy;
  String? selectedHelpType;
  bool? hasIncome;
  String? selectedGender;
  DateTime? selectedDate;
  String? gender;

  List<String> study = [
    "Primary School",
    "Preparatory School",
    "Secondary School",
    "University / Academic",
    "Not Studying"
  ];
  Helprequestservice helprequestservice = Helprequestservice();
  // Controllers for basic fields
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController fathername = TextEditingController();
  final TextEditingController mothername = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController numberoffamilymember = TextEditingController();
  final TextEditingController details = TextEditingController();

  // Dynamic fields controllers
  Map<String, TextEditingController> dynamicControllers = {};

  // Help type configurations with translations
  Map<String, Map<String, dynamic>> helpTypeConfig = {
    // Sponsorship - كفالات
    "Student": {
      "main_category": "Sponsorship",
      "main_category_ar": "كفالات",
      "display_name_ar": "طالب",
      "fields": [
        {
          "name": "Current academic level",
          "name_ar": "المستوى الأكاديمي الحالي",
          "type": "text",
          "required": true
        },
        {
          "name": "University name",
          "name_ar": "اسم الجامعة",
          "type": "text",
          "required": true
        },
        {
          "name": "Student grade",
          "name_ar": "درجة الطالب",
          "type": "text",
          "required": true
        },
        {
          "name": "Last certificate",
          "name_ar": "آخر شهادة",
          "type": "text",
          "required": true
        },
      ]
    },
    "Orphan": {
      "main_category": "Sponsorship",
      "main_category_ar": "كفالات",
      "display_name_ar": "يتيم",
      "fields": [
        {
          "name": "Father death date",
          "name_ar": "تاريخ وفاة الأب",
          "type": "date",
          "required": true
        },
        {
          "name": "Death reason",
          "name_ar": "سبب الوفاة",
          "type": "text",
          "required": true
        },
        {
          "name": "Current guardian",
          "name_ar": "الوصي الحالي",
          "type": "text",
          "required": true
        },
      ]
    },
    "Poor Families": {
      "main_category": "Sponsorship",
      "main_category_ar": "كفالات",
      "display_name_ar": "عائلات فقيرة",
      "fields": [
        {
          "name": "Does the family have a provider ?",
          "name_ar": "هل للعائلة معيل؟",
          "type": "text",
          "required": true
        },
        {
          "name": "Average monthly income of the family",
          "name_ar": "متوسط الدخل الشهري للعائلة",
          "type": "text",
          "required": true
        },
        {
          "name": "Number of children under 18",
          "name_ar": "عدد الأطفال تحت سن 18",
          "type": "text",
          "required": true
        },
      ]
    },

    // Humanitarian aid - مساعدات إنسانية
    "Health": {
      "main_category": "Humanitarian aid",
      "main_category_ar": "مساعدات إنسانية",
      "display_name_ar": "صحة",
      "fields": [
        {
          "name": "Disease type",
          "name_ar": "نوع المرض",
          "type": "text",
          "required": true
        },
        {
          "name": "Blood type",
          "name_ar": "فصيلة الدم",
          "type": "dropdown",
          "required": true,
          "options": ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
        },
        {
          "name": "Medical history",
          "name_ar": "التاريخ المرضي",
          "type": "text",
          "required": true
        },
        {
          "name": "Takes permanent medication",
          "name_ar": "يتناول أدوية دائمة",
          "type": "radio",
          "required": true,
          "options": ["Yes", "No"],
          "options_ar": ["نعم", "لا"]
        },
      ]
    },
    "Education": {
      "main_category": "Humanitarian aid",
      "main_category_ar": "مساعدات إنسانية",
      "display_name_ar": "تعليم",
      "fields": [
        {
          "name": "Current academic level",
          "name_ar": "المستوى الأكاديمي الحالي",
          "type": "text",
          "required": true
        },
        {
          "name": "School/University name",
          "name_ar": "اسم المدرسة/الجامعة",
          "type": "text",
          "required": true
        },
        {
          "name": "Student grade",
          "name_ar": "درجة الطالب",
          "type": "text",
          "required": true
        },
        {
          "name": "Last certificate",
          "name_ar": "آخر شهادة",
          "type": "text",
          "required": true
        },
      ]
    },
    "Construction": {
      "main_category": "Humanitarian aid",
      "main_category_ar": "مساعدات إنسانية",
      "display_name_ar": "بناء",
      "fields": [
        {
          "name": "Type of construction",
          "name_ar": "نوع البناء",
          "type": "dropdown",
          "required": true,
          "options": ["House", "Repair", "Roof"],
          "options_ar": ["منزل", "إصلاح", "سقف"]
        },
        {
          "name": "Required construction area (sqm)",
          "name_ar": "المساحة المطلوبة للبناء (متر مربع)",
          "type": "text",
          "required": true,
        },
        {
          "name": "Current Housing Condition",
          "name_ar": "حالة السكن الحالية",
          "type": "dropdown",
          "required": true,
          "options": ["Uninhabitable", "Crumbling"],
          "options_ar": ["غير صالح للسكن", "متهالك"]
        },
        {
          "name": "Number of residents in the house",
          "name_ar": "عدد سكان المنزل",
          "type": "text",
          "required": true,
        },
      ]
    },
    "Needy Families": {
      "main_category": "Humanitarian aid",
      "main_category_ar": "مساعدات إنسانية",
      "display_name_ar": "عائلات محتاجة",
      "fields": [
        {
          "name": "Housing Condition",
          "name_ar": "حالة السكن",
          "type": "text",
          "required": true
        },
        {
          "name": "What is the family's income source",
          "name_ar": "ما هو مصدر دخل العائلة",
          "type": "text",
          "required": true
        },
        {
          "name": "Do they live in a remote area",
          "name_ar": "هل يعيشون في منطقة نائية",
          "type": "radio",
          "required": true,
          "options": ["Yes", "No"],
          "options_ar": ["نعم", "لا"]
        },
      ]
    },

    // In Kind Donation - تبرعات عينية
    "childrenToys": {
      "main_category": "In Kind Donation",
      "main_category_ar": "تبرعات عينية",
      "display_name_ar": "ألعاب أطفال",
      "fields": [
        {
          "name": "Number of children",
          "name_ar": "عدد الأطفال",
          "type": "text",
          "required": true
        },
        {
          "name": "Children ages",
          "name_ar": "أعمار الأطفال",
          "type": "text",
          "required": true
        },
        {
          "name": "Preferred toy types",
          "name_ar": "أنواع الألعاب المفضلة",
          "type": "text",
          "required": true
        },
      ]
    },
    "furniture": {
      "main_category": "In Kind Donation",
      "main_category_ar": "تبرعات عينية",
      "display_name_ar": "أثاث",
      "fields": [
        {
          "name": "Furniture type needed",
          "name_ar": "نوع الأثاث المطلوب",
          "type": "dropdown",
          "required": true,
          "options": ["Bed", "Mattress", "Table", "Chairs", "Wardrobe"],
          "options_ar": ["سرير", "فراش", "طاولة", "كراسي", "خزانة"]
        },
        {
          "name": "Number of pieces",
          "name_ar": "عدد القطع",
          "type": "text",
          "required": true
        },
      ]
    },
    "clothes": {
      "main_category": "In Kind Donation",
      "main_category_ar": "تبرعات عينية",
      "display_name_ar": "ملابس",
      "fields": [
        {
          "name": "Number of individuals",
          "name_ar": "عدد الأفراد",
          "type": "text",
          "required": true
        },
        {
          "name": "Sizes or ages",
          "name_ar": "المقاسات أو الأعمار",
          "type": "text",
          "required": true
        },
        {
          "name": "Clothing season",
          "name_ar": "موسم الملابس",
          "type": "dropdown",
          "required": true,
          "options": ["Summer", "Winter", "Both"],
          "options_ar": ["صيف", "شتاء", "كلاهما"]
        },
      ]
    },
    "electronics": {
      "main_category": "In Kind Donation",
      "main_category_ar": "تبرعات عينية",
      "display_name_ar": "إلكترونيات",
      "fields": [
        {
          "name": "Device type",
          "name_ar": "نوع الجهاز",
          "type": "dropdown",
          "required": true,
          "options": [
            "Refrigerator",
            "Washing machine",
            "Heater",
            "TV",
            "Other"
          ],
          "options_ar": ["ثلاجة", "غسالة", "مدفأة", "تلفزيون", "أخرى"]
        },
        {
          "name": "Has working alternative",
          "name_ar": "يوجد بديل يعمل",
          "type": "radio",
          "required": true,
          "options": ["Yes", "No"],
          "options_ar": ["نعم", "لا"]
        },
        {
          "name": "Reason for needing device",
          "name_ar": "سبب الحاجة للجهاز",
          "type": "text",
          "required": true
        },
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    _initializeDynamicControllers();
  }

  void _initializeDynamicControllers() {
    helpTypeConfig.forEach((helpType, config) {
      List<Map<String, dynamic>> fields = config['fields'];
      for (var field in fields) {
        String key = "${helpType}_${field['name']}";
        dynamicControllers[key] = TextEditingController();
      }
    });
  }

  // Helper method to get localized field name
  String getLocalizedFieldName(Map<String, dynamic> field) {
    return LangHelper.isArabic(context)
        ? (field['name_ar'] ?? field['name'])
        : field['name'];
  }

  // Helper method to get localized options
  List<String> getLocalizedOptions(Map<String, dynamic> field) {
    if (field['options'] == null) return [];

    if (LangHelper.isArabic(context) && field['options_ar'] != null) {
      return List<String>.from(field['options_ar']);
    }
    return List<String>.from(field['options']);
  }

  // تم إزالة دالة getEnglishValue لأننا لا نريد تحويل للإنجليزي بعد الآن

  void pickBirthDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        birthDateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void pickDynamicDate(String fieldKey) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1925),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        dynamicControllers[fieldKey]!.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  HelpRequestModel prepareFormData() {
    bool isArabic = LangHelper.isArabic(context);
    List<Detail> detailsList = [];

    if (selectedHelpType != null &&
        helpTypeConfig.containsKey(selectedHelpType!)) {
      List<Map<String, dynamic>> fields =
          helpTypeConfig[selectedHelpType!]!['fields'];

      for (var field in fields) {
        String fieldKey = "${selectedHelpType}_${field['name']}";
        String fieldValue = dynamicControllers[fieldKey]?.text ?? '';

        if (fieldValue.isNotEmpty) {
          // إرسال اسم الحقل والقيمة حسب لغة الواجهة
          String fieldName =
              isArabic ? (field['name_ar'] ?? field['name']) : field['name'];

          detailsList.add(Detail(
            fieldName: fieldName,
            fieldValue: fieldValue, // إرسال القيمة كما هي (بلغة الواجهة)
          ));
        }
      }
    }

    // إرسال البيانات بلغة الواجهة بدلاً من التحويل للإنجليزي
    String currentGender = gender!;
    String currentMaritalStatus = maritalStatus!;
    String currentStudy = selectedStudy!;
    String currentLivingStatus = livingStatus!;
    String currentMainCategory = selectedHelpType != null
        ? (isArabic
            ? (helpTypeConfig[selectedHelpType!]!['main_category_ar'] ??
                helpTypeConfig[selectedHelpType!]!['main_category'])
            : helpTypeConfig[selectedHelpType!]!['main_category'])
        : '';
    String currentSubCategory = selectedHelpType != null
        ? (isArabic
            ? (helpTypeConfig[selectedHelpType!]!['display_name_ar'] ??
                selectedHelpType!)
            : selectedHelpType!)
        : '';

    return HelpRequestModel(
      name: "${firstname.text} ${lastname.text}",
      fatherName: fathername.text,
      motherName: mothername.text,
      gender: currentGender,
      birthDate: selectedDate!,
      maritalStatus: currentMaritalStatus,
      numOfMembers: int.tryParse(numberoffamilymember.text) ?? 0,
      study: currentStudy,
      hasJob: employmentStatus!,
      job: jobController.text.isNotEmpty ? jobController.text : null,
      housingType: currentLivingStatus,
      hasFixedIncome: hasIncome!,
      fixedIncome: hasIncome == true ? incomeController.text : null,
      address: address.text,
      phone: "0${phoneNumber.text}",
      mainCategory: currentMainCategory,
      subCategory: currentSubCategory,
      notes: details.text,
      details: detailsList,
    );
  }

  // تم إزالة دوال التحويل للإنجليزي لأننا لا نريد تحويل بعد الآن

  void submitForm() async {
    if (selectedStudy == null) {
      showError('Please select your study');
      return;
    }
    if (hasIncome == null) {
      showError('Please select if you have fixed income');
      return;
    }
    if (employmentStatus == null) {
      showError('Please select if you have a job');
      return;
    }
    if (gender == null) {
      showError("You must select your gender");
      return;
    }
    if (maritalStatus == null) {
      showError("You must select marital status");
      return;
    }
    if (livingStatus == null) {
      showError("You must select living status");
      return;
    }
    if (_formKey.currentState!.validate()) {
      try {
        HelpRequestModel helpRequest = prepareFormData();
        await helprequestservice.HelpRequestService(helpRequest);
        PaymentResultDialog.showSuccessHelpRequest(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed sending your help request').tr(),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget buildDynamicField(String helpType, Map<String, dynamic> field) {
    String fieldKey = "${helpType}_${field['name']}";
    TextEditingController controller = dynamicControllers[fieldKey]!;
    String localizedFieldName = getLocalizedFieldName(field);

    switch (field['type']) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizedFieldName, style: AppTextStyle.helpReq),
              SizedBox(height: 5),
              TextFormField(
                controller: controller,
                cursorColor: AppColors.primary,
                decoration: AppInputDecoration.defaultDecoration,
                validator: field['required']
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter'.tr() +
                              " " +
                              '$localizedFieldName'.tr();
                        }
                        return null;
                      }
                    : null,
              ),
            ],
          ),
        );

      case 'date':
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizedFieldName, style: AppTextStyle.helpReq),
              SizedBox(height: 5),
              TextFormField(
                controller: controller,
                readOnly: true,
                onTap: () => pickDynamicDate(fieldKey),
                cursorColor: AppColors.primary,
                decoration: AppInputDecoration.defaultDecoration.copyWith(
                  prefixIcon: Icon(Icons.date_range),
                ),
                validator: field['required']
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select'.tr() +
                              " " +
                              '$localizedFieldName'.tr();
                        }
                        return null;
                      }
                    : null,
              ),
            ],
          ),
        );

      case 'dropdown':
        List<String> localizedOptions = getLocalizedOptions(field);
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizedFieldName, style: AppTextStyle.helpReq),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                decoration: AppInputDecoration.defaultDecoration,
                value: controller.text.isEmpty ? null : controller.text,
                items: localizedOptions.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    controller.text = value ?? '';
                  });
                },
                validator: field['required']
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select'.tr() +
                              " " +
                              '$localizedFieldName'.tr();
                        }
                        return null;
                      }
                    : null,
              ),
            ],
          ),
        );

      case 'radio':
        List<String> localizedOptions = getLocalizedOptions(field);
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizedFieldName, style: AppTextStyle.helpReq),
              SizedBox(height: 5),
              Row(
                children: localizedOptions.map((option) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue:
                            controller.text.isEmpty ? null : controller.text,
                        onChanged: (value) {
                          setState(() {
                            controller.text = value ?? '';
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text(option),
                      SizedBox(width: 20),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }

  Widget buildDynamicFields() {
    if (selectedHelpType == null ||
        !helpTypeConfig.containsKey(selectedHelpType!)) {
      return Container();
    }

    List<Map<String, dynamic>> fields =
        helpTypeConfig[selectedHelpType!]!['fields'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          child: Text(
            'Additional Information'.tr(),
            style: AppTextStyle.helpReq.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        ...fields
            .map((field) => buildDynamicField(selectedHelpType!, field))
            .toList(),
      ],
    );
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg).tr(),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = LangHelper.isArabic(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Help Request'.tr(),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primary),
        ),
      ),
      body: BackgroundWrapper(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 20, right: 20),
                          child: Text('Full Name'.tr(),
                              style: AppTextStyle.helpReq),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  cursorColor: AppColors.primary,
                                  controller: firstname,
                                  decoration: AppInputDecoration
                                      .defaultDecoration
                                      .copyWith(label: Text("First Name".tr())),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter your first name'
                                          .tr();
                                    }
                                    if (!LangHelper
                                        .isTextMatchingCurrentLanguage(
                                            value, context)) {
                                      return LangHelper.isArabic(context)
                                          ? "من فضلك اكتب الاسم الأول باللغة العربية"
                                          : "Please enter your first name in English";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  cursorColor: AppColors.primary,
                                  controller: lastname,
                                  decoration: AppInputDecoration
                                      .defaultDecoration
                                      .copyWith(label: Text("Last Name".tr())),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please enter your last name'.tr();
                                    }
                                    if (!LangHelper
                                        .isTextMatchingCurrentLanguage(
                                            value, context)) {
                                      return LangHelper.isArabic(context)
                                          ? "من فضلك اكتب الاسم الآخر باللغة العربية"
                                          : "please enter your last name in English";
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Text('Mother Name'.tr(),
                                        style: AppTextStyle.helpReq),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      cursorColor: AppColors.primary,
                                      controller: mothername,
                                      decoration:
                                          AppInputDecoration.defaultDecoration,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your mother name'
                                              .tr();
                                        }
                                        if (!LangHelper
                                            .isTextMatchingCurrentLanguage(
                                                value, context)) {
                                          return LangHelper.isArabic(context)
                                              ? "من فضلك اكتب اسم الأم باللغة العربية"
                                              : "please enter your mother name in English";
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 20, right: 20),
                                    child: Text('Father Name'.tr(),
                                        style: AppTextStyle.helpReq),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      cursorColor: AppColors.primary,
                                      controller: fathername,
                                      decoration:
                                          AppInputDecoration.defaultDecoration,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter your father name'
                                              .tr();
                                        }
                                        if (!LangHelper
                                            .isTextMatchingCurrentLanguage(
                                                value, context)) {
                                          return LangHelper.isArabic(context)
                                              ? "من فضلك اكتب اسم الأب باللغة العربية"
                                              : "Please enter your father name in English";
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 20, right: 20),
                            child: Text('Gender :'.tr(),
                                style: AppTextStyle.helpReq),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              children: [
                                Radio(
                                    activeColor: AppColors.primary,
                                    value: isArabic ? "ذكر" : "Male",
                                    groupValue: gender,
                                    onChanged: (val) => setState(() {
                                          gender = val as String;
                                        })),
                                Text("Male".tr())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              children: [
                                Radio(
                                    activeColor: AppColors.primary,
                                    value: isArabic ? "أنثى" : "Female",
                                    groupValue: gender,
                                    onChanged: (val) => setState(() {
                                          gender = val as String;
                                        })),
                                Text("Female".tr())
                              ],
                            ),
                          ),
                        ]),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 20, right: 20),
                          child: Text('BirthDate'.tr(),
                              style: AppTextStyle.helpReq),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onTap: pickBirthDate,
                            cursorColor: AppColors.primary,
                            controller: birthDateController,
                            readOnly: true,
                            decoration: AppInputDecoration.defaultDecoration
                                .copyWith(
                                    prefixIcon: Icon(Icons.date_range),
                                    label: Text("BirthDate".tr())),
                            validator: (value) {
                              if (selectedDate == null) {
                                return 'please enter your Birthdate'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 6),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 5),
                              child: Text('Marital Status:'.tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                          activeColor: AppColors.primary,
                                          value: isArabic ? "أعزب" : "Single",
                                          groupValue: maritalStatus,
                                          onChanged: (val) => setState(() {
                                                maritalStatus = val as String;
                                              })),
                                      Text("Single".tr())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          activeColor: AppColors.primary,
                                          value: isArabic ? "متزوج" : "married",
                                          groupValue: maritalStatus,
                                          onChanged: (val) => setState(() {
                                                maritalStatus = val as String;
                                              })),
                                      Text("Married".tr())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          activeColor: AppColors.primary,
                                          value: isArabic ? "أرمل" : "widower",
                                          groupValue: maritalStatus,
                                          onChanged: (val) => setState(() {
                                                maritalStatus = val as String;
                                              })),
                                      Text("Widower".tr())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          activeColor: AppColors.primary,
                                          value: isArabic ? "مطلق" : "divorced",
                                          groupValue: maritalStatus,
                                          onChanged: (val) => setState(() {
                                                maritalStatus = val as String;
                                              })),
                                      Text("Divorced".tr())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: Text('Number of family members :'.tr(),
                              style: AppTextStyle.helpReq),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorColor: AppColors.primary,
                            controller: numberoffamilymember,
                            decoration: AppInputDecoration.defaultDecoration,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the number of family members'
                                    .tr();
                              }
                              final number = int.tryParse(value);
                              if (number == null) {
                                return 'Please enter a valid number'.tr();
                              }
                              if (number <= 0 || number >= 30) {
                                return 'Please enter a realistic number'.tr();
                              }
                              return null;
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: DropdownButtonFormField(
                              value: selectedStudy,
                              decoration: AppInputDecoration.defaultDecoration
                                  .copyWith(label: Text("Study".tr())),
                              items: study.map((studytype) {
                                String displayText = isArabic
                                    ? _getArabicStudy(studytype)
                                    : studytype;
                                return DropdownMenuItem(
                                    value: isArabic
                                        ? _getArabicStudy(studytype)
                                        : studytype,
                                    child: Text(displayText));
                              }).toList(),
                              onChanged: (value) => setState(() {
                                    selectedStudy = value;
                                  })),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 20, right: 20),
                                child: Text('Do You Have Job ?'.tr(),
                                    style: AppTextStyle.helpReq),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: true,
                                    groupValue: employmentStatus,
                                    onChanged: (val) => setState(() {
                                      employmentStatus = val!;
                                    }),
                                    activeColor: AppColors.primary,
                                  ),
                                  Text("Yes".tr())
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      activeColor: AppColors.primary,
                                      value: false,
                                      groupValue: employmentStatus,
                                      onChanged: (val) => setState(() {
                                            employmentStatus = val!;
                                          })),
                                  Text("No".tr())
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Text('Living : '.tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Row(
                              children: [
                                Radio(
                                    activeColor: AppColors.primary,
                                    value: isArabic ? "إيجار" : "Rent",
                                    groupValue: livingStatus,
                                    onChanged: (val) => setState(() {
                                          livingStatus = val as String;
                                        })),
                                Text("Rent".tr())
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    activeColor: AppColors.primary,
                                    value: isArabic ? "ملك" : "Own",
                                    groupValue: livingStatus,
                                    onChanged: (val) => setState(() {
                                          livingStatus = val as String;
                                        })),
                                Text("Own".tr())
                              ],
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              child: Text('Do you have fixed income ?'.tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: AppColors.primary,
                                        value: true,
                                        groupValue: hasIncome,
                                        onChanged: (val) => setState(() {
                                              hasIncome = val!;
                                            })),
                                    Text("Yes".tr())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: AppColors.primary,
                                        value: false,
                                        groupValue: hasIncome,
                                        onChanged: (val) => setState(() {
                                              hasIncome = val!;
                                            })),
                                    Text("No".tr())
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        if (hasIncome == true)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 20),
                            child: TextFormField(
                              controller: incomeController,
                              decoration:
                                  AppInputDecoration.defaultDecoration.copyWith(
                                labelText: "Monthly Income".tr(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter your monthly income'
                                      .tr();
                                }
                                return null;
                              },
                            ),
                          ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 5),
                              child: Text('Your Address'.tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: address,
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                decoration:
                                    AppInputDecoration.defaultDecoration,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter your address'.tr();
                                  }
                                  if (!LangHelper.isTextMatchingCurrentLanguage(
                                      value, context)) {
                                    return LangHelper.isArabic(context)
                                        ? "من فضلك اكتب العنوان باللغة العربية"
                                        : "please enter your address in English";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 20),
                              child: Text('Phone Number'.tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 4),
                              child: Text(
                                  'please make sure of the phone number\nwehere you will be connected'
                                      .tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: phoneNumber,
                                keyboardType: TextInputType.number,
                                decoration: AppInputDecoration.defaultDecoration
                                    .copyWith(
                                        label: Text("Your phone number".tr()),
                                        prefixIcon: Icon(Icons.phone),
                                        prefix: Text('+963')),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter your phone Number'
                                        .tr();
                                  } else if (value.length != 9) {
                                    return 'it must be 9 numbers'.tr();
                                  } else if (!RegExp(r'^\d{9}$')
                                      .hasMatch(value)) {
                                    return 'Only digits are allowed'.tr();
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: DropdownButtonFormField<String>(
                            decoration:
                                AppInputDecoration.defaultDecoration.copyWith(
                              label: Text("Select the type of help".tr()),
                            ),
                            value: selectedHelpType,
                            items: _buildHelpTypeItems(),
                            onChanged: (value) {
                              setState(() {
                                selectedHelpType = value;
                                // Clear previous dynamic field values when help type changes
                                dynamicControllers.forEach((key, controller) {
                                  if (key.startsWith('${selectedHelpType}_')) {
                                    controller.clear();
                                  }
                                });
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select help type'.tr()
                                : null,
                          ),
                        ),

                        // Dynamic fields based on selected help type
                        buildDynamicFields(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 5),
                              child: Text(
                                  'Write a simple explenaition about your ststus '
                                      .tr(),
                                  style: AppTextStyle.helpReq),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: details,
                                maxLines: 2,
                                decoration:
                                    AppInputDecoration.defaultDecoration,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please write a simple explenaition about your ststus'
                                        .tr();
                                  }

                                  if (!LangHelper.isTextMatchingCurrentLanguage(
                                      value, context)) {
                                    return LangHelper.isArabic(context)
                                        ? "من فضلك اكتب شرح حالتك باللغة العربية"
                                        : "please enter your status explenaition in English";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 250, right: 20, top: 20, bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            child: Text('Submit'.tr()),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                fixedSize: Size(100, 40),
                                foregroundColor: AppColors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getArabicStudy(String englishStudy) {
    switch (englishStudy) {
      case "Primary School":
        return "ابتدائي";
      case "Preparatory School":
        return "إعدادي";
      case "Secondary School":
        return "ثانوي";
      case "University / Academic":
        return "جامعي / أكاديمي";
      case "Not Studying":
        return "لا يدرس";
      default:
        return englishStudy;
    }
  }

  List<DropdownMenuItem<String>> _buildHelpTypeItems() {
    bool isArabic = LangHelper.isArabic(context);
    List<DropdownMenuItem<String>> items = [];

    // Group help types by main category
    Map<String, List<String>> categorizedTypes = {};
    helpTypeConfig.forEach((key, config) {
      String mainCategory = isArabic
          ? (config['main_category_ar'] ?? config['main_category'])
          : config['main_category'];

      if (!categorizedTypes.containsKey(mainCategory)) {
        categorizedTypes[mainCategory] = [];
      }
      categorizedTypes[mainCategory]!.add(key);
    });

    // Build dropdown items with categories
    categorizedTypes.forEach((category, helpTypes) {
      // Add category header
      items.add(DropdownMenuItem<String>(
        child: Text(
          '--- $category ---',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        enabled: false,
      ));

      // Add help types for this category
      for (String helpType in helpTypes) {
        String displayName = isArabic
            ? (helpTypeConfig[helpType]!['display_name_ar'] ?? helpType)
            : helpType;

        items.add(DropdownMenuItem(
          value: helpType,
          child: Text(displayName),
        ));
      }
    });

    return items;
  }
}


// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/service/HelpRequestService.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/charity_fund_page.dart';
// import 'package:charity_project/view/input_decoraition.dart';
// import 'package:charity_project/model/HelpRequestModel.dart';
// import 'package:easy_localization/easy_localization.dart';

// import 'package:flutter/material.dart';

// class RequestHelpPage extends StatefulWidget {
//   RequestHelpPage({super.key});

//   @override
//   State<RequestHelpPage> createState() => _RequestHelpPageState();
// }

// class _RequestHelpPageState extends State<RequestHelpPage> {
//   final _formKey = GlobalKey<FormState>();
//   bool? employmentStatus ;
//   String? livingStatus;
//   String? maritalStatus;
//   String? selectedStudy;
//   String? selectedHelpType;
//   bool? hasIncome ;
//   String? selectedGender;
//   DateTime? selectedDate;
//  String? gender;
//   List<String> study = ["Primary School",
//   "Preparatory School",
//   "Secondary School",
//   "University / Academic",
//   "Not Studying"];
 

//   // Controllers for basic fields
//   final TextEditingController firstname = TextEditingController();
//   final TextEditingController lastname = TextEditingController();
//   final TextEditingController fathername = TextEditingController();
//   final TextEditingController mothername = TextEditingController();
//   final TextEditingController address = TextEditingController();
//   final TextEditingController phoneNumber = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController jobController = TextEditingController();
//   final TextEditingController birthDateController = TextEditingController();
//   final TextEditingController numberoffamilymember = TextEditingController();
//   final TextEditingController details = TextEditingController();

//   // Dynamic fields controllers
//   Map<String, TextEditingController> dynamicControllers = {};

//   // Help type configurations
//    Map<String, Map<String, dynamic>> helpTypeConfig = {
//     // Sponsorship
    
//     "Student": {
//       "main_category": "Sponsorship",
//       "fields": [
//         {"name": "Current academic level", "type": "text", "required": true},
//         {"name": "University name", "type": "text", "required": true},
//         {"name": "Student grade", "type": "text", "required": true},
//         {"name": "Last certificate", "type": "text", "required": true},
//       ]
//     },
//     "Orphan": {
//       "main_category": "Sponsorship",
//       "fields": [
//         {"name": "Father death date", "type": "date", "required": true},
//         {"name": "Death reason", "type": "text", "required": true},
//         {"name": "Current guardian", "type": "text", "required": true},
//       ]
//     },
//     "Poor Families": {
//       "main_category": "Sponsorship",
//       "fields": [
//         {"name": "Does the family have a provider ?", "type": "text", "required": true},
//           {"name": "Average monthly income of the family", "type": "text", "required": true},
//         {"name": "Number of children under 18", "type": "text", "required": true},
//       ]
//     },

//     // Humanitarian aid
//     "Health": {
//       "main_category": "Humanitarian aid",
//       "fields": [
//         {"name": "Disease type", "type": "text", "required": true},
//         {"name": "Blood type", "type": "dropdown", "required": true, "options": ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]},
//         {"name": "Medical history", "type": "text", "required": true},
//         {"name": "Takes permanent medication", "type": "radio", "required": true, "options": ["Yes", "No"]},
//       ]
//     },
//     "Education": {
//       "main_category": "Humanitarian aid",
//       "fields": [
//         {"name": "Current academic level", "type": "text", "required": true},
//         {"name": "School/University name", "type": "text", "required": true},
//         {"name": "Student grade", "type": "text", "required": true},
//         {"name": "Last certificate", "type": "text", "required": true},
//       ]
//     },
//     "Construction": {
//       "main_category": "Humanitarian aid",
//       "fields": [
//         {"name": "Type of construction", "type": "dropdown", "required": true, "options": ["House", "Repair", "Roof"]},
//          {"name": "Required construction area (sqm)", "type": "text", "required": true, },
//           {"name": "Current Housing Condition", "type": "dropdown", "required": true, "options": ["Uninhabitable", "Crumbling"]},
//            {"name": "Number of residents in the house", "type": "text", "required": true, },
//       ]
//     },
//     "Needy Families": {
//       "main_category": "Humanitarian aid",
//       "fields": [
//         {"name": "Housing Condition", "type": "text", "required": true},
//         {"name": "What is the family’s income source", "type": "text", "required": true},
//         {"name": "Do they live in a remote area", "type": "radio", "required": true,"options": ["Yes", "No"]},
//       ]
//     },

//     // In Kind Donation
//     "childrenToys": {
//       "main_category": "In Kind Donation",
//       "fields": [
//         {"name": "Number of children", "type": "text", "required": true},
//         {"name": "Children ages", "type": "text", "required": true},
//         {"name": "Preferred toy types", "type": "text", "required": true},
//       ]
//     },
//     "furniture": {
//       "main_category": "In Kind Donation",
//       "fields": [
//         {"name": "Furniture type needed", "type": "dropdown", "required": true, "options": ["Bed", "Mattress", "Table", "Chairs", "Wardrobe"]},
//         {"name": "Number of pieces", "type": "text", "required": true},
//       ]
//     },
//     "clothes": {
//       "main_category": "In Kind Donation",
//       "fields": [
//         {"name": "Number of individuals", "type": "text", "required": true},
//         {"name": "Sizes or ages", "type": "text", "required": true},
//         {"name": "Clothing season", "type": "dropdown", "required": true, "options": ["Summer", "Winter", "Both"]},
//       ]
//     },
//     "electronics": {
//       "main_category": "In Kind Donation",
//       "fields": [
//         {"name": "Device type", "type": "dropdown", "required": true, "options": ["Refrigerator", "Washing machine", "Heater", "TV", "Other"]},
//         {"name": "Has working alternative", "type": "radio", "required": true, "options": ["Yes", "No"]},
//         {"name": "Reason for needing device", "type": "text", "required": true},
//       ]
//     },
//   };

//   @override
//   void initState() {
//     super.initState();
//     _initializeDynamicControllers();
//   }

//   void _initializeDynamicControllers() {
//     helpTypeConfig.forEach((helpType, config) {
//       List<Map<String, dynamic>> fields = config['fields'];
//       for (var field in fields) {
//         String key = "${helpType}_${field['name']}";
//         dynamicControllers[key] = TextEditingController();
//       }
//     });
//   }

//   void pickBirthDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//         birthDateController.text =  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//       });
//     }
//   }

//   void pickDynamicDate(String fieldKey) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1925),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         dynamicControllers[fieldKey]!.text =  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//       });
//     }
//   } 

//   HelpRequestModel prepareFormData() {
//     List<Detail> detailsList = [];
    
//     if (selectedHelpType != null && helpTypeConfig.containsKey(selectedHelpType!)) {
//       List<Map<String, dynamic>> fields = helpTypeConfig[selectedHelpType!]!['fields'];
      
//       for (var field in fields) {
//         String fieldKey = "${selectedHelpType}_${field['name']}";
//         String fieldValue = dynamicControllers[fieldKey]?.text ?? '';
        
//         if (fieldValue.isNotEmpty) {
//           detailsList.add(Detail(
//             fieldName: field['name'],
//             fieldValue: fieldValue,
//           ));
//         }
//       }
//     }

//     return HelpRequestModel(
//       name: "${firstname.text} ${lastname.text}",
//       fatherName: fathername.text,
//       motherName: mothername.text,
//       gender: gender!,
//       birthDate: selectedDate!,
//       maritalStatus: maritalStatus!,
//       numOfMembers: int.tryParse(numberoffamilymember.text) ?? 0,
//       study: selectedStudy!,
//       hasJob: employmentStatus!,
//       job: jobController.text.isNotEmpty  ? jobController.text : null ,
//       housingType: livingStatus!,
 
//       hasFixedIncome: hasIncome!,
//       fixedIncome: hasIncome == "yes" ? incomeController.text : null,
//       address: address.text,
//       phone:"0${phoneNumber.text}",
//       mainCategory: selectedHelpType != null ? helpTypeConfig[selectedHelpType!]!['main_category'] : '',
//       subCategory: selectedHelpType!,
//       notes: details.text,
//       details: detailsList,
//     );
//   }

//   void submitForm() async {
//     if ( selectedStudy == null) {
//       showError('Please select your study .');
//       return;
//     }
//     if (gender==null) {
//       showError("You must select your gender");
//     }
//     if (maritalStatus==null) {
//       showError("You must select maritial Status");
//     }
//     if (livingStatus==null) {
//       showError("You must select living Status");
//     }
//     if (_formKey.currentState!.validate()) {
//       try {
//         HelpRequestModel helpRequest = prepareFormData();
//         await HelpRequestService(helpRequest);
      


// showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           width: 500,
//           height: 400,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
            
//             children: [
              
//               SizedBox(height: 40,),
//               Image.asset("assets/images/notification.png",height: 100,),
//               SizedBox(height: 20,),
//               const Text(
//                 "Thank you!",
//                 textAlign: TextAlign.center,
//                 style: AppTextStyle.a
//               ),
//               const Text(
//                 "Your assistance request has been\nsubmitted successfully.You can track its status through the Notifications section.",
//                 textAlign: TextAlign.center,
//                 style: AppTextStyle.c
//               ),
//               SizedBox(height: 20,),
//               Column(
//                 children: [
//                   ElevatedButton(
//                      onPressed: () => Navigator.of(context).pop(),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       fixedSize: Size(300, 30),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
                        
//                       ),
//                     ),
//                     child: const Text("ok"),
//                   ),

                 


                  
//                 ],
//               ),
              




//             ],
//           ),
//         ),
//       ),
//     );
















//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error submitting request: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Widget buildDynamicField(String helpType, Map<String, dynamic> field) {
//     String fieldKey = "${helpType}_${field['name']}";
//     TextEditingController controller = dynamicControllers[fieldKey]!;

//     switch (field['type']) {
//       case 'text':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(field['name'], style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               TextFormField(
//                 controller: controller,
//                 cursorColor: AppColors.primary,
//                 decoration: AppInputDecoration.defaultDecoration,
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter ${field['name']}';
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'date':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(field['name'], style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               TextFormField(
//                 controller: controller,
//                 readOnly: true,
//                 onTap: () => pickDynamicDate(fieldKey),
//                 cursorColor: AppColors.primary,
//                 decoration: AppInputDecoration.defaultDecoration.copyWith(
//                   prefixIcon: Icon(Icons.date_range),
//                 ),
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select ${field['name']}';
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'dropdown':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(field['name'], style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               DropdownButtonFormField<String>(
//                 decoration: AppInputDecoration.defaultDecoration,
//                 value: controller.text.isEmpty ? null : controller.text,
//                 items: (field['options'] as List<String>).map((option) {
//                   return DropdownMenuItem(value: option, child: Text(option));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     controller.text = value ?? '';
//                   });
//                 },
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select ${field['name']}';
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'radio':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(field['name'], style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               Row(
//                 children: (field['options'] as List<String>).map((option) {
//                   return Row(
//                     children: [
//                       Radio<String>(
//                         value: option,
//                         groupValue: controller.text.isEmpty ? null : controller.text,
//                         onChanged: (value) {
//                           setState(() {
//                             controller.text = value ?? '';
//                           });
//                         },
//                         activeColor: AppColors.primary,
//                       ),
//                       Text(option),
//                       SizedBox(width: 20),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );

//       default:
//         return Container();
//     }
//   }

//   Widget buildDynamicFields() {
//     if (selectedHelpType == null || !helpTypeConfig.containsKey(selectedHelpType!)) {
//       return Container();
//     }

//     List<Map<String, dynamic>> fields = helpTypeConfig[selectedHelpType!]!['fields'];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
//           child: Text(
//             'Additional Information',
//             style: AppTextStyle.helpReq.copyWith(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//             ),
//           ),
//         ),
//         ...fields.map((field) => buildDynamicField(selectedHelpType!, field)).toList(),
//       ],
//     );
//   }
// void showError(String msg){
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.red,));
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: 
//        AppBar(
              
//       backgroundColor: AppColors.white,
//       title: Text('Help Request'.tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.primary),),
      
//         ),
//       body: BackgroundWrapper(
//         child: Column(
//           children: [
           
//         SizedBox(
//       height: 700,
//       child: ListView(
//         scrollDirection: Axis.vertical,
//         children: [
//           Form(
//         key: _formKey,
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//           child: Text('Full Name'.tr(),style: AppTextStyle.helpReq,),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
                  
//                   cursorColor: AppColors.primary,
                  
//                   controller: firstname,
//                   decoration: AppInputDecoration.defaultDecoration.copyWith(
//                 label: Text("First Name".tr())
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'please enter your first name'.tr();
//                     }
//                     return null;
//                   },
                
//                 ),
//               ),
      
      
//       SizedBox(width: 20,)
//               , Expanded(
//                  child: TextFormField(
                  
//                   cursorColor: AppColors.primary,
                  
//                   controller: lastname,
//                   decoration: AppInputDecoration.defaultDecoration.copyWith(
//                              label: Text("Last Name".tr())
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'please enter your last name'.tr();
//                     }
//                     return null;
//                   },
                             
//                              ),
//                ),
//             ],
//           ),
//         ),
//         SizedBox(height: 6),
      
      
      
      
//       Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//                     child: Text('Mother Name'.tr(),style: AppTextStyle.helpReq,),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Expanded(
//                       child: TextFormField(
//                         cursorColor: AppColors.primary,
//                         controller: mothername,
//                         decoration: AppInputDecoration.defaultDecoration.copyWith(
                                  
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'please enter your mother name'.tr();
//                           }
//                           return null;
//                         },
                      
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
      
//       SizedBox(width: 10,),
      
//       Expanded(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//                 padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//                 child: Text('Father Name'.tr(),style: AppTextStyle.helpReq,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Expanded(
//                   child: TextFormField(
//                     cursorColor: AppColors.primary,
//                     controller: fathername,
//                     decoration: AppInputDecoration.defaultDecoration.copyWith(
                      
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'please enter your father name'.tr();
//                       }
//                       return null;
//                     },
                  
//                   ),
//                 ),
//               ),
//       ],
//         ),
//       ),
      
//         ],
//       ),
                
//                 Row(
//                 children: [
//                     Padding(
//                 padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//                 child: Text('Gender :'.tr(),style: AppTextStyle.helpReq,),
//                           ),
//                           Padding(
//                 padding: const EdgeInsets.only(top:7),
//                 child: Row(
//                   children: [
//                     Radio(activeColor: AppColors.primary,
//                       value: "Male", groupValue: gender, onChanged: (val)=>setState(() {
//                       gender =val as String;
//                     })),
//                     Text("Male".tr())
//                   ],
//                 ),
//                           ),
                
//                 Padding(
//                   padding:const EdgeInsets.only(top:7),
//                   child: Row(
//                     children: [
//                       Radio(activeColor: AppColors.primary,
//                         value: "Female", groupValue: gender, onChanged: (val)=>setState(() {
//                         gender =val as String;
//                       })
//                       ),
//                       Text("Female".tr())
//                     ],
//                   ),
//                 ),]
//                 ),
                 
//        Padding(
//           padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//           child: Text('BirthDate'.tr(),style: AppTextStyle.helpReq,),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextFormField(
//             onTap: pickBirthDate,
//             cursorColor: AppColors.primary,
            
//             controller: birthDateController,
//             readOnly: true,
            
//             decoration: AppInputDecoration.defaultDecoration.copyWith(
//               prefixIcon: Icon(Icons.date_range),
//       label: Text("BirthDate".tr())
//             ),
//             validator: (value) {
//               if (selectedDate == null) {
//                 return 'please enter your Birthdate'.tr();
//               }
//               return null;
//             },
          
//           ),
//         ),
//         SizedBox(height: 6),
      
      
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//       Padding(
//               padding: const EdgeInsets.only(top:5,left: 20,right: 5),
//               child: Text('Marital Status:'.tr(),style: AppTextStyle.helpReq,),
//             ),
//             Padding(
//               padding:  const EdgeInsets.only(top:5,left: 20,right: 20),
//               child: Row(
//                 children: [
//                   Row(
//                     children: [
//                       Radio(activeColor: AppColors.primary,
//                         value: "Single", groupValue: maritalStatus, onChanged: (val)=>setState(() {
//                         maritalStatus =val as String;
//                       })),
//                       Text("Single".tr())
//                     ],
//                   ),
                  
//                   Row(
//                     children: [
//                       Radio(activeColor: AppColors.primary,
//                         value: "married", groupValue: maritalStatus, onChanged: (val)=>setState(() {
//                         maritalStatus =val as String;
//                       })
//                       ),
//                       Text("Married".tr())
//                     ],
//                   ),
                  
                  
//                   Row(
//                     children: [
//                       Radio(activeColor: AppColors.primary,
//                         value: "widower", groupValue: maritalStatus, onChanged: (val)=>setState(() {
//                         maritalStatus =val as String;
//                       })
//                       ),
//                       Text("Widower".tr())
//                     ],
//                   ),
//                    Row(
//                     children: [
//                       Radio(activeColor: AppColors.primary,
//                         value: "divorced", groupValue: maritalStatus, onChanged: (val)=>setState(() {
//                         maritalStatus =val as String;
//                       })
//                       ),
//                       Text("Divorced".tr())
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//       Padding(
//                 padding: const EdgeInsets.only(top:5,left: 10,right: 10),
//                 child: Text('Number of family members :'.tr(),style: AppTextStyle.helpReq,),
//               ),
//               Padding(
//                 padding:   const EdgeInsets.only(top:5,left: 10,right: 10),
//                 child: Expanded(
//                   child: TextFormField(
//                     cursorColor: AppColors.primary,
//                     controller: numberoffamilymember,
//                     decoration: AppInputDecoration.defaultDecoration.copyWith(
                      
//                     ),
//                      validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter the number of family members'.tr();
//                         }
//                         final number = int.tryParse(value);
//                         if (number == null) {
//                             return 'Please enter a valid number'.tr();
//                         }
//                         if (number <=0 || number >= 30) {
//                             return 'Please enter a realistic number'.tr();
//                         }
//                         return null;
//                       },
                  
//                   ),
//                 ),
//               ),
//         Padding(
//           padding:  const EdgeInsets.only(top:20,left: 10,right: 10),
//           child: DropdownButtonFormField(value: selectedStudy,
//                 decoration: AppInputDecoration.defaultDecoration.copyWith(
//           label: Text("Study".tr())
//                 ),
//           items:  study.map((studytype) {
//                       return DropdownMenuItem(value: studytype, child: Text(studytype).tr());
//                     }).toList(), onChanged: (value)=>setState(() {
//           selectedStudy = value;
//                 })),
//         ),
      
//       Padding(
//       padding:  const EdgeInsets.only(top:10,left: 10,right: 10),
//         child: Row(
//           children: [
//         Padding(
//                 padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//                 child: Text('Do You Have Job ?'.tr(),style: AppTextStyle.helpReq,),
//               ),
//               Row(
//                 children: [
//                   Radio(value: true, groupValue: employmentStatus, onChanged: (val)=>setState(() {
//                     employmentStatus =val!;
//                   }),activeColor: AppColors.primary,
        
//                   ),
//                   Text("Yes").tr()
//                 ],
//               ),
        
//         Row(
//           children: [
//         Radio(activeColor: AppColors.primary,
//           value: false, groupValue: employmentStatus, onChanged: (val)=>setState(() {
//           employmentStatus =val!;
//         })
//         ),
//         Text("No").tr()
//           ],
//         ),
//           ],
//         ),
//       ),
      
      
      
      
//       Row(
//         children: [
//       Padding(
//               padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//               child: Text('Living : '.tr(),style: AppTextStyle.helpReq,),
//             ),
//             Row(
//               children: [
//                 Radio(activeColor: AppColors.primary,
//                   value: "Rent", groupValue: livingStatus, onChanged: (val)=>setState(() {
//                   livingStatus =val as String;
//                 })),
//                 Text("Rent").tr()
//               ],
//             ),
      
//       Row(
//         children: [
//       Radio(activeColor: AppColors.primary,
//         value: "Own", groupValue: livingStatus, onChanged: (val)=>setState(() {
//         livingStatus =val as String;
//       })
//       ),
//       Text("Own").tr()
//         ],
//       ),
//         ],
//       ),
      
      
      
    
//       Row(
//         children: [
//       Padding(
//               padding: const EdgeInsets.only(top:5,left: 20,right: 20),
//               child: Text('Do you have fixed income ?'.tr(),style: AppTextStyle.helpReq,),
//             ),
//             Row(
//               children: [
//                 Radio(activeColor: AppColors.primary,
//                   value: true, groupValue: hasIncome, onChanged: (val)=>setState(() {
//                   hasIncome = val!;
//                 })),
//                 Text("Yes").tr()
//               ],
//             ),
      
//       Row(
//         children: [
//       Radio(activeColor: AppColors.primary,
//         value: false, groupValue: hasIncome, onChanged: (val)=>setState(() {
//         hasIncome = val!;
//       })
//       ),
//       Text("No").tr()
//         ],
//       ),
//         ],
//       ),
      
//       if (hasIncome == true)
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
//                   child: TextFormField(
//                     controller: incomeController,
//                     keyboardType: TextInputType.number,
//                     decoration: AppInputDecoration.defaultDecoration.copyWith(
//                       labelText: "Monthly Income".tr(),
                      
                      
//                     ),
//                   ),
//                 ),
      
//       Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                     Padding(
//                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 5),
//                child: Text('Your Address'.tr(),style: AppTextStyle.helpReq,),
//                          ),
//                    Padding(
//                      padding:  const EdgeInsets.only(left: 20,right: 20),
//                      child: TextFormField(
//                       controller: address,
//                       maxLines: 2,
//                      keyboardType: TextInputType.text,
//                        decoration: AppInputDecoration.defaultDecoration.copyWith(
                       
                         
//                        ),
//                        validator: (value) {
//                          if (value == null || value.isEmpty) {
//                            return 'please enter your address'.tr();
//                          }
//                        },
//                      ),
//                    ),
//                  ],
//                ),
          

//  Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                     Padding(
//                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 20),
//                child: Text('Phone Number'.tr(),style: AppTextStyle.helpReq,),
//                          ),
                         
//                          Padding(
//                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 4),
//                child: Text('please make sure of the phone number\nwehere you will be connected'.tr(),style: AppTextStyle.helpReq,),
//                          ), 
//                    Padding(
//                      padding:  const EdgeInsets.only(left: 20,right: 20),
//                      child: TextFormField(
                      
//                       controller: phoneNumber,
//                      keyboardType: TextInputType.number,
//                        decoration: AppInputDecoration.defaultDecoration.copyWith(
//                          label: Text("Your phone number").tr(),
//                         prefixIcon:
                          
//                             Icon(Icons.phone),
//                             prefix :Text('+963')
                          
                        
                      
                         
//                        ),
//                        validator: (value) {
//                          if (value == null || value.isEmpty) {
//                            return 'please enter your phone Number'.tr();
//                          }
//                          else if (value.length != 9){
//                           return 'it must be 9 numbers'.tr();
//                          }
//                          else if (!RegExp(r'^\d{9}$').hasMatch(value)){
//                           return 'Only digits are allowed'.tr();
//                          }
//                           return null;
//                        },
//                      ),
//                    ),
          
          
//                  ],
//                ),
// Padding(
//                           padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//                           child: DropdownButtonFormField<String>(
//                             decoration: AppInputDecoration.defaultDecoration.copyWith(
//                               label: Text("Select the type of help").tr(),
//                             ),
//                             value: selectedHelpType,
//                             items: [
//                               // Sponsorship section
//                               const DropdownMenuItem<String>(
//                                 child: Text(
//                                   '--- Sponsorship ---',
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
//                                 )
//                                 ,
//                                 enabled: false,
//                               ),
//                               const DropdownMenuItem(value: "Student", child: Text("Student")),
//                               const DropdownMenuItem(value: "Orphan", child: Text("Orphan")),
//                               const DropdownMenuItem(value: "Poor Families", child: Text("Poor Families")),

//                               // Humanitarian aid section
//                               const DropdownMenuItem<String>(
//                                 child: Text(
//                                   '--- Humanitarian aid ---',
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
//                                 ),
//                                 enabled: false,
//                               ),
//                               const DropdownMenuItem(value: "Education", child: Text("Education")),
//                               const DropdownMenuItem(value: "Health", child: Text("Health")),
//                               const DropdownMenuItem(value: "Needy Families", child: Text("Needy Families")),
//                               const DropdownMenuItem(value: "Construction", child: Text("Construction")),

//                               // In Kind Donation section
//                               const DropdownMenuItem<String>(
//                                 child: Text(
//                                   '--- In Kind Donation ---',
//                                   style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
//                                 ),
//                                 enabled: false,
//                               ),
//                               const DropdownMenuItem(value: "childrenToys", child: Text("Children Toys")),
//                               const DropdownMenuItem(value: "furniture", child: Text("Furniture")),
//                               const DropdownMenuItem(value: "electronics", child: Text("Electronics")),
//                               const DropdownMenuItem(value: "clothes", child: Text("Clothes")),
//                             ],
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedHelpType = value;
//                                 // Clear previous dynamic field values when help type changes
//                                 dynamicControllers.forEach((key, controller) {
//                                   if (key.startsWith('${selectedHelpType}_')) {
//                                     controller.clear();
//                                   }
//                                 });
//                               });
//                             },
//                             validator: (value) => value == null ? 'Please select help type'.tr() : null,
//                           ),
//                         ),

//                         // Dynamic fields based on selected help type
//                         buildDynamicFields(),

      
//       Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                     Padding(
//                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 5),
//                child: Text('Write a simple explenaition about your ststus '.tr(),style: AppTextStyle.helpReq,),
//                          ),
//                    Padding(
//                      padding:  const EdgeInsets.only(left: 20,right: 20),
//                      child: TextFormField(
//                       controller: details,
//                       maxLines: 2,
                     
//                        decoration: AppInputDecoration.defaultDecoration.copyWith(
                       
                         
//                        ),
//                        validator: (value) {
//                          if (value == null || value.isEmpty) {
//                            return 'please write a simple explenaition about your ststus'.tr();
//                          }
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//        Padding(
//                  padding:  EdgeInsets.only(left: 250,right: 20,top: 20),
//                  child: ElevatedButton(onPressed: (){
                  
//                   submitForm();
//                  }, child: Text('Submit').tr(),
//                  style: ElevatedButton.styleFrom(
//                    backgroundColor: AppColors.primary,
//                    fixedSize: Size(100, 40),
//                    foregroundColor: AppColors.white
//                  ),
//                  ),
//                )
//       ],
//         ),
//       )
//         ],
//       ),
//         )
//           ],
      
//         ),
//       ),
//     ) ;
//   }
// }






// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/service/HelpRequestService.dart';
// import 'package:charity_project/view/PaymentResultDialog.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/charity_fund_page.dart';
// import 'package:charity_project/view/input_decoraition.dart';
// import 'package:charity_project/model/HelpRequestModel.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// class LangHelper {
//   // تحديد ما إذا كانت اللغة الحالية عربية
//   static bool isArabic(BuildContext context) {
//     try {
//       return context.locale.languageCode == "ar";
//     } catch (e) {
//       print('LangHelper Error (locale access): $e');
//       return false;
//     }
//   }
  
//   // يتحقق إن النص مكتوب بالعربية فقط
//   static bool isArabicText(String text) {
//     return RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text);
//   }
  
//   // يتحقق إن النص مكتوب بالإنجليزية فقط
//   static bool isEnglishText(String text) {
//     return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text);
//   }
  
//   // يتحقق إن النص مكتوب بنفس لغة الواجهة الحالية
//   static bool isTextMatchingCurrentLanguage(String text, BuildContext context) {
//     return isArabic(context) ? isArabicText(text) : isEnglishText(text);
//   }
// }

// class RequestHelpPage extends StatefulWidget {
//   RequestHelpPage({super.key});

//   @override
//   State<RequestHelpPage> createState() => _RequestHelpPageState();
// }

// class _RequestHelpPageState extends State<RequestHelpPage> {
//   final _formKey = GlobalKey<FormState>();
//   bool? employmentStatus;
//   String? livingStatus;
//   String? maritalStatus;
//   String? selectedStudy;
//   String? selectedHelpType;
//   bool? hasIncome;
//   String? selectedGender;
//   DateTime? selectedDate;
//   String? gender;

//   List<String> study = [
//     "Primary School",
//     "Preparatory School",
//     "Secondary School",
//     "University / Academic",
//     "Not Studying"
//   ];
// Helprequestservice helprequestservice = Helprequestservice();
//   // Controllers for basic fields
//   final TextEditingController firstname = TextEditingController();
//   final TextEditingController lastname = TextEditingController();
//   final TextEditingController fathername = TextEditingController();
//   final TextEditingController mothername = TextEditingController();
//   final TextEditingController address = TextEditingController();
//   final TextEditingController phoneNumber = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController jobController = TextEditingController();
//   final TextEditingController birthDateController = TextEditingController();
//   final TextEditingController numberoffamilymember = TextEditingController();
//   final TextEditingController details = TextEditingController();

//   // Dynamic fields controllers
//   Map<String, TextEditingController> dynamicControllers = {};

//   // Help type configurations with translations
//   Map<String, Map<String, dynamic>> helpTypeConfig = {
//     // Sponsorship - كفالات
//     "Student": {
//       "main_category": "Sponsorship",
//       "main_category_ar": "كفالات",
//       "display_name_ar": "طالب",
//       "fields": [
//         {
//           "name": "Current academic level",
//           "name_ar": "المستوى الأكاديمي الحالي",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "University name",
//           "name_ar": "اسم الجامعة",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Student grade",
//           "name_ar": "درجة الطالب",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Last certificate",
//           "name_ar": "آخر شهادة",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//     "Orphan": {
//       "main_category": "Sponsorship",
//       "main_category_ar": "كفالات",
//       "display_name_ar": "يتيم",
//       "fields": [
//         {
//           "name": "Father death date",
//           "name_ar": "تاريخ وفاة الأب",
//           "type": "date",
//           "required": true
//         },
//         {
//           "name": "Death reason",
//           "name_ar": "سبب الوفاة",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Current guardian",
//           "name_ar": "الوصي الحالي",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//     "Poor Families": {
//       "main_category": "Sponsorship",
//       "main_category_ar": "كفالات",
//       "display_name_ar": "عائلات فقيرة",
//       "fields": [
//         {
//           "name": "Does the family have a provider ?",
//           "name_ar": "هل للعائلة معيل؟",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Average monthly income of the family",
//           "name_ar": "متوسط الدخل الشهري للعائلة",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Number of children under 18",
//           "name_ar": "عدد الأطفال تحت سن 18",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },

//     // Humanitarian aid - مساعدات إنسانية
//     "Health": {
//       "main_category": "Humanitarian aid",
//       "main_category_ar": "مساعدات إنسانية",
//       "display_name_ar": "صحة",
//       "fields": [
//         {
//           "name": "Disease type",
//           "name_ar": "نوع المرض",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Blood type",
//           "name_ar": "فصيلة الدم",
//           "type": "dropdown",
//           "required": true,
//           "options": ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
//         },
//         {
//           "name": "Medical history",
//           "name_ar": "التاريخ المرضي",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Takes permanent medication",
//           "name_ar": "يتناول أدوية دائمة",
//           "type": "radio",
//           "required": true,
//           "options": ["Yes", "No"],
//           "options_ar": ["نعم", "لا"]
//         },
//       ]
//     },
//     "Education": {
//       "main_category": "Humanitarian aid",
//       "main_category_ar": "مساعدات إنسانية",
//       "display_name_ar": "تعليم",
//       "fields": [
//         {
//           "name": "Current academic level",
//           "name_ar": "المستوى الأكاديمي الحالي",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "School/University name",
//           "name_ar": "اسم المدرسة/الجامعة",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Student grade",
//           "name_ar": "درجة الطالب",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Last certificate",
//           "name_ar": "آخر شهادة",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//     "Construction": {
//       "main_category": "Humanitarian aid",
//       "main_category_ar": "مساعدات إنسانية",
//       "display_name_ar": "بناء",
//       "fields": [
//         {
//           "name": "Type of construction",
//           "name_ar": "نوع البناء",
//           "type": "dropdown",
//           "required": true,
//           "options": ["House", "Repair", "Roof"],
//           "options_ar": ["منزل", "إصلاح", "سقف"]
//         },
//         {
//           "name": "Required construction area (sqm)",
//           "name_ar": "المساحة المطلوبة للبناء (متر مربع)",
//           "type": "text",
//           "required": true,
//         },
//         {
//           "name": "Current Housing Condition",
//           "name_ar": "حالة السكن الحالية",
//           "type": "dropdown",
//           "required": true,
//           "options": ["Uninhabitable", "Crumbling"],
//           "options_ar": ["غير صالح للسكن", "متهالك"]
//         },
//         {
//           "name": "Number of residents in the house",
//           "name_ar": "عدد سكان المنزل",
//           "type": "text",
//           "required": true,
//         },
//       ]
//     },
//     "Needy Families": {
//       "main_category": "Humanitarian aid",
//       "main_category_ar": "مساعدات إنسانية",
//       "display_name_ar": "عائلات محتاجة",
//       "fields": [
//         {
//           "name": "Housing Condition",
//           "name_ar": "حالة السكن",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "What is the family's income source",
//           "name_ar": "ما هو مصدر دخل العائلة",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Do they live in a remote area",
//           "name_ar": "هل يعيشون في منطقة نائية",
//           "type": "radio",
//           "required": true,
//           "options": ["Yes", "No"],
//           "options_ar": ["نعم", "لا"]
//         },
//       ]
//     },

//     // In Kind Donation - تبرعات عينية
//     "childrenToys": {
//       "main_category": "In Kind Donation",
//       "main_category_ar": "تبرعات عينية",
//       "display_name_ar": "ألعاب أطفال",
//       "fields": [
//         {
//           "name": "Number of children",
//           "name_ar": "عدد الأطفال",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Children ages",
//           "name_ar": "أعمار الأطفال",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Preferred toy types",
//           "name_ar": "أنواع الألعاب المفضلة",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//     "furniture": {
//       "main_category": "In Kind Donation",
//       "main_category_ar": "تبرعات عينية",
//       "display_name_ar": "أثاث",
//       "fields": [
//         {
//           "name": "Furniture type needed",
//           "name_ar": "نوع الأثاث المطلوب",
//           "type": "dropdown",
//           "required": true,
//           "options": ["Bed", "Mattress", "Table", "Chairs", "Wardrobe"],
//           "options_ar": ["سرير", "فراش", "طاولة", "كراسي", "خزانة"]
//         },
//         {
//           "name": "Number of pieces",
//           "name_ar": "عدد القطع",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//     "clothes": {
//       "main_category": "In Kind Donation",
//       "main_category_ar": "تبرعات عينية",
//       "display_name_ar": "ملابس",
//       "fields": [
//         {
//           "name": "Number of individuals",
//           "name_ar": "عدد الأفراد",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Sizes or ages",
//           "name_ar": "المقاسات أو الأعمار",
//           "type": "text",
//           "required": true
//         },
//         {
//           "name": "Clothing season",
//           "name_ar": "موسم الملابس",
//           "type": "dropdown",
//           "required": true,
//           "options": ["Summer", "Winter", "Both"],
//           "options_ar": ["صيف", "شتاء", "كلاهما"]
//         },
//       ]
//     },
//     "electronics": {
//       "main_category": "In Kind Donation",
//       "main_category_ar": "تبرعات عينية",
//       "display_name_ar": "إلكترونيات",
//       "fields": [
//         {
//           "name": "Device type",
//           "name_ar": "نوع الجهاز",
//           "type": "dropdown",
//           "required": true,
//           "options": ["Refrigerator", "Washing machine", "Heater", "TV", "Other"],
//           "options_ar": ["ثلاجة", "غسالة", "مدفأة", "تلفزيون", "أخرى"]
//         },
//         {
//           "name": "Has working alternative",
//           "name_ar": "يوجد بديل يعمل",
//           "type": "radio",
//           "required": true,
//           "options": ["Yes", "No"],
//           "options_ar": ["نعم", "لا"]
//         },
//         {
//           "name": "Reason for needing device",
//           "name_ar": "سبب الحاجة للجهاز",
//           "type": "text",
//           "required": true
//         },
//       ]
//     },
//   };

//   @override
//   void initState() {
//     super.initState();
//     _initializeDynamicControllers();
//   }

//   void _initializeDynamicControllers() {
//     helpTypeConfig.forEach((helpType, config) {
//       List<Map<String, dynamic>> fields = config['fields'];
//       for (var field in fields) {
//         String key = "${helpType}_${field['name']}";
//         dynamicControllers[key] = TextEditingController();
//       }
//     });
//   }

//   // Helper method to get localized field name
//   String getLocalizedFieldName(Map<String, dynamic> field) {
//     return LangHelper.isArabic(context) 
//         ? (field['name_ar'] ?? field['name'])
//         : field['name'];
//   }

//   // Helper method to get localized options
//   List<String> getLocalizedOptions(Map<String, dynamic> field) {
//     if (field['options'] == null) return [];
    
//     if (LangHelper.isArabic(context) && field['options_ar'] != null) {
//       return List<String>.from(field['options_ar']);
//     }
//     return List<String>.from(field['options']);
//   }

//   // Helper method to get English value for backend
//   String getEnglishValue(Map<String, dynamic> field, String displayValue) {
//     if (field['options'] == null || field['options_ar'] == null) {
//       return displayValue;
//     }
    
//     List<String> arabicOptions = List<String>.from(field['options_ar']);
//     List<String> englishOptions = List<String>.from(field['options']);
    
//     int index = arabicOptions.indexOf(displayValue);
//     if (index != -1 && index < englishOptions.length) {
//       return englishOptions[index];
//     }
    
//     return displayValue;
//   }

//   void pickBirthDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//         birthDateController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//       });
//     }
//   }

//   void pickDynamicDate(String fieldKey) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1925),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primary,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: AppColors.primary,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (pickedDate != null) {
//       setState(() {
//         dynamicControllers[fieldKey]!.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//       });
//     }
//   }

//   HelpRequestModel prepareFormData() {
//     List<Detail> detailsList = [];
    
//     if (selectedHelpType != null && helpTypeConfig.containsKey(selectedHelpType!)) {
//       List<Map<String, dynamic>> fields = helpTypeConfig[selectedHelpType!]!['fields'];
      
//       for (var field in fields) {
//         String fieldKey = "${selectedHelpType}_${field['name']}";
//         String fieldValue = dynamicControllers[fieldKey]?.text ?? '';
        
//         if (fieldValue.isNotEmpty) {
//           // Convert Arabic values to English for backend
//           String englishValue = getEnglishValue(field, fieldValue);
          
//           detailsList.add(Detail(
//             fieldName: field['name'], // Always send English field name to backend
//             fieldValue: englishValue, // Send English value to backend
//           ));
//         }
//       }
//     }

//     // Convert display values to English for backend
//     String englishGender = gender == "ذكر" ? "Male" : (gender == "أنثى" ? "Female" : gender!);
//     String englishMaritalStatus = _getEnglishMaritalStatus(maritalStatus!);
//     String englishStudy = _getEnglishStudy(selectedStudy!);
//     String englishLivingStatus = livingStatus == "إيجار" ? "Rent" : (livingStatus == "ملك" ? "Own" : livingStatus!);

//     return HelpRequestModel(
//       name: "${firstname.text} ${lastname.text}",
//       fatherName: fathername.text,
//       motherName: mothername.text,
//       gender: englishGender,
//       birthDate: selectedDate!,
//       maritalStatus: englishMaritalStatus,
//       numOfMembers: int.tryParse(numberoffamilymember.text) ?? 0,
//       study: englishStudy,
//       hasJob: employmentStatus!,
//       job: jobController.text.isNotEmpty ? jobController.text : null,
//       housingType: englishLivingStatus,
//       hasFixedIncome: hasIncome!,
//       fixedIncome: hasIncome == true ? incomeController.text : null,
//       address: address.text,
//       phone: "0${phoneNumber.text}",
//       mainCategory: selectedHelpType != null ? helpTypeConfig[selectedHelpType!]!['main_category'] : '',
//       subCategory: selectedHelpType!,
//       notes: details.text,
//       details: detailsList,
//     );
//   }

//   String _getEnglishMaritalStatus(String arabicStatus) {
//     switch (arabicStatus) {
//       case "أعزب":
//         return "Single";
//       case "متزوج":
//         return "married";
//       case "أرمل":
//         return "widower";
//       case "مطلق":
//         return "divorced";
//       default:
//         return arabicStatus;
//     }
//   }

//   String _getEnglishStudy(String arabicStudy) {
//     switch (arabicStudy) {
//       case "ابتدائي":
//         return "Primary School";
//       case "إعدادي":
//         return "Preparatory School";
//       case "ثانوي":
//         return "Secondary School";
//       case "جامعي / أكاديمي":
//         return "University / Academic";
//       case "لا يدرس":
//         return "Not Studying";
//       default:
//         return arabicStudy;
//     }
//   }

//   void submitForm() async {
//     if (selectedStudy == null) {
//       showError('Please select your study');
//       return;
//     }
//     if (hasIncome == null) {
//       showError('Please select if you have fixed income');
//       return;
//     }
//      if (employmentStatus == null) {
//       showError('Please select if you have a job');
//       return;
//     }
//     if (gender == null) {
//       showError("You must select your gender");
//       return;
//     }
//     if (maritalStatus == null) {
//       showError("You must select marital status");
//       return;
//     }
//     if (livingStatus == null) {
//       showError("You must select living status");
//       return;
//     }
//     if (_formKey.currentState!.validate()) {
//       try {
//         HelpRequestModel helpRequest = prepareFormData();
//         await helprequestservice.HelpRequestService(helpRequest);
//  PaymentResultDialog.showSuccessHelpRequest(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed sending your help request').tr(),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Widget buildDynamicField(String helpType, Map<String, dynamic> field) {
//     String fieldKey = "${helpType}_${field['name']}";
//     TextEditingController controller = dynamicControllers[fieldKey]!;
//     String localizedFieldName = getLocalizedFieldName(field);

//     switch (field['type']) {
//       case 'text':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(localizedFieldName, style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               TextFormField(
//                 controller: controller,
//                 cursorColor: AppColors.primary,
//                 decoration: AppInputDecoration.defaultDecoration,
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter'.tr()+" "+'$localizedFieldName'.tr();
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'date':
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(localizedFieldName, style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               TextFormField(
//                 controller: controller,
//                 readOnly: true,
//                 onTap: () => pickDynamicDate(fieldKey),
//                 cursorColor: AppColors.primary,
//                 decoration: AppInputDecoration.defaultDecoration.copyWith(
//                   prefixIcon: Icon(Icons.date_range),
//                 ),
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select'.tr()+" "+'$localizedFieldName'.tr();
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'dropdown':
//         List<String> localizedOptions = getLocalizedOptions(field);
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(localizedFieldName, style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               DropdownButtonFormField<String>(
//                 decoration: AppInputDecoration.defaultDecoration,
//                 value: controller.text.isEmpty ? null : controller.text,
//                 items: localizedOptions.map((option) {
//                   return DropdownMenuItem(value: option, child: Text(option));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     controller.text = value ?? '';
//                   });
//                 },
//                 validator: field['required'] ? (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please select'.tr()+" "+'$localizedFieldName'.tr();
//                   }
//                   return null;
//                 } : null,
//               ),
//             ],
//           ),
//         );

//       case 'radio':
//         List<String> localizedOptions = getLocalizedOptions(field);
//         return Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(localizedFieldName, style: AppTextStyle.helpReq),
//               SizedBox(height: 5),
//               Row(
//                 children: localizedOptions.map((option) {
//                   return Row(
//                     children: [
//                       Radio<String>(
//                         value: option,
//                         groupValue: controller.text.isEmpty ? null : controller.text,
//                         onChanged: (value) {
//                           setState(() {
//                             controller.text = value ?? '';
//                           });
//                         },
//                         activeColor: AppColors.primary,
//                       ),
//                       Text(option),
//                       SizedBox(width: 20),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );

//       default:
//         return Container();
//     }
//   }

//   Widget buildDynamicFields() {
//     if (selectedHelpType == null || !helpTypeConfig.containsKey(selectedHelpType!)) {
//       return Container();
//     }

//     List<Map<String, dynamic>> fields = helpTypeConfig[selectedHelpType!]!['fields'];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
//           child: Text(
//             'Additional Information'.tr(),
//             style: AppTextStyle.helpReq.copyWith(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primary,
//             ),
//           ),
//         ),
//         ...fields.map((field) => buildDynamicField(selectedHelpType!, field)).toList(),
//       ],
//     );
//   }

//   void showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(msg).tr(),
//       backgroundColor: Colors.red,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isArabic = LangHelper.isArabic(context);
    
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: Text(
//           'Help Request'.tr(),
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: AppColors.primary
//           ),
//         ),
//       ),
//       body: BackgroundWrapper(
//         child: Column(
//           children: [
//             Expanded(
              
//               child: ListView(
//                 scrollDirection: Axis.vertical,
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                           child: Text('Full Name'.tr(), style: AppTextStyle.helpReq),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextFormField(
//                                   cursorColor: AppColors.primary,
//                                   controller: firstname,
//                                   decoration: AppInputDecoration.defaultDecoration.copyWith(
//                                     label: Text("First Name".tr())
//                                   ),
//                                   validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'please enter your first name'.tr();
//                       }
//                     if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                       ? "من فضلك اكتب الاسم الأول باللغة العربية"
//                       : "Please enter your first name in English";
//                 }
                     
//                       return null;
//                     },
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               Expanded(
//                                 child: TextFormField(
//                                   cursorColor: AppColors.primary,
//                                   controller: lastname,
//                                   decoration: AppInputDecoration.defaultDecoration.copyWith(
//                                     label: Text("Last Name".tr())
//                                   ),
//                                  validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'please enter your last name'.tr();
//                       }
//                       if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                       ?"من فضلك اكتب الاسم الآخر باللغة العربية"
//                       : "please enter your last name in English";
//                 }
                      
//                       return null;
//                     },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 6),

//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                                     child: Text('Mother Name'.tr(), style: AppTextStyle.helpReq),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextFormField(
//                                       cursorColor: AppColors.primary,
//                                       controller: mothername,
//                                       decoration: AppInputDecoration.defaultDecoration,
//                                      validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'please enter your mother name'.tr();
//                       }
//                       if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                       ?"من فضلك اكتب اسم الأم باللغة العربية"
//                       : "please enter your mother name in English";
//                 }
                      
//                       return null;
//                     },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                                     child: Text('Father Name'.tr(), style: AppTextStyle.helpReq),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextFormField(
//                                       cursorColor: AppColors.primary,
//                                       controller: fathername,
//                                       decoration: AppInputDecoration.defaultDecoration,
//                                      validator: (value) {
//                       if (value == null || value.isEmpty) {
//                          return 'please enter your father name'.tr();
//                       }
//                     if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                       ? "من فضلك اكتب اسم الأب باللغة العربية"
//                       : "Please enter your father name in English";
//                 }
                     
//                       return null;
//                     },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                               child: Text('Gender :'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 7),
//                               child: Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: isArabic ? "ذكر" : "Male",
//                                     groupValue: gender,
//                                     onChanged: (val) => setState(() {
//                                       gender = val as String;
//                                     })
//                                   ),
//                                   Text("Male".tr())
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 7),
//                               child: Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: isArabic ? "أنثى" : "Female",
//                                     groupValue: gender,
//                                     onChanged: (val) => setState(() {
//                                       gender = val as String;
//                                     })
//                                   ),
//                                   Text("Female".tr())
//                                 ],
//                               ),
//                             ),
//                           ]
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                           child: Text('BirthDate'.tr(), style: AppTextStyle.helpReq),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             onTap: pickBirthDate,
//                             cursorColor: AppColors.primary,
//                             controller: birthDateController,
//                             readOnly: true,
//                             decoration: AppInputDecoration.defaultDecoration.copyWith(
//                               prefixIcon: Icon(Icons.date_range),
//                               label: Text("BirthDate".tr())
//                             ),
//                             validator: (value) {
//                               if (selectedDate == null) {
//                                 return 'please enter your Birthdate'.tr();
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 6),

//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5, left: 20, right: 5),
//                               child: Text('Marital Status:'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                               child: Row(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Radio(
//                                         activeColor: AppColors.primary,
//                                         value: isArabic ? "أعزب" : "Single",
//                                         groupValue: maritalStatus,
//                                         onChanged: (val) => setState(() {
//                                           maritalStatus = val as String;
//                                         })
//                                       ),
//                                       Text("Single".tr())
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Radio(
//                                         activeColor: AppColors.primary,
//                                         value: isArabic ? "متزوج" : "married",
//                                         groupValue: maritalStatus,
//                                         onChanged: (val) => setState(() {
//                                           maritalStatus = val as String;
//                                         })
//                                       ),
//                                       Text("Married".tr())
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Radio(
//                                         activeColor: AppColors.primary,
//                                         value: isArabic ? "أرمل" : "widower",
//                                         groupValue: maritalStatus,
//                                         onChanged: (val) => setState(() {
//                                           maritalStatus = val as String;
//                                         })
//                                       ),
//                                       Text("Widower".tr())
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Radio(
//                                         activeColor: AppColors.primary,
//                                         value: isArabic ? "مطلق" : "divorced",
//                                         groupValue: maritalStatus,
//                                         onChanged: (val) => setState(() {
//                                           maritalStatus = val as String;
//                                         })
//                                       ),
//                                       Text("Divorced".tr())
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: Text('Number of family members :'.tr(), style: AppTextStyle.helpReq),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             cursorColor: AppColors.primary,
//                             controller: numberoffamilymember,
//                             decoration: AppInputDecoration.defaultDecoration,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the number of family members'.tr();
//                               }
//                               final number = int.tryParse(value);
//                               if (number == null) {
//                                 return 'Please enter a valid number'.tr();
//                               }
//                               if (number <= 0 || number >= 30) {
//                                 return 'Please enter a realistic number'.tr();
//                               }
//                               return null;
//                             },
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//                           child: DropdownButtonFormField(
//                             value: selectedStudy,
//                             decoration: AppInputDecoration.defaultDecoration.copyWith(
//                               label: Text("Study".tr())
//                             ),
//                             items: study.map((studytype) {
//                               String displayText = isArabic ? _getArabicStudy(studytype) : studytype;
//                               return DropdownMenuItem(
//                                 value: isArabic ? _getArabicStudy(studytype) : studytype,
//                                 child: Text(displayText)
//                               );
//                             }).toList(),
//                             onChanged: (value) => setState(() {
//                               selectedStudy = value;
//                             })
//                           ),
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                                 child: Text('Do You Have Job ?'.tr(), style: AppTextStyle.helpReq),
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                     value: true,
//                                     groupValue: employmentStatus,
//                                     onChanged: (val) => setState(() {
//                                       employmentStatus = val!;
//                                     }),
//                                     activeColor: AppColors.primary,
//                                   ),
//                                   Text("Yes".tr())
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                     activeColor: AppColors.primary,
//                                     value: false,
//                                     groupValue: employmentStatus,
//                                     onChanged: (val) => setState(() {
//                                       employmentStatus = val!;
//                                     })
//                                   ),
//                                   Text("No".tr())
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                               child: Text('Living : '.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Row(
//                               children: [
//                                 Radio(
//                                   activeColor: AppColors.primary,
//                                   value: isArabic ? "إيجار" : "Rent",
//                                   groupValue: livingStatus,
//                                   onChanged: (val) => setState(() {
//                                     livingStatus = val as String;
//                                   })
//                                 ),
//                                 Text("Rent".tr())
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Radio(
//                                   activeColor: AppColors.primary,
//                                   value: isArabic ? "ملك" : "Own",
//                                   groupValue: livingStatus,
//                                   onChanged: (val) => setState(() {
//                                     livingStatus = val as String;
//                                   })
//                                 ),
//                                 Text("Own".tr())
//                               ],
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                               child: Text('Do you have fixed income ?'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Row(
//                               children: [
//                                 Radio(
//                                   activeColor: AppColors.primary,
//                                   value: true,
//                                   groupValue: hasIncome,
//                                   onChanged: (val) => setState(() {
//                                     hasIncome = val!;
//                                   })
//                                 ),
//                                 Text("Yes".tr())
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Radio(
//                                   activeColor: AppColors.primary,
//                                   value: false,
//                                   groupValue: hasIncome,
//                                   onChanged: (val) => setState(() {
//                                     hasIncome = val!;
//                                   })
//                                 ),
//                                 Text("No".tr())
//                               ],
//                             ),
//                           ],
//                         ),

//                         if (hasIncome == true)
//                           Padding(
//                             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
//                             child: TextFormField(
//                               controller: incomeController,
//                               // keyboardType: TextInputType.number,
//                               decoration: AppInputDecoration.defaultDecoration.copyWith(
//                                 labelText: "Monthly Income".tr(),
//                               ),
//                               validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'please enter your monthly income'.tr();
//                       }
                   
                      
//                       return null;
//                     },
//                             ),
//                           ),

//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
//                               child: Text('Your Address'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20),
//                               child: TextFormField(
//                                 controller: address,
//                                 maxLines: 2,
//                                 keyboardType: TextInputType.text,
//                                 decoration: AppInputDecoration.defaultDecoration,
//                                  validator: (value) {
//                            if (value == null || value.isEmpty) {
//                              return 'please enter your address'.tr();
//                            }

//                             if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                     ? "من فضلك اكتب العنوان باللغة العربية"
//                       : "please enter your address in English";
//                 }
                       
//                          },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
//                               child: Text('Phone Number'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 4),
//                               child: Text('please make sure of the phone number\nwehere you will be connected'.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20),
//                               child: TextFormField(
//                                 controller: phoneNumber,
//                                 keyboardType: TextInputType.number,
//                                 decoration: AppInputDecoration.defaultDecoration.copyWith(
//                                   label: Text("Your phone number".tr()),
//                                   prefixIcon: Icon(Icons.phone),
//                                   prefix: Text('+963')
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'please enter your phone Number'.tr();
//                                   } else if (value.length != 9) {
//                                     return 'it must be 9 numbers'.tr();
//                                   } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
//                                     return 'Only digits are allowed'.tr();
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Padding(
//                           padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
//                           child: DropdownButtonFormField<String>(
//                             decoration: AppInputDecoration.defaultDecoration.copyWith(
//                               label: Text("Select the type of help".tr()),
//                             ),
//                             value: selectedHelpType,
//                             items: _buildHelpTypeItems(),
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedHelpType = value;
//                                 // Clear previous dynamic field values when help type changes
//                                 dynamicControllers.forEach((key, controller) {
//                                   if (key.startsWith('${selectedHelpType}_')) {
//                                     controller.clear();
//                                   }
//                                 });
//                               });
//                             },
//                             validator: (value) => value == null ? 'Please select help type'.tr() : null,
//                           ),
//                         ),

//                         // Dynamic fields based on selected help type
//                         buildDynamicFields(),

//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
//                               child: Text('Write a simple explenaition about your ststus '.tr(), style: AppTextStyle.helpReq),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, right: 20),
//                               child: TextFormField(
//                                 controller: details,
//                                 maxLines: 2,
//                                 decoration: AppInputDecoration.defaultDecoration,
//                                  validator: (value) {
//                            if (value == null || value.isEmpty) {
//                             return 'please write a simple explenaition about your ststus'.tr();
//                            }

//                             if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
//                   return LangHelper.isArabic(context)
//                     ? "من فضلك اكتب شرح حالتك باللغة العربية"
//                       : "please enter your status explenaition in English";
//                 }
                       
//                          },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Padding(
//                           padding: EdgeInsets.only(left: 250, right: 20, top: 20,bottom: 10),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               submitForm();
//                             },
//                             child: Text('Submit'.tr()),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primary,
//                               fixedSize: Size(100, 40),
//                               foregroundColor: AppColors.white
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String _getArabicStudy(String englishStudy) {
//     switch (englishStudy) {
//       case "Primary School":
//         return "ابتدائي";
//       case "Preparatory School":
//         return "إعدادي";
//       case "Secondary School":
//         return "ثانوي";
//       case "University / Academic":
//         return "جامعي / أكاديمي";
//       case "Not Studying":
//         return "لا يدرس";
//       default:
//         return englishStudy;
//     }
//   }

//   List<DropdownMenuItem<String>> _buildHelpTypeItems() {
//     bool isArabic = LangHelper.isArabic(context);
//     List<DropdownMenuItem<String>> items = [];

//     // Group help types by main category
//     Map<String, List<String>> categorizedTypes = {};
//     helpTypeConfig.forEach((key, config) {
//       String mainCategory = isArabic 
//           ? (config['main_category_ar'] ?? config['main_category'])
//           : config['main_category'];
      
//       if (!categorizedTypes.containsKey(mainCategory)) {
//         categorizedTypes[mainCategory] = [];
//       }
//       categorizedTypes[mainCategory]!.add(key);
//     });

//     // Build dropdown items with categories
//     categorizedTypes.forEach((category, helpTypes) {
//       // Add category header
//       items.add(DropdownMenuItem<String>(
//         child: Text(
//           '--- $category ---',
//           style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
//         ),
//         enabled: false,
//       ));

//       // Add help types for this category
//       for (String helpType in helpTypes) {
//         String displayName = isArabic 
//             ? (helpTypeConfig[helpType]!['display_name_ar'] ?? helpType)
//             : helpType;
        
//         items.add(DropdownMenuItem(
//           value: helpType,
//           child: Text(displayName),
//         ));
//       }
//     });

//     return items;
//   }
// }