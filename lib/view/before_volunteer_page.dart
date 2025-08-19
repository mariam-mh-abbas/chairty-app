import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/inKind_donaition_request.dart';
import 'package:charity_project/view/request_help_page.dart';
import 'package:charity_project/view/volunteer_request_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BeforeVolunteerPage extends StatelessWidget {
  const BeforeVolunteerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.white
        ),
      body: BackgroundWrapper(
        
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/volunteer.png',height: 300,),
          SizedBox(height: 10,),
          Text('Your Time and Skills Can Change Lives'.tr(),textAlign: TextAlign.center,style: AppTextStyle.a,),
          SizedBox(height: 20,),
          Center(
            
            child: Text("There are people who need your help — your kindness, your time, your effort.\nJoin us as a volunteer and be part of a meaningful mission.\nWhether it's organizing events, helping with distribution, or simply offering a helping hand —\nevery act of kindness counts.\nApply now and help us make a lasting difference."
             .tr()
              ,
            style:AppTextStyle.helpReq ,
            textAlign: TextAlign.center,),
          ),
      SizedBox(height: 20,),
      ElevatedButton(onPressed: ()async{
        final token = await SharedPrefs.getToken() ?? '';
  if (token == null || token.isEmpty) {
    return PaymentResultDialog.VolunteerOrHelp(context,"We’re happy you’d like to volunteer with us!");
  } else {
   Navigator.push(context, MaterialPageRoute(builder: (context)=> VolunteerRequestPage()));
  }
        
      }, child: Text('New Request'.tr()),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        fixedSize: Size(200, 50),
        foregroundColor: AppColors.white
      ),
      )
      
          ]
        
      ),),
    );
   
  }
}