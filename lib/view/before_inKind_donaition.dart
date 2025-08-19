import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/inKind_donaition_request.dart';
import 'package:charity_project/view/request_help_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BeforeInkindDonaition extends StatelessWidget {
  const BeforeInkindDonaition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
     appBar:  AppBar(
          backgroundColor: AppColors.white,
        ),
      body: BackgroundWrapper(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/a.png',height: 300,),
          SizedBox(height: 10,),
          Text('What you no longer use, could be\n someone else greatest wish'.tr(),textAlign: TextAlign.center,style: AppTextStyle.a,),
          SizedBox(height: 20,),
          Center(
            child: Text("things you no longer need could be a\ntreasure for someone in need.\ndonate clothes, shoes, toys, furniture,\nelectronics, jewelry, cars, and more .\n Request now, and donaite collector will be\n come to you shortly .".tr(),
            style:AppTextStyle.helpReq ,
            textAlign: TextAlign.center,),
          ),
      SizedBox(height: 60,),
      ElevatedButton(onPressed: ()async{
                                                              
  final token = await SharedPrefs.getToken() ?? '';
  if (token == null || token.isEmpty) {
    return PaymentResultDialog.Guest(context);
  } else {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> InkindDonaitionRequest()));
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