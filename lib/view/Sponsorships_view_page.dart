import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/AllSponsorships/bloc/all_sponsorships_bloc_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipsByCategory/bloc/sponsorships_by_category_bloc_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/emergency_cases_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/one_HumanitarianCases_view_page.dart';
import 'package:charity_project/view/one_Sponsorships_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SponsorshipsViewPage extends StatefulWidget {
  const SponsorshipsViewPage(
      {super.key, required this.Category, required this.categoryId});
  final String Category;
  final int categoryId;
  @override
  State<SponsorshipsViewPage> createState() => _SponsorshipsViewPageState();
}

class _SponsorshipsViewPageState extends State<SponsorshipsViewPage> {
  Future<void> refreshData(BuildContext context) async {
    context.read<AllSponsorshipsBlocBloc>()..add(FetchAllSponsorships());

    context.read<SponsorshipsByCategoryBlocBloc>()
      ..add(FetchSponsorshipsByCategory(widget.categoryId));

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AllSponsorshipsBlocBloc()..add(FetchAllSponsorships()),
        ),
        BlocProvider(
          create: (context) => SponsorshipsByCategoryBlocBloc()
            ..add(FetchSponsorshipsByCategory(widget.categoryId)),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          onRefresh: () => refreshData(context),
          color: AppColors.primary,
          child: BackgroundWrapper(
              child: widget.categoryId == 0
                  ? BlocBuilder<AllSponsorshipsBlocBloc,
                      AllSponsorshipsBlocState>(
                      builder: (context, state) {
                        if (state is AllSponsorshipsBlocLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        } else if (state is AllSponsorshipsBlocError) {
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
                          // return Center(child: Text(state.ErrorMsg));
                        } else if (state is AllSponsorshipsBlocLoaded) {
                          if (state.allSponsorships.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "There is no Sponsorships yet".tr(),
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
                            return ListView.builder(
                                itemCount: state.allSponsorships.length,
                                itemBuilder: (context, index) {
                                  final String? imageUrl =
                                      state.allSponsorships[index].image;
                                  final String? finalImage =
                                      imageUrl != null && imageUrl.isNotEmpty
                                          ? Uri.parse(baseUrlImage)
                                              .resolve(imageUrl)
                                              .toString()
                                          : null;
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
                                                            fit: BoxFit.cover)),
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
                                                                .allSponsorships[
                                                                    index]
                                                                .title ??
                                                            "unknown",
                                                        20),
                                                    style: AppTextStyle.b,
                                                  ),
                                                  SizedBox(
                                                      height: 40,
                                                      width: 220,
                                                      child: Text(
                                                        maxLines: 2,
                                                        textmax(
                                                            state
                                                                    .allSponsorships[
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
                                                  //       state.allSponsorships[index].description ?? "",
                                                  //       style: AppTextStyle.c,
                                                  //     )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Amount/Month"
                                                                  .tr(),
                                                              style:
                                                                  AppTextStyle
                                                                      .c,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/as.png",
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  "\$ ${state.allSponsorships[index].monthlyAmount ?? 0}",
                                                                  style:
                                                                      AppTextStyle
                                                                          .b,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: context
                                                                    .locale
                                                                    .languageCode ==
                                                                "ar"
                                                            ? Alignment
                                                                .centerLeft
                                                            : Alignment
                                                                .centerRight,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 0),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          OneSponsorshipsPage(
                                                                            id: state.allSponsorships[index].id,
                                                                          )));
                                                            },
                                                            child:
                                                                Text("Details")
                                                                    .tr(),
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .secondary,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                fixedSize: Size(
                                                                    100, 30)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }
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
                      },
                    )
                  : BlocBuilder<SponsorshipsByCategoryBlocBloc,
                      SponsorshipsByCategoryBlocState>(
                      builder: (context, state) {
                        if (state is SponsorshipsByCategoryBlocLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        } else if (state is SponsorshipsByCategoryBlocError) {
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
                        } else if (state is SponsorshipsByCategoryBlocLoaded) {
                          if (state.SponsorshipsByCategory.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "There is no Sponsorships yet".tr(),
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
                            return ListView.builder(
                                itemCount: state.SponsorshipsByCategory.length,
                                itemBuilder: (context, index) {
                                  final String? imageUrl =
                                      state.SponsorshipsByCategory[index].image;
                                  final String? finalImage =
                                      imageUrl != null && imageUrl.isNotEmpty
                                          ? Uri.parse(baseUrlImage)
                                              .resolve(imageUrl)
                                              .toString()
                                          : null;
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
                                                            fit: BoxFit.cover)),
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
                                                                .SponsorshipsByCategory[
                                                                    index]
                                                                .title ??
                                                            "unknown",
                                                        20),
                                                    style: AppTextStyle.b,
                                                  ),
                                                  SizedBox(
                                                      height: 40,
                                                      width: 220,
                                                      child: Text(
                                                        maxLines: 2,
                                                        textmax(
                                                            state
                                                                    .SponsorshipsByCategory[
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
                                                  //               .SponsorshipsByCategory[
                                                  //                   index]
                                                  //               .description ??
                                                  //           "",
                                                  //       style:
                                                  //           AppTextStyle.c,
                                                  //     )),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Amount/Month"
                                                                  .tr(),
                                                              style:
                                                                  AppTextStyle
                                                                      .c,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/as.png",
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  "\$ ${state.SponsorshipsByCategory[index].monthlyAmount ?? 0}",
                                                                  style:
                                                                      AppTextStyle
                                                                          .b,
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: context
                                                                    .locale
                                                                    .languageCode ==
                                                                "ar"
                                                            ? Alignment
                                                                .centerLeft
                                                            : Alignment
                                                                .centerRight,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 0),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => OneSponsorshipsPage(
                                                                          id: state
                                                                              .SponsorshipsByCategory[index]
                                                                              .id)));
                                                            },
                                                            child:
                                                                Text("Details")
                                                                    .tr(),
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .secondary,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                fixedSize: Size(
                                                                    100, 30)),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        }
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
                      },
                    )),
        ),
      ),
    );
  }
}
