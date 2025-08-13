import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocDetailsCampaign/bloc/bloc_details_campaign_bloc.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OneCampaignPage extends StatefulWidget {
  const OneCampaignPage({super.key,required this.id});
final int id ;
  @override
  State<OneCampaignPage> createState() => _OneCampaignPageState();
}

class _OneCampaignPageState extends State<OneCampaignPage> {
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => BlocDetailsCampaignBloc()..add(FetchDetailsCampaignEvent(widget.id)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
        ),
        body: BackgroundWrapper(
            child: SizedBox(
          height: 800,
          child: BlocBuilder<BlocDetailsCampaignBloc, BlocDetailsCampaignState>(
            builder: (context, state) {
              if (state is BlocDetailsCampaignLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.primary,));
              }
              else if (state is BlocDetailsCampaignError)
          {
            return Text(state.ErrorMsg);
          }
          else if (state is BlocDetailsCampaignLoaded){
 final String imageUrl=state.campaignsDetails.image!;
                          final String finalImage =Uri.parse("$baseUrlImage").resolve(imageUrl).toString();
                               final collected = state.campaignsDetails.collectedAmount;
                          final goal = state.campaignsDetails.goalAmount;
             int calculateDonationPercentage(int collectedAmount, int goalAmount) {
  if (goalAmount <= 0) return 0;
  int percent = ((collectedAmount / goalAmount) * 100).round();
  return percent.clamp(0, 100);
}
return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(finalImage),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Text(
                        state.campaignsDetails.title,
                        style: AppTextStyle.a,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'About Campaign'.tr(),
                        style: AppTextStyle.helpReq,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.campaignsDetails.description,
                        style: AppTextStyle.d,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "\$${state.campaignsDetails.collectedAmount} ",
                                  style: AppTextStyle.a,
                                ),
                                Text(
                                  "of".tr(),
                                  style: AppTextStyle.a,
                                ),
                                Text(
                                  "\$${state.campaignsDetails.goalAmount} ",
                                  style: AppTextStyle.agray,
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Text(
                                  calculateDonationPercentage(collected, goal).toString()+"%",
                                  style: AppTextStyle.a,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 800,
                              child: LinearPercentIndicator(
                                maskFilter: MaskFilter.blur(BlurStyle.solid, 3),
                                linearGradient: LinearGradient(colors: [
                                  AppColors.primary,
                                  AppColors.teal
                                ]),
                                barRadius: Radius.circular(10),
                                curve: Curves.easeInOut,
                                clipLinearGradient: true,
                                lineHeight: 15,
                                // progressColor: AppColors.primary,
                                percent: goal > 0 ? (collected/goal) : 0.0,
                                animation: true,
                                animationDuration: 1000,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 200),
                            child: Text(
                              "\$ ${state.campaignsDetails.remainingAmount}"+ "Remaining".tr(),
                              style: AppTextStyle.d,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(
                        "More details :".tr(),
                        style: AppTextStyle.helpReq,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                                Text(
                                  "Number of\nBeneficiaries".tr(),
                                  style: TextStyle(
                                    color: Color.fromARGB(148, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${state.campaignsDetails.beneficiariesCount.toString()}"+"person".tr(),
                                  style: AppTextStyle.helpReq,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 100, child: VerticalDivider()),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.query_builder,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Start Date".tr(),
                                  style: AppTextStyle.d,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat('d/M/yyyy', 'en').format(state.campaignsDetails.startDate),
                                  style: AppTextStyle.helpReq,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 100, child: VerticalDivider()),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "End Date".tr(),
                                  style: AppTextStyle.d,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text( DateFormat('d/M/yyyy', 'en').format(state.campaignsDetails.endDate),
                                  
                                  style: AppTextStyle.helpReq,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 20, top: 30, bottom: 20),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DonateCampaignsPage(detailsCampaignModel: state.campaignsDetails)));
                            },
                            child: Text('Donate').tr(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                fixedSize: Size(200, 50),
                                foregroundColor: AppColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );


          }
              else{
                return Text("ddd");
              }
            },
          ),
        )),
      ),
    );
  }
}
