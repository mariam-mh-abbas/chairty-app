import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocHumanCaseDetails/bloc/bloc_humancase_details_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
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
  Future<void> refreshData(BuildContext context) async {
    context.read<BlocHumancaseDetailsBloc>()
      ..add(FetchHumancaseDetailsEvent(widget.id));

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocHumancaseDetailsBloc()
        ..add(FetchHumancaseDetailsEvent(widget.id)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
        ),
        body: RefreshIndicator(
          onRefresh: () => refreshData(context),
          color: AppColors.primary,
          child: BackgroundWrapper(
              child: SizedBox(
            height: 800,
            child: BlocBuilder<BlocHumancaseDetailsBloc,
                BlocHumancaseDetailsState>(
              builder: (context, state) {
                if (state is HumancaseDetailsLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ));
                } else if (state is HumancaseDetailsError) {
                  return Scaffold(
                    backgroundColor: AppColors.background,
                    body: BackgroundWrapper(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 270,
                          ),
                          Container(
                            child: Image.asset(
                              "assets/images/error.png",
                              height: 190,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Internet connection is not available".tr(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )),
                  );
                } else if (state is HumancaseDetailsLoaded) {
                  final String? imageUrl = state.detailshumanncasesmodel.image;
                  final String? finalImage =
                      imageUrl != null && imageUrl.isNotEmpty
                          ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
                          : null;
                  final collected =
                      state.detailshumanncasesmodel.collectedAmount ?? 0;
                  final goal = state.detailshumanncasesmodel.goalAmount ?? 0;
                  int calculateDonationPercentage(
                      int collectedAmount, int goalAmount) {
                    if (goalAmount <= 0) return 0;
                    int percent =
                        ((collectedAmount / goalAmount) * 100).round();
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
                                  image: finalImage != null
                                      ? DecorationImage(
                                          image: NetworkImage(finalImage),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: AssetImage(
                                              "assets/images/general.png"),
                                          fit: BoxFit.cover)),
                            ),
                          ),
                          Text(
                            state.detailshumanncasesmodel.title ?? "unknown",
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
                          Text(
                            state.detailshumanncasesmodel.description ?? "",
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
                                      "of".tr() +
                                          "\$${state.detailshumanncasesmodel.goalAmount} ",
                                      style: AppTextStyle.agray,
                                    ),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Text(
                                      calculateDonationPercentage(
                                                  collected, goal)
                                              .toString() +
                                          "%",
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
                                    maskFilter:
                                        MaskFilter.blur(BlurStyle.solid, 3),
                                    linearGradient: LinearGradient(colors: [
                                      AppColors.primary,
                                      AppColors.teal
                                    ]),
                                    barRadius: Radius.circular(10),
                                    curve: Curves.easeInOut,
                                    clipLinearGradient: true,
                                    lineHeight: 15,
                                    // progressColor: AppColors.primary,
                                    percent: goal > 0
                                        ? (collected / goal).clamp(0.0, 1.0)
                                        : 0.0,

                                    animation: true,
                                    animationDuration: 1000,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Text(
                                  "\$ ${state.detailshumanncasesmodel.remainingAmount}" +
                                      "Remaining".tr(),
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
                                onPressed: () async {
                                  final token =
                                      await SharedPrefs.getToken() ?? '';
                                  if (token == null || token.isEmpty) {
                                    return PaymentResultDialog.Guest(context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DonateHumancasePage(
                                                  detailshumanncasesmodel: state
                                                      .detailshumanncasesmodel,
                                                )));
                                  }
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
                } else {
                  return Scaffold(
                    backgroundColor: AppColors.background,
                    body: BackgroundWrapper(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 270,
                          ),
                          Container(
                            child: Image.asset(
                              "assets/images/error.png",
                              height: 190,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Internet connection is not available".tr(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )),
                  );
                }
              },
            ),
          )),
        ),
      ),
    );
  }
}
