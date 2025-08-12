import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class sponsorships_page extends StatelessWidget {
  sponsorships_page({super.key});

  String constructImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return '$baseUrl/storage/$path';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.unselected,
            title: Text(
              'My sponsorships'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: BlocConsumer<SponsorshipsBloc, SponsorshipsState>(
              listener: (context, state) {
                if (state is SponsorshipActionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Updated successfully'.tr()),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is SponsorshipError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Update failed'.tr()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SponsorshipLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SponsorshipSuccess) {
                  final sponsorships = state.sponorships;
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: sponsorships.length,
                        itemBuilder: (context, index) {
                          final sponsorship = sponsorships[index];
                          final imageUrl = sponsorship.sponsorship.image != null
                              ? constructImageUrl(
                                  sponsorship.sponsorship.image!)
                              : 'https://www.actionaid.org.uk/sites/default/files/styles/hero_large/public/storieshub/rs_143380.jpeg';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Container(
                              height: 270,
                              // width: 200,
                              child: Card(
                                elevation: 3,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 95,
                                            width: 95,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(imageUrl),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 220,
                                                  child: Text(
                                                    sponsorship
                                                        .sponsorship.title,
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Text(
                                                  sponsorship.recurrence
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.secondary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                                Text(
                                                  sponsorship.status.toString(),
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/as.png",
                                                      height: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      sponsorship.amount
                                                              .toString() +
                                                          '\$',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.query_builder,
                                                      color:
                                                          AppColors.unselected,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      sponsorship.startDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .unselected,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.query_builder,
                                                      color:
                                                          AppColors.unselected,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      sponsorship.endDate
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .unselected,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: sponsorship.isActivated
                                                ? () {
                                                    context
                                                        .read<
                                                            SponsorshipsBloc>()
                                                        .add(
                                                            DeactivateSponsorshipEvent(
                                                                sponsorship
                                                                    .id));
                                                  }
                                                : () {
                                                    context
                                                        .read<
                                                            SponsorshipsBloc>()
                                                        .add(
                                                            ReactivateSponsorshipEvent(
                                                                sponsorship
                                                                    .id));
                                                  },
                                            child: Text(sponsorship.isActivated
                                                ? 'Cancel'.tr()
                                                : 'Activate'.tr()),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primary,
                                              fixedSize: Size(105, 30),
                                              foregroundColor: AppColors.white,
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {},
                                          //   child: Text(
                                          //     'Cancel',
                                          //     style: TextStyle(
                                          //         color: AppColors.white,
                                          //         fontWeight: FontWeight.w600,
                                          //         fontSize: 12),
                                          //   ),
                                          //   style: ElevatedButton.styleFrom(
                                          //       backgroundColor:
                                          //           AppColors.primary,
                                          //       fixedSize: Size(95, 30),
                                          //       foregroundColor:
                                          //           AppColors.white),
                                          // ),
                                          // SizedBox(
                                          //   width: 10,
                                          // ),
                                          // ElevatedButton(
                                          //   onPressed: () {},
                                          //   child: Text(
                                          //     'Activate',
                                          //     style: TextStyle(
                                          //         color: AppColors.white,
                                          //         fontWeight: FontWeight.w600,
                                          //         fontSize: 12),
                                          //   ),
                                          //   style: ElevatedButton.styleFrom(
                                          //       backgroundColor:
                                          //           AppColors.primary,
                                          //       fixedSize: Size(95, 30),
                                          //       foregroundColor:
                                          //           AppColors.white),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (sponsorship
                                                  .transactions.isNotEmpty) {
                                                final rawPdfUrl = sponsorship
                                                    .transactions.last.pdfUrl;
                                                if (rawPdfUrl!.isNotEmpty) {
                                                  final url = constructPdfUrl(
                                                      rawPdfUrl!);
                                                  print(
                                                      'Final PDF URL: $url'); // تتأكد شو الرابط اللي عم يتبني
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          PdfViewerPage(
                                                              pdfUrl: url),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Not Found'.tr())),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Not Found'.tr())),
                                                );
                                              }
                                            },
                                            child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        width: 2,
                                                        color:
                                                            AppColors.primary)),
                                                child: Icon(
                                                  Icons.receipt_long_outlined,
                                                  color: AppColors.secondary,
                                                  size: 24,
                                                )
                                                //  Image.asset(
                                                //   'assets/images/6.png',
                                                //   color: AppColors.secondary,
                                                // ),
                                                ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (state is SponsorshipEmpty) {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                } else if (state is SponsorshipError) {
                  return Center(child: Text('${state.message}'));
                } else {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
