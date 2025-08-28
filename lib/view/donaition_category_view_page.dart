import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/AllSponsorships/bloc/all_sponsorships_bloc_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipsByCategory/bloc/sponsorships_by_category_bloc_bloc.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
import 'package:charity_project/blocForApp/blocHumanCaseByCategory/bloc/humancase_by_category_bloc.dart';
import 'package:charity_project/view/HumanitarianCases_view_page.dart';
import 'package:charity_project/view/Sponsorships_view_page.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/campaign_view_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
 
class DonaitionCategoryViewPage extends StatefulWidget {
  const DonaitionCategoryViewPage({super.key,required this.Category,required this.categoryId});
final String Category;
final int categoryId;
  @override
  State<DonaitionCategoryViewPage> createState() => _DonaitionCategoryViewPageState();
}

class _DonaitionCategoryViewPageState extends State<DonaitionCategoryViewPage> {

 
  @override
Widget build(BuildContext context) {
  if (widget.Category == "Campaign") {
    return CampaignViewPage(categoryId:widget.categoryId,Category: widget.Category,);  }
    else if(widget.Category == "HumanCase"){
      return HumanitariancasesViewPage(categoryId:widget.categoryId,Category: widget.Category,);
    }
    else if(widget.Category == "Sponsorship"){
      return SponsorshipsViewPage(categoryId:widget.categoryId,Category: widget.Category);
    }
  return Scaffold(
    
    body: 
        
         Center(child: Text("No Data")), 
  );
}
}