
import 'dart:math';
import 'package:charity_project/helpers/app_language.dart';

import 'package:charity_project/model/VolunteerRequestModel.dart';
import 'package:charity_project/service/VolunteerRequestService.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/input_decoraition.dart';

 
class VolunteerRequestPage extends StatefulWidget {
  
   VolunteerRequestPage({super.key});
  

  @override
  State<VolunteerRequestPage> createState() => _VolunteerRequestPageState();
  
}

class _VolunteerRequestPageState extends State<VolunteerRequestPage> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController birthDate = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController job = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController details = TextEditingController();
  final TextEditingController experiencedetails = TextEditingController();
Volunteerrequestservice volunteerrequestservice = Volunteerrequestservice();
  String? selectedEducation;
  String? Time;
  DateTime? selectedDate;
  String? gender;
  bool hasPreviousExperience = false;
  bool FieldWork = false;
  bool Administrative = false;
  bool Awareness = false;
  bool Media = false;
  bool Design = false;
  bool Technical = false;
  bool Sunday = false;
  bool Monday = false;
  bool Tuesday = false;
  bool Wednesday = false;
  bool Thursday = false;
  bool Friday = false;
  bool Saturday = false;
  bool Agree = false;

  final List<String> study = [
    "School Student",
    "University Student",
    "Diploma",
    "Bachelor's Degree",
    "Master's Degree",
    "None"
  ];

  void pickedBirthDate() async {
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
        birthDate.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }
 
  bool isVolunteerTypeSelected() {
    return FieldWork || Administrative || Awareness || Media || Design || Technical;
  }

  bool isDaySelected() {
    return Sunday || Monday || Tuesday || Wednesday || Thursday || Friday || Saturday;
  }

  List<String> _getSelectedVolunteerTypes(bool isArabic) {
    List<String> types = [];
    if (FieldWork) types.add(isArabic ? "ميداني" : "FieldWork");
    if (Administrative) types.add(isArabic ? "إداري" :"Administrative");
    if (Awareness) types.add(isArabic ? "توعوي" :"Awareness");
    if (Media) types.add(isArabic ? "إعلامي" :"Media");
    if (Design) types.add(isArabic ? "تصميم" :"Design");
    if (Technical) types.add(isArabic ? "تقني":"Technical");
    return types;
  }

  List<String> _getSelectedDays(bool isArabic) {
    List<String> days = [];
    if (Sunday) days.add(isArabic ? "الأحد" :"Sunday");
    if (Monday) days.add(isArabic ? "الاثنين" :"Monday");
    if (Tuesday) days.add(isArabic ? "الثلاثاء" :"Tuesday");
    if (Wednesday) days.add(isArabic ? "الأربعاء" :"Wednesday");
    if (Thursday) days.add(isArabic ? "الخميس":"Thursday");
    if (Friday) days.add(isArabic ? "الجمعة":"Friday");
    if (Saturday) days.add(isArabic ? "السبت" :"Saturday");
    return days;
  }
String getLocalizedGender(bool isArabic) {
  switch (gender) {
    case "ذكر":
    case "Male":
      return isArabic ? "ذكر" : "Male";
    case "أنثى":
    case "Female":
      return isArabic ? "أنثى" : "Female";
    default:
      return gender ?? '';
  }
}
String getLocalizedTime(bool isArabic) {
  switch (Time) {
    case "صباحاً":
    case "Morning":
      return isArabic ? "صباحاً" : "Morning";
    case "مساءً":
    case "Evening":
      return isArabic ?"مساءً" : "Evening";
    case "طوال اليوم":
    case "All Day":
      return isArabic ? "طوال اليوم" : "All Day";
    default:
      return Time ?? '';
  }
}
 final formKey = GlobalKey<FormState>();
  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      return; 
    }
    if (!Agree) {
      showError('You must agree to the terms and conditions.');
      return;
    }
    if (gender == null) {
      showError('Please select your gender.');
      return;
    }
    if (!isVolunteerTypeSelected()) {
      showError('Please select at least one volunteering type.');
      return;
    }
    if (!isDaySelected()) {
      showError('Please select at least one available day.');
      return;
    }
    if (Time == null) {
      showError('Please select a preferred volunteering time.');
      return;
    }
    if (selectedEducation == null) {
      showError('Please select your study qualification.');
      return;
    }
    
