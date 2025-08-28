import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/blocForApp/blocCampaignByCategory/bloc/campaign_by_category_id_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/emergency_cases_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CampaignViewPage extends StatefulWidget {
  const CampaignViewPage(
      {super.key, required this.Category, required this.categoryId});
  final String Category;
  final int categoryId;

  @override
  State<CampaignViewPage> createState() => _CampaignViewPageState();
}

class _CampaignViewPageState extends State<CampaignViewPage> {
  Future<void> refreshData(BuildContext context) async {
    context.read<AllCampaignBloc>()..add(FetchAllCampaign());

    context.read<CampaignByCategoryIdBloc>()
      ..add(FetchCampaignByCategoryId(widget.categoryId));

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllCampaignBloc>(
          create: (context) => AllCampaignBloc()..add(FetchAllCampaign()),
        ),
        BlocProvider<CampaignByCategoryIdBloc>(
          create: (context) => CampaignByCategoryIdBloc()
            ..add(FetchCampaignByCategoryId(widget.categoryId)),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: () => refreshData(context),
          color: AppColors.primary,
          child: BackgroundWrapper(
              child: widget.categoryId == 0
                  ? BlocBuilder<AllCampaignBloc, AllCampaignState>(
                      builder: (context, state) {
                        if (state is AllCampaignLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ));
                        } else if (state is AllCampaignLoaded) {
                          if (state.Allcampaigns.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "There is no Campaigns yet".tr(),
                                    style: AppTextStyle.b,
                                  ),
                                  Image.asset(
                                    "assets/images/option 1.png",
                                    height: 190,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: state.Allcampaigns.length,
                                  itemBuilder: (context, index) {
                                    final String? imageUrl =
                                        state.Allcampaigns[index].image;
                                    final String? finalImage =
                                        imageUrl != null && imageUrl.isNotEmpty
                                            ? Uri.parse(baseUrlImage)
                                                .resolve(imageUrl)
                                                .toString()
                                            : null;
                                    final collected = state.Allcampaigns[index]
                                            .collectedAmount ??
                                        0;
                                    final goal =
                                        state.Allcampaigns[index].goalAmount ??
                                            0;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Container(
                                        height: 190,
                                        width: double.infinity,
                                        child: Card(
                                          elevation: 10,
                                          color: AppColors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: finalImage != null
                                                          ? DecorationImage(
                                                              image: NetworkImage(
                                                                  finalImage),
                                                              fit: BoxFit.cover)
                                                          : DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/general.png"),
                                                              fit: BoxFit
                                                                  .cover)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      textmax(
                                                          state
                                                                  .Allcampaigns[
                                                                      index]
                                                                  .title ??
                                                              "unknown",
                                                          22),
                                                      style: AppTextStyle.b,
                                                    ),
                                                    SizedBox(
                                                        height: 40,
                                                        width: 220,
                                                        child: Text(
                                                          maxLines: 2,
                                                          textmax(
                                                              state
                                                                      .Allcampaigns[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                              70),
                                                          style: AppTextStyle.c,
                                                        )),
                                                    // SizedBox(
                                                    //     height: 40,
                                                    //     width: 220,
                                                    //     child: Text(
                                                    //       maxLines: 2,
                                                    //       textmax(
                                                    //           state
                                                    //                   .Allcampaigns[
                                                    //                       index]
                                                    //                   .description ??
                                                    //               "",
                                                    //           30),
                                                    //       style: AppTextStyle.c,
                                                    //     )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child:
                                                              LinearPercentIndicator(
                                                            maskFilter:
                                                                MaskFilter.blur(
                                                                    BlurStyle
                                                                        .solid,
                                                                    3),
                                                            linearGradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  AppColors.teal
                                                                ]),
                                                            barRadius:
                                                                Radius.circular(
                                                                    10),
                                                            curve: Curves
                                                                .easeInOut,
                                                            clipLinearGradient:
                                                                true,
                                                            lineHeight: 10,
                                                            // progressColor: AppColors.primary,
                                                            percent: goal > 0
                                                                ? (collected /
                                                                    goal)
                                                                : 0.0,
                                                            animation: true,
                                                            animationDuration:
                                                                1000,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  "\$${state.Allcampaigns[index].collectedAmount} / \$${state.Allcampaigns[index].goalAmount}",
                                                                  style:
                                                                      AppTextStyle
                                                                          .c)
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 90, top: 5),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OneCampaignPage(
                                                                            id: state.Allcampaigns[index].id ??
                                                                                0,
                                                                          )));
                                                        },
                                                        child: Text(
                                                            "Details".tr()),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .secondary,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                fixedSize: Size(
                                                                    100, 30)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }
                        return Container();
                      },
                    )
                  : BlocBuilder<CampaignByCategoryIdBloc,
                      CampaignByCategoryIdState>(
                      builder: (context, state) {
                        if (state is CampaignByCategoryIdLoading) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ));
                        } else if (state is CampaignByCategoryIdLoaded) {
                          if (state.CampaignByCategory.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "There is no Campaigns yet".tr(),
                                    style: AppTextStyle.b,
                                  ),
                                  Image.asset(
                                    "assets/images/option 1.png",
                                    height: 190,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: state.CampaignByCategory.length,
                                  itemBuilder: (context, index) {
                                    final String? imageUrl =
                                        state.CampaignByCategory[index].image;
                                    final String? finalImage =
                                        imageUrl != null && imageUrl.isNotEmpty
                                            ? Uri.parse(baseUrlImage)
                                                .resolve(imageUrl)
                                                .toString()
                                            : null;
                                    final collected = state
                                            .CampaignByCategory[index]
                                            .collectedAmount ??
                                        0;
                                    final goal = state.CampaignByCategory[index]
                                            .goalAmount ??
                                        0;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Container(
                                        height: 190,
                                        width: double.infinity,
                                        child: Card(
                                          elevation: 10,
                                          color: AppColors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: finalImage != null
                                                          ? DecorationImage(
                                                              image: NetworkImage(
                                                                  finalImage),
                                                              fit: BoxFit.cover)
                                                          : DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/general.png"),
                                                              fit: BoxFit
                                                                  .cover)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      textmax(
                                                          state
                                                                  .CampaignByCategory[
                                                                      index]
                                                                  .title ??
                                                              "unknown",
                                                          22),
                                                      style: AppTextStyle.b,
                                                    ),
                                                    SizedBox(
                                                        height: 40,
                                                        width: 220,
                                                        child: Text(
                                                          maxLines: 2,
                                                          textmax(
                                                              state
                                                                      .CampaignByCategory[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                              70),
                                                          style: AppTextStyle.c,
                                                        )),
                                                    // SizedBox(
                                                    //     height: 50,
                                                    //     width: 200,
                                                    //     child: Text(
                                                    //       state
                                                    //               .CampaignByCategory[
                                                    //                   index]
                                                    //               .description ??
                                                    //           "",
                                                    //       style: AppTextStyle.c,
                                                    //     )),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child:
                                                              LinearPercentIndicator(
                                                            maskFilter:
                                                                MaskFilter.blur(
                                                                    BlurStyle
                                                                        .solid,
                                                                    3),
                                                            linearGradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  AppColors.teal
                                                                ]),
                                                            barRadius:
                                                                Radius.circular(
                                                                    10),
                                                            curve: Curves
                                                                .easeInOut,
                                                            clipLinearGradient:
                                                                true,
                                                            lineHeight: 10,
                                                            // progressColor: AppColors.primary,
                                                            percent: goal > 0
                                                                ? (collected /
                                                                    goal)
                                                                : 0.0,
                                                            animation: true,
                                                            animationDuration:
                                                                1000,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  "\$${state.CampaignByCategory[index].collectedAmount} / \$${state.CampaignByCategory[index].goalAmount}",
                                                                  style:
                                                                      AppTextStyle
                                                                          .c)
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 90, top: 5),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OneCampaignPage(
                                                                            id: state.CampaignByCategory[index].id ??
                                                                                0,
                                                                          )));
                                                        },
                                                        child: Text(
                                                            "Details".tr()),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .secondary,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                fixedSize: Size(
                                                                    100, 30)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        } else if (state is CampaignByCategoryIdError) {
                          return Text(state.ErrorMsg);
                        }
                        return Container();
                      },
                    )),
        ),
      ),
    );
  }
}
