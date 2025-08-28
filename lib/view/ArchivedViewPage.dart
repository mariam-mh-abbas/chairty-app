import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/ArchivedCampaigns/bloc/archived_campaigns_bloc.dart';
import 'package:charity_project/blocForApp/ArchivedHumanCases/bloc/archived_humancases_bloc.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Archivedviewpage extends StatefulWidget {
  const Archivedviewpage({super.key, required this.Category});
  final String Category;

  @override
  State<Archivedviewpage> createState() => _ArchivedviewpageState();
}

class _ArchivedviewpageState extends State<Archivedviewpage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArchivedCampaignsBloc>(
          create: (context) => ArchivedCampaignsBloc()..add(FetchArchivedCampaigns()),
        ),
        BlocProvider<ArchivedHumancasesBloc>(
          create: (context) => ArchivedHumancasesBloc()..add(FetchArchivedHumancases()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
          child: widget.Category == "ArchivedCampaigns"
              ? BlocBuilder<ArchivedCampaignsBloc, ArchivedCampaignsState>(
                  builder: (context, state) {
                    if (state is ArchivedCampaignsLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (state is ArchivedCampaignsLoaded) {
                      if (state.ArchivedCampaigns.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("There is no Archived Campaigns yet".tr(), style: AppTextStyle.b),
                              Image.asset("assets/images/option 1.png", height: 190),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.ArchivedCampaigns.length,
                          itemBuilder: (context, index) {
                            final campaign = state.ArchivedCampaigns[index];
                            final String? imageUrl = campaign.image ;
                            final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;
                            final collected = campaign.collectedAmount ?? 0;
                            final goal = campaign.goalAmount ?? 0;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Card(
                                elevation: 10,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image:finalImage != null
                               ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                               : DecorationImage(image: AssetImage("assets/images/general.png"),fit: BoxFit.cover)
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              campaign.title ?? "",
                                              style: AppTextStyle.b,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),
                                            
                                            Column(
                                              children: [
                                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.query_builder,
                                  color: AppColors.primary,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Start Date:".tr(),
                                  style: AppTextStyle.c1,
                                  
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text( campaign.startDate !=null
                                 ? DateFormat('d/M/yyyy', 'en').format(campaign.startDate!)
                                 : "",
                                  style: AppTextStyle.c,
                                )
                              ],
                            ),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.history,
                                  color: AppColors.primary,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "End Date:".tr(),
                                  style: AppTextStyle.c1,
                                  
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text( campaign.endDate !=null
                                  ? DateFormat('d/M/yyyy', 'en').format(campaign.endDate!)
                                  : "",
                                  style: AppTextStyle.c,
                                )
                              ],
                            ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            LinearPercentIndicator(
                                              maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                                              linearGradient: LinearGradient(colors: [AppColors.primary, AppColors.teal]),
                                              barRadius: Radius.circular(10),
                                              curve: Curves.easeInOut,
                                              clipLinearGradient: true,
                                              lineHeight: 10,
                                              percent: goal > 0 ? (collected / goal) : 0.0,
                                              animation: true,
                                              animationDuration: 1000,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                                              child: Text(
                                                "\$${campaign.collectedAmount} / \$${campaign.goalAmount}",
                                                style: AppTextStyle.c,
                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return Container();
                  },
                )
              : BlocBuilder<ArchivedHumancasesBloc, ArchivedHumancasesState>(
                  builder: (context, state) {
                    if (state is ArchivedHumancasesLoading) {
                      return Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (state is ArchivedHumancasesLoaded) {
                      if (state.ArchivedHumanCases.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("There is no Archived HumanitarianCases yet", style: AppTextStyle.b),
                              Image.asset("assets/images/option 1.png", height: 190),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: state.ArchivedHumanCases.length,
                          itemBuilder: (context, index) {
                            final caseData = state.ArchivedHumanCases[index];
                            final String? imageUrl = caseData.image;
                           final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;
                            final collected = caseData.collectedAmount ?? 0;
                            final goal = caseData.goalAmount ?? 0;

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Card(
                                elevation: 10,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: finalImage != null
                               ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                               : DecorationImage(image: AssetImage("assets/images/general.png"),fit: BoxFit.cover)
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              caseData.title ?? "",
                                              style: AppTextStyle.b,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            
                                            SizedBox(height: 10),
                                            LinearPercentIndicator(
                                              maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                                              linearGradient: LinearGradient(colors: [AppColors.primary, AppColors.teal]),
                                              barRadius: Radius.circular(10),
                                              curve: Curves.easeInOut,
                                              clipLinearGradient: true,
                                              lineHeight: 10,
                                              percent: goal > 0 ? (collected / goal) : 0.0,
                                              animation: true,
                                              animationDuration: 1000,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                                              child: Text(
                                                "\$${caseData.collectedAmount} / \$${caseData.goalAmount}",
                                                style: AppTextStyle.c,
                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else if (state is ArchivedHumancasesError) {
                      return Center(child: Text(state.ErrorMsg));
                    }
                    return Container();
                  },
                ),
        ),
      ),
    );
  }
}