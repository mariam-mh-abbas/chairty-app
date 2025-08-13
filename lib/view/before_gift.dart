import 'package:charity_project/app_colors.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/gift_request.dart';
import 'package:charity_project/view/request_help_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BeforeGift extends StatelessWidget {
  const BeforeGift({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [AppBar(
          backgroundColor: AppColors.white,
        ),
          Image.asset('assets/images/mv.png',height: 340,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text('Why choose a traditional gift when you \ncan give something that lasts forever?'.tr(),style: AppTextStyle.a,textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                Center(
                  child: Text("Choose a gift that has a lasting impact and\nbring joy that extends beyond the moment to those you love.\nSend your gift now! Some gifts do not fade;\nthey endure in impact and reward.".tr(),
                  style:AppTextStyle.helpReq ,
                  textAlign: TextAlign.center,),
                ),
                      SizedBox(height: 60,),
              ],
            ),
          ),
      ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftRequest()));
      }, child: Text('Send a Gift').tr(),
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