import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/SponsorshipsDetails/bloc/sponsorship_details_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/donate_sponsorship_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OneSponsorshipsPage extends StatefulWidget {
  const OneSponsorshipsPage({super.key, required this.id});
  final int id;
  @override
  State<OneSponsorshipsPage> createState() => _OneSponsorshipsPageState();
}

class _OneSponsorshipsPageState extends State<OneSponsorshipsPage> {
  Future<void> refreshData(BuildContext context) async {
    context.read<SponsorshipDetailsBloc>()
      ..add(FetchSponsorshipDetails(widget.id));

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SponsorshipDetailsBloc()..add(FetchSponsorshipDetails(widget.id)),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: BlocBuilder<SponsorshipDetailsBloc,
                    SponsorshipDetailsState>(
                  builder: (context, state) {
                    if (state is SponsorshipDetailsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else if (state is SponsorshipDetailsError) {
                      return Center(
                        child: Text(state.ErrorMsg),
                      );
                    } else if (state is SponsorshipDetailsLoaded) {
                      final String? imageUrl =
                          state.sponsorshipDetailsmodel.image;
                      final String? finalImage = imageUrl != null &&
                              imageUrl.isNotEmpty
                          ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
                          : null;
                      return Column(
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
                            state.sponsorshipDetailsmodel.title ?? "unknown",
                            style: AppTextStyle.a,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'About Sponsorship '.tr(),
                            style: AppTextStyle.helpReq,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                                state.sponsorshipDetailsmodel.description ?? "",
                                style: AppTextStyle.d),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Center(
                              child: Container(
                                width: 350,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: AppColors.primary)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "\$ ${state.sponsorshipDetailsmodel.monthlyAmount ?? 0}",
                                            style: AppTextStyle.a,
                                          ),
                                          Text(
                                            "Monthly Amount".tr(),
                                            style: AppTextStyle.helpReq
                                                .copyWith(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Image.asset(
                                      "assets/images/ass.png",
                                      height: 90,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          state.sponsorshipDetailsmodel.beneficiaryBirthDate !=
                                      null &&
                                  state.sponsorshipDetailsmodel
                                          .beneficiaryGender !=
                                      null &&
                                  state.sponsorshipDetailsmodel.categoryName !=
                                      null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "More details :".tr(),
                                      style: AppTextStyle.helpReq,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.border_color,
                                                color: AppColors.primary,
                                                size: 32,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Type".tr(),
                                                style: AppTextStyle.d,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.sponsorshipDetailsmodel
                                                        .categoryName ??
                                                    "",
                                                style: AppTextStyle.helpReq,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 100,
                                            child: VerticalDivider()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color: AppColors.primary,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Gender".tr(),
                                                style: AppTextStyle.d,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.sponsorshipDetailsmodel
                                                        .beneficiaryGender ??
                                                    "",
                                                style: AppTextStyle.helpReq,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: 100,
                                            child: VerticalDivider()),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: AppColors.primary,
                                                size: 32,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "BirthDate".tr(),
                                                style: AppTextStyle.d,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.sponsorshipDetailsmodel
                                                            .beneficiaryBirthDate !=
                                                        null
                                                    ? DateFormat(
                                                            'd/M/yyyy', 'en')
                                                        .format(state
                                                            .sponsorshipDetailsmodel
                                                            .beneficiaryBirthDate!)
                                                    : "",
                                                style: AppTextStyle.helpReq,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
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
                                                DonateSponsorshipPage(
                                                  sponsorshipDetailsmodel: state
                                                      .sponsorshipDetailsmodel,
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
                      );
                    }
                    return Text("data");
                  },
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
