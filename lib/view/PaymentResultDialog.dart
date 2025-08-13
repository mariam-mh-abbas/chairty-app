import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentResultDialog {
 static void showSuccessDialog(BuildContext context){
  showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/paydone.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Thank you for your donation!",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("You just brought happiness to someone's heart.\nMay Allah reward you greatly.",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
           Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),          
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }


 static void showFailureDialog(BuildContext context){
    showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/payfailed.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Sorry !! You currently have no balance to donate",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("Don't worry — even good intentions are rewarded!",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
             Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }




  static void showSuccessInKindRequest(BuildContext context){
  showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/not.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Thank you for your generous gift!",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("We’ve received your in-kind donation request.\nYour contribution means a lot and will bring a smile to someone in need.\nWe’ll keep you updated via Notifications."

,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
                       Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }



 
  static void showSuccessVolunteerRequest(BuildContext context){
  showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/not.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Our hearts are with you!",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("Thank you for your willingness to give and participate.\nWe’ve received your volunteer request and will contact you once a suitable opportunity arises.\nKeep an eye on the Notifications section for updates."




,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
                                Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }




 
  static void showSuccessHelpRequest(BuildContext context){
  showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/not.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Your request is under review",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("Thank you for trusting us.\nWe’ve received your help request and will carefully review it and get back to you soon.\nYou can follow up through the Notifications section."




,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
          Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }


 


  static void showSuccessGiftRequest(BuildContext context){
  showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 500,
                      height: 400,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                       
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            "assets/images/not.png",
                            height: 150,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text("Thank you from the heart!",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.a).tr(),
                              const Text("Your gift has been received and will bring comfort to someone in need.\nYour kindness makes a real difference.\nMay you be abundantly rewarded."

,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.d).tr(),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () =>  
                       Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => MainNavbarPage()), 
  (route) => false,
),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  fixedSize: Size(200, 30),
                                  
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text("Go Back to Home Page").tr(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
 }

}