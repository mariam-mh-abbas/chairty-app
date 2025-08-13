import 'package:charity_project/app_colors.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/before_volunteer_page.dart';
import 'package:charity_project/view/periodically_donaition.dart';
import 'package:charity_project/view/sadakah_page.dart';
import 'package:charity_project/view/volunteer_request_page.dart';
import 'package:charity_project/view/zakah_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return 
  
        
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          
             Column(
               children: [
                 InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ZakahPage()));
                  },
                   child: Card(
                    
                    color: AppColors.secondary,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  
                    child: Container(height: 55,width: 55,
                      child: Image.asset('assets/images/zakat.png')),
                   ),
                 ),
                 Text('Zakat'.tr(),style: TextStyle(
                  color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
                 ),)
               ],
             ),
          
          
          
          
          
          
          
              Column(
               children: [
                 InkWell(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> BeforeVolunteerPage()));
                  },
                   child: Card(
                    
                    color: AppColors.secondary,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  
                    child: Container(height: 55,width: 55,
                      child: Image.asset('assets/images/6.png')),
                   ),
                 ),
                 Text('volounter'.tr(),style: TextStyle(
                  color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
                 ),)
               ],
             ),
          
          
              Column(
               children: [
                 InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PeriodicallyDonaition()));
                  },
                   child: Card(
                    
                    color: AppColors.secondary,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  
                    child: Container(height: 55,width: 55,
                      child: Image.asset('assets/images/7.png')),
                   ),
                 ),
                 Text(textAlign: TextAlign.center,
                  'periodecially\ndonaition'.tr(),style: TextStyle(
                  color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
                 ),)
               ],
             ),
          
          
          
          
          
           Column(
               children: [
                 InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SadakahPage()));
                  },
                   child: Card(
                    
                    color: AppColors.secondary,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  
                    child: Container(height: 55,width: 55,
                      child: Image.asset('assets/images/0.png',color: AppColors.white,)),
                   ),
                 ),
                 Text('sadakah'.tr(),style: TextStyle(
                  color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
                 ),)
               ],
             ),
          
              
            ],
          );
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     Column(
    //                children: [
    //                  InkWell(
    //                   onTap: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>PeriodicallyDonaition()));
    //                   },
    //                    child: Container(
    //                     height: 55,width: 55,
    //                     decoration: BoxDecoration(
    //                       color: Colors.transparent,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         width: 2,
    //                         color: AppColors.primary
    //                       )
    //                     ),
                            
    //                           child: Image.asset('assets/images/7.png',color: AppColors.secondary,),
                        
    //                    ),
    //                  ),
    //                  Text('periodecially\ndonaition',textAlign: TextAlign.center,
    //                  style: TextStyle(
    //                   color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
    //                  ),)
    //                ],
    //              ),









    //               Column(
    //                children: [
    //                  InkWell(
    //                   onTap: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ZakahPage()));
    //                   },
    //                    child: Container(
    //                     height: 55,width: 55,
    //                     decoration: BoxDecoration(
    //                       color: Colors.transparent,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         width: 2,
    //                         color: AppColors.primary
    //                       )
    //                     ),
                            
    //                           child: Image.asset('assets/images/zakat.png',color: AppColors.secondary,),
                        
    //                    ),
    //                  ),
    //                  Text('Zakat',style: TextStyle(
    //                   color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
    //                  ),)
    //                ],
    //              ),













    //               Column(
    //                children: [
    //                  InkWell(
    //                   onTap: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>VolunteerRequestPage()));
    //                   },
    //                    child: Container(
    //                     height: 55,width: 55,
    //                     decoration: BoxDecoration(
    //                       color: Colors.transparent,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         width: 2,
    //                         color: AppColors.primary
    //                       )
    //                     ),
                            
    //                           child: Image.asset('assets/images/6.png',color: AppColors.secondary,),
                        
    //                    ),
    //                  ),
    //                  Text('volounter',style: TextStyle(
    //                   color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
    //                  ),)
    //                ],
    //              ),












    //               Column(
    //                children: [
    //                  InkWell(
    //                   onTap: (){
    //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SadakahPage()));
    //                   },
    //                    child: Container(
    //                     height: 55,width: 55,
    //                     decoration: BoxDecoration(
    //                       color: Colors.transparent,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         width: 2,
    //                         color: AppColors.primary
    //                       )
    //                     ),
                            
    //                           child: Image.asset('assets/images/0.png',color: AppColors.secondary,),
                        
    //                    ),
    //                  ),
    //                  Text('sadakah',style: TextStyle(
    //                   color: AppColors.primary,fontWeight: FontWeight.w700,fontSize: 15
    //                  ),)
    //                ],
    //              ),
    //   ],
    // );
  }
}