String getSelectedStudy(bool isArabic) {
  switch (selectedEducation) {
    case "طالب مدرسة":
    case "School Student":
      return isArabic ? "طالب مدرسة" : "School Student";
    case "طالب جامعة":
    case "University Student":
      return isArabic ?"طالب جامعة" : "University Student";
    case "دبلوم":
    case "Diploma":
      return isArabic ? "دبلوم" : "Diploma";
      case "بكالوريوس":
    case "Bachelor's Degree":
      return isArabic ? "بكالوريوس" : "Bachelor's Degree";
      case "ماستر":
    case "Master's Degree":
      return isArabic ? "ماستر" : "Master's Degree";
      case "أخرى":
    case "None":
      return isArabic ? "أخرى" : "None";
    default:
      return selectedEducation ?? '';
  }
}
    final model = VolunteerRequestModel(
      fullName: "${firstname.text} ${lastname.text}",
      gender: getLocalizedGender(await LangHelper.isArabic(context)),
      birthDate: birthDate.text,
      address: address.text,
      studyQualification: getSelectedStudy(await LangHelper.isArabic(context)),
      job: job.text.isNotEmpty ? job.text : null,
      preferredTimes: getLocalizedTime(await LangHelper.isArabic(context)),
      hasPreviousVolunteer: hasPreviousExperience,
      previousVolunteer:
          hasPreviousExperience ? experiencedetails.text : null,
      phone: "0${phoneNumber.text}",
      notes: details.text.isNotEmpty ? details.text : null,
      days: _getSelectedDays(LangHelper.isArabic(context)),
      types: _getSelectedVolunteerTypes(await LangHelper.isArabic(context)),
    );

    try {
      await volunteerrequestservice.VolunteerRequestService(model);
      PaymentResultDialog.showSuccessVolunteerRequest(context);

    } catch (e) {
      showError("Failed sending your volunteer request");
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg).tr(), backgroundColor: Colors.red),
    );
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
                backgroundColor: AppColors.white,
                title: Text('Volunteer Request'.tr(),style: AppTextStyle.a,),
              ),
      body: BackgroundWrapper(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                         Padding(
                        padding: const EdgeInsets.only(top:5,left: 20,right: 20),
                        child: Text('Full Name'.tr(),style: AppTextStyle.helpReq,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                Expanded(
                  child: TextFormField(
                    
                    cursorColor: AppColors.primary,
                    
                    controller: firstname,
                    decoration: AppInputDecoration.defaultDecoration.copyWith(
                  label: Text("First Name".tr())
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your first name'.tr();
                      }
                    if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
                  return LangHelper.isArabic(context)
                      ? "من فضلك اكتب الاسم الأول باللغة العربية"
                      : "Please enter your first name in English";
                }
                     
                      return null;
                    },
                  
                  ),
                ),
                
                
                SizedBox(width: 20,)
                , Expanded(
                   child: TextFormField(
                    
                    cursorColor: AppColors.primary,
                    
                    controller: lastname,
                    decoration: AppInputDecoration.defaultDecoration.copyWith(
                               label: Text("Last Name".tr())
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your last name'.tr();
                      }
                      if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
                  return LangHelper.isArabic(context)
                      ?"من فضلك اكتب الاسم الآخر باللغة العربية"
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
                    Padding(
                padding: const EdgeInsets.only(top:5,left: 20,right: 20),
                child: Text('Gender :'.tr(),style: AppTextStyle.helpReq,),
                          ),
                          Padding(
                padding: const EdgeInsets.only(top:7),
                child: Row(
                  children: [
                    Radio(activeColor: AppColors.primary,
                      value: "Male", groupValue: gender, onChanged: (val)=>setState(() {
                      gender =val as String;
                    })),
                    Text("Male").tr()
                  ],
                ),
                          ),
                
                Padding(
                  padding:const EdgeInsets.only(top:7),
                  child: Row(
                    children: [
                      Radio(activeColor: AppColors.primary,
                        value: "Female", groupValue: gender, onChanged: (val)=>setState(() {
                        gender =val as String;
                      })
                      ),
                      Text("Female").tr()
                    ],
                  ),
                ),]
                ),
                
                
                Padding(
                  padding:  const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: TextFormField(
                    decoration: AppInputDecoration.defaultDecoration.copyWith(
                      prefixIcon: Icon(Icons.date_range),
                      
                    ),
                    controller: birthDate,
                    onTap: pickedBirthDate,
                    readOnly: true,
                    validator: (value) {
                      if (selectedDate == null) {
                        return 'please enter your Birthdate'.tr();
                      }
                      return null;
                    },
                    
                  ),
                ),
                
                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                 child: Text('Your Address'.tr(),style: AppTextStyle.helpReq,),
                           ),
                     Padding(
                       padding:  const EdgeInsets.only(left: 20,right: 20),
                       child: TextFormField(
                        controller: address,
                        maxLines: 2,
                       keyboardType: TextInputType.text,
                         decoration: AppInputDecoration.defaultDecoration.copyWith(
                         label: Text("Your Address".tr())
                           
                         ),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'please enter your address'.tr();
                           }

                            if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
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
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,),
                 child: Text('Volunteer Qualifications:'.tr(),style: AppTextStyle.helpReq,),
                           ),
                           SizedBox(height: 2,),
                            Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                 child: Text('Study Qualification:'.tr(),style: AppTextStyle.helpReq,),
                           ),
                           Padding(
                             padding:  const EdgeInsets.only(left: 20,right: 20),
                             child: DropdownButtonFormField(decoration: AppInputDecoration.defaultDecoration.copyWith(
                               label: Text("Study".tr())
                             ),
                              value: selectedEducation,items: study.map((studyType){
                             return DropdownMenuItem(child: Text(studyType).tr(),value: studyType,);
                             }).toList()
                             , onChanged: (value)=>setState(() {
                               selectedEducation = value;
                             })),
                           )
                     ,Padding(
                       padding:  const EdgeInsets.only(left: 20,right: 20,top: 20),
                       child: TextFormField(
                        controller: job,
                        
                       keyboardType: TextInputType.text,
                         decoration: AppInputDecoration.defaultDecoration.copyWith(
                         label: Text("Job (if you have):".tr())
                           
                         ),
                         validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return null;
                          }
                          
                             if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
                  return LangHelper.isArabic(context)
                         ?"من فضلك اكتب المهنة باللغة العربية"
                      : "please enter your job in English";
                }
                          
                       
                          return null;
                        
                      
                      
                         },
                       ),
                     ),
                   ],
                 ),
                
                
                
                
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                  child: Text('Preferred Volunteering Type:'.tr(),style: AppTextStyle.helpReq,),
                ),
                Row(
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: FieldWork, onChanged: (val){
                                setState(() {
                                  FieldWork = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Field Work".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Administrative, onChanged: (val){
                                setState(() {
                                  Administrative = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Administrative".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                                
                                
                                
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Awareness, onChanged: (val){
                                setState(() {
                                  Awareness = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Awareness".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                      ],
                    ),
                            
                            
                            
                            
                            
                    SizedBox(height: 5,),
                            
                            
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Media, onChanged: (val){
                                setState(() {
                                  Media = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Media".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                                
                                
                                
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Design, onChanged: (val){
                                setState(() {
                                  Design = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Design".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Technical, onChanged: (val){
                                setState(() {
                                  Technical = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Technical".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 18),
                 child: Text('Availability and Preferred Time:'.tr(),style: AppTextStyle.helpReq,),
                           ),
                           
      
      Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,),
                  child: Text('Preferred Days:'.tr(),style: AppTextStyle.helpReq,),
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Sunday, onChanged: (val){
                                setState(() {
                                  Sunday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Sunday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Monday, onChanged: (val){
                                setState(() {
                                  Monday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Monday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                                
                                
                                
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Tuesday, onChanged: (val){
                                setState(() {
                                  Tuesday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Tuesday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                                
                                
                                
                                
                                
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Wednesday, onChanged: (val){
                                setState(() {
                                  Wednesday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Wednesday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                      ],
                    ),
                            
                            
                            
                    SizedBox(height: 5,),
                            
                            
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Thursday, onChanged: (val){
                                setState(() {
                                  Thursday= val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Thursday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Friday, onChanged: (val){
                                setState(() {
                                  Friday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Friday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 5,),
                                
                                
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Saturday, onChanged: (val){
                                setState(() {
                                  Saturday = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("Saturday".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
      
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                    padding: const EdgeInsets.only(top:10,left: 20,right: 20),
                    child: Text('Preferred Time:'.tr(),style: AppTextStyle.helpReq,),
                              ),
                    Row(
                    children: [
                        
                              Padding(
                    padding: const EdgeInsets.only(top:7),
                    child: Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: Row(
                        children: [
                          Radio(activeColor: AppColors.primary,
                            value: "Morning", groupValue: Time, onChanged: (val)=>setState(() {
                            Time =val as String;
                          })),
                          Text("Morning").tr()
                        ],
                      ),
                    ),
                              ),
                    
                    Padding(
                      padding:const EdgeInsets.only(top:7),
                      child: Row(
                        children: [
                          Radio(activeColor: AppColors.primary,
                            value: "Evening", groupValue: Time, onChanged: (val)=>setState(() {
                            Time =val as String;
                          })
                          ),
                          Text("Evening").tr()
                        ],
                      ),
                    ),
                    
                       Padding(
                      padding:const EdgeInsets.only(top:7),
                      child: Row(
                        children: [
                          Radio(activeColor: AppColors.primary,
                            value: "All Day", groupValue: Time, onChanged: (val)=>setState(() {
                            Time =val as String;
                          })
                          ),
                          Text("All Day").tr()
                        ],
                      ),
                    ),
                    
                    ]
                    ),
          ],
        ),
           Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom:4,top: 18),
                 child: Text('Previous Volunteering Experience: '.tr(),style: AppTextStyle.helpReq,),
                           ),     
       Column(
         children: [
       Row(
                    children: [
                        Padding(
                    padding: const EdgeInsets.only(top:5,left: 20,right: 20),
                    child: Text('Have you ever volunteered?'.tr(),style: AppTextStyle.helpReq,),
                              ),
                              Padding(
                    padding: const EdgeInsets.only(top:7),
                    child: Row(
                      children: [
                        Radio(activeColor: AppColors.primary,
                          value: true, groupValue: hasPreviousExperience, onChanged: (val)=>setState(() {
                          hasPreviousExperience =val!;
                        })),
                        Text("Yes").tr()
                      ],
                    ),
                              ),
       
       
                    
                    Padding(
                      padding:const EdgeInsets.only(top:7),
                      child: Row(
                        children: [
                          Radio(activeColor: AppColors.primary,
                            value: false, groupValue: hasPreviousExperience, onChanged: (val)=>setState(() {
                            hasPreviousExperience =val! ;
                          })
                          ),
                          Text("No").tr()
                        ],
                      ),
                    ),
                    
                    
                    ]
                    ),
      
      if (hasPreviousExperience == true)
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                  child: TextFormField(
                    controller: experiencedetails,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    decoration: AppInputDecoration.defaultDecoration.copyWith(
                      labelText: "Please mention your experience or organizations:".tr(),
                  
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                         return "Please mention your experience or organizations".tr();
                      }
                       if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
                  return LangHelper.isArabic(context)
                    ?"من فضلك اكتب الخبرات والجهات باللغة العربية"
                      : "please enter experience or organizations in English";
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
               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 20),
               child: Text('Phone Number'.tr(),style: AppTextStyle.helpReq,),
                         ),
                         
                         Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 4),
               child: Text('please make sure of the phone number\nwehere you will be connected'.tr(),style: AppTextStyle.helpReq,),
                         ), 
                   Padding(
                     padding:  const EdgeInsets.only(left: 20,right: 20),
                     child: TextFormField(
                      
                      controller: phoneNumber,
                     keyboardType: TextInputType.number,
                       decoration: AppInputDecoration.defaultDecoration.copyWith(
                         label: Text("Your phone number").tr(),
                        prefixIcon:
                          
                            Icon(Icons.phone),
                            prefix :Text('+963').tr()
                          
                        
                      
                         
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'please enter your phone Number'.tr();
                         }
                         else if (value.length != 9){
                          return 'it must be 9 numbers'.tr();
                         }
                         else if (!RegExp(r'^\d{9}$').hasMatch(value)){
                          return 'Only digits are allowed'.tr();
                         }
                          return null;
                       },
                     ),
                   ),
          
          
                 ],
               ),
       Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Padding(
                 padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                 child: Text('Additional Notes or Details:'.tr(),style: AppTextStyle.helpReq,),
                           ),
                     Padding(
                       padding:  const EdgeInsets.only(left: 20,right: 20),
                       child: TextFormField(
                        controller: details,
                        maxLines: 2,
                       keyboardType: TextInputType.text,
                         decoration: AppInputDecoration.defaultDecoration.copyWith(
                         
                           
                         ),

                         validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return null;
                          }
                          
                             if (!LangHelper.isTextMatchingCurrentLanguage(value, context)) {
                  return LangHelper.isArabic(context)
                       ?"من فضلك اكتب الملاحظات أو التفاصيل الإضافية باللغة العربية"
                      : "please enter Additional Notes or Details in English";
                }
                          
                       
                          return null;
                        
                      
                      
                         },
                         
                        
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
      Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: [
                              Checkbox(activeColor: AppColors.primary,
                                value: Agree, onChanged: (val){
                                setState(() {
                                  Agree = val!;
                                });
                              }),
                              SizedBox(width: 10,),
                              Text("I agree to the terms and conditions of\nvolunteering at the association.".tr(),style: AppTextStyle.helpReq,)
                            ],
                          ),
                        ),
      
      
      Padding(
                 padding:  EdgeInsets.only(left: 230,right: 30,top: 20,bottom: 20),
                 child: ElevatedButton(onPressed: (){
                  
                  submitForm();
                 }, child: Text('Submit').tr(),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.primary,
                   fixedSize: Size(100, 40),
                   foregroundColor: AppColors.white
                 ),
                 ),
               )
      
      
                    ],
                  )
                  ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}