import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCategoryByMainCategory/bloc/categorybymaincategory_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/ArchivedViewPage.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/campaign_view_page.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/donation_categories_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Archivedtabbarpage extends StatefulWidget {
 
  const Archivedtabbarpage({super.key});

  @override
  State<Archivedtabbarpage> createState() => _ArchivedtabbarpageState();
}

class _ArchivedtabbarpageState extends State<Archivedtabbarpage> {
  

  @override
  void initState() {
    super.initState();

   
  }

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              title: Text("Archived".tr(), style: AppTextStyle.a),
              bottom: TabBar(
                dividerColor: AppColors.primary,
                indicatorColor: AppColors.primary,
                unselectedLabelColor: AppColors.unselected,
                labelColor: AppColors.primary,
                // isScrollable: true,
                tabs:  [Tab(child: Text("Campaigns".tr(),),),
            Tab(child: Text("HumanitarianCases".tr(),),),]
              ),
            ),
            body: BackgroundWrapper(
              child: TabBarView(
      children: [
      Archivedviewpage(Category: "ArchivedCampaigns"),
       Archivedviewpage(Category: "ArchivedHumanCases")
      ]
    ),
            ),
          ),
        );
        
     
      
    
  }
}
