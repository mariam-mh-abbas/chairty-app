import 'dart:core';

import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

constructImageUrl(path) {
  if (path.startsWith('http')) return path;
  return '$baseUrl/storage/$path';
}

class sponsorships_page extends StatelessWidget {
  sponsorships_page({super.key});
  Future<void> refreshData(BuildContext context) async {
    context.read<SponsorshipsBloc>().add(GetSponsorshipEvent());

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => refreshData(context),
        child: BackgroundWrapper(
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
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  } else if (state is SponsorshipError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Update failed'.tr()),
                        // backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SponsorshipLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.secondary,
                    ));
                  } else if (state is SponsorshipSuccess) {
                    final sponsorships = state.sponorships;
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: sponsorships.length,
                          itemBuilder: (context, index) {
                            final sponsorship = sponsorships[index];
                            final imageUrl = sponsorship.sponsorship.image !=
                                    null
                                ? constructImageUrl(
                                    sponsorship.sponsorship.image!)
                                : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7mV6wrTwSt3fM0uNZz8TXSzgqYRSQ3F0epjHuGTmQa3UPF2ZL0bgJC3GUusfKcoSw5E&usqp=CAU';
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Container(
                                height: 250,
                                width: double.infinity,
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
                                              height: 115,
                                              width: 105,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          imageUrl),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 190,
                                                    child: Text(
                                                      sponsorship
                                                          .sponsorship.title,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .event_repeat_outlined,
                                                        color:
                                                            AppColors.secondary,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        sponsorship.recurrence
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        sponsorship.status ==
                                                                    "active" ||
                                                                sponsorship.status ==
                                                                    "نشطة"
                                                            ? Icons
                                                                .check_circle_outline
                                                            : Icons
                                                                .cancel_outlined,
                                                        color: sponsorship
                                                                        .status ==
                                                                    "active" ||
                                                                sponsorship
                                                                        .status ==
                                                                    "نشطة"
                                                            ? Colors.green
                                                            : Colors.red,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        sponsorship.status
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16),
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
                                                            color: AppColors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                        color: AppColors
                                                            .unselected,
                                                        size: 16,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        DateFormat('d/M/yyyy',
                                                                'en')
                                                            .format(sponsorship
                                                                .startDate),
                                                        // sponsorship.startDate
                                                        //     .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .unselected,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        " " +
                                                            "-" +
                                                            " " +
                                                            DateFormat(
                                                                    'd/M/yyyy',
                                                                    'en')
                                                                .format(
                                                                    sponsorship
                                                                        .endDate),
                                                        // sponsorship.endDate
                                                        //     .toString(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .unselected,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   height: 4,
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.start,
                                                  //   children: [
                                                  //     Icon(
                                                  //       Icons.query_builder,
                                                  //       color:
                                                  //           AppColors.unselected,
                                                  //       size: 16,
                                                  //     ),
                                                  //     SizedBox(
                                                  //       width: 5,
                                                  //     ),
                                                  //     Text(
                                                  //       DateFormat(
                                                  //               'd/M/yyyy', 'en')
                                                  //           .format(sponsorship
                                                  //               .endDate),
                                                  //       // sponsorship.endDate
                                                  //       //     .toString(),
                                                  //       style: TextStyle(
                                                  //           color: AppColors
                                                  //               .unselected,
                                                  //           fontWeight:
                                                  //               FontWeight.w600,
                                                  //           fontSize: 14),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              child: Text(
                                                  sponsorship.isActivated
                                                      ? 'Cancel'.tr()
                                                      : 'Activate'.tr()),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.primary,
                                                fixedSize: Size(105, 30),
                                                foregroundColor:
                                                    AppColors.white,
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
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                          content: Text(
                                                              'Not Found'
                                                                  .tr())),
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
                                                          color: AppColors
                                                              .primary)),
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    );
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
      ),
    );
  }
}
