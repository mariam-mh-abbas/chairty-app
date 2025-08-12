import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocHumanCaseDetails/bloc/bloc_humancase_details_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/donate_humancase_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OneHumanitariancasesViewPage extends StatefulWidget {
  const OneHumanitariancasesViewPage({super.key, required this.id});
  final int id;
  @override
  State<OneHumanitariancasesViewPage> createState() =>
      _OneHumanitariancasesViewPageState();
}

class _OneHumanitariancasesViewPageState
    extends State<OneHumanitariancasesViewPage> {
  @override
  Widget build(BuildContext context) {
    // final progress = (raisedamount / goalamount).clamp(0.0, 1.0);
    return BlocProvider(
      create: (context) => BlocHumancaseDetailsBloc()
        ..add(FetchHumancaseDetailsEvent(widget.id)),
      child: Scaffold(
        backgroundColor:  AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
        ),
        body: BackgroundWrapper(
            child: SizedBox(
          height: 800,
          child: BlocBuilder<BlocHumancaseDetailsBloc, BlocHumancaseDetailsState>(
            builder: (context, state) {
              if (state is HumancaseDetailsLoading) {
                return Center(child: CircularProgressIndicator(color: AppColors.primary,));
              } else if (state is HumancaseDetailsError){
                return Text(state.ErrorMsg);
              }
              else if (state is HumancaseDetailsLoaded){
                final String imageUrl=state.detailshumanncasesmodel.image!;
                          final String finalImage =Uri.parse("$baseUrlImage").resolve(imageUrl).toString();
                               final collected = state.detailshumanncasesmodel.collectedAmount;
                          final goal = state.detailshumanncasesmodel.goalAmount;
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
                        state.detailshumanncasesmodel.title!,
                        style: AppTextStyle.a,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'About HumanitarianCase '.tr(),
                        style: AppTextStyle.helpReq,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.detailshumanncasesmodel.description!
                        ,
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
                                  "\$${state.detailshumanncasesmodel.collectedAmount} ",
                                  style: AppTextStyle.a,
                                ),
                                Text(
                                  "of".tr()+"\$${state.detailshumanncasesmodel.goalAmount} ",
                                  style: AppTextStyle.agray,
                                ),
                                SizedBox(
                                  width: 120,
                                ),
                                Text(calculateDonationPercentage(collected!, goal!).toString()+"%"
                                  ,
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
                              "\$ ${state.detailshumanncasesmodel.remainingAmount}"+"Remaining".tr(),
                              style: AppTextStyle.d,
                            ),
                          ),
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
                                          DonateHumancasePage(detailshumanncasesmodel: state.detailshumanncasesmodel,)));
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
                return Text("initial");
              }
            },
          ),
        )),
      ),
    );
  }
}
