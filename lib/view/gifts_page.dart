import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/gift_service.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class gifts_page extends StatelessWidget {
  const gifts_page({super.key});

  Future<void> refreshData(BuildContext context) async {
    context.read<GiftBloc>().add(GetGiftEvent());

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () => refreshData(context),
          child: BackgroundWrapper(child: BlocBuilder<GiftBloc, GiftState>(
            builder: (context, state) {
              if (state is GiftLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColors.secondary,
                ));
              } else if (state is GiftSuccess) {
                final gifts = state.gifts;
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: AppColors.white,
                      elevation: 2,
                      shadowColor: AppColors.unselected,
                      title: Text(
                        'My gifts'.tr(),
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                            itemCount: gifts.length,
                            itemBuilder: (context, index) {
                              final gift = gifts[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Container(
                                  height: 120,
                                  width: 200,
                                  child: Card(
                                    elevation: 3,
                                    color: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 65,
                                            width: 65,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    width: 2,
                                                    color: AppColors.primary)),
                                            child: Image.asset(
                                              'assets/images/m.png',
                                              color: AppColors.secondary,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color:
                                                          AppColors.secondary,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      gift.recipient_name,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .secondary,
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
                                                      gift.amount.toString() +
                                                          ' ' +
                                                          '\$',
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.primary,
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
                                                      color:
                                                          AppColors.unselected,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      DateFormat(
                                                              'd/M/yyyy', 'en')
                                                          .format(
                                                              gift.donated_at),
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .unselected,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),

                                                // Text(
                                                //   '100 ' + '\$',
                                                //   style: TextStyle(
                                                //       color: AppColors.secondary,
                                                //       fontWeight: FontWeight.w600,
                                                //       fontSize: 16),
                                                // ),
                                                // Text(
                                                //   '5/7/2025',
                                                //   style: TextStyle(
                                                //       color: AppColors.unselected,
                                                //       fontWeight: FontWeight.w600,
                                                //       fontSize: 14),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (gift.pdfUrl!.isNotEmpty) {
                                                final rawPdfUrl = gift.pdfUrl;
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
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                );
              } else if (state is GiftEmpty) {
                return Column(children: [
                  AppBar(
                    backgroundColor: AppColors.white,
                    elevation: 2,
                    shadowColor: AppColors.unselected,
                    title: Text(
                      'My gifts'.tr(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                  ),
                  // Text(
                  //   "There is no Campaigns yet",
                  //   style: AppTextStyle.b,
                  // ),
                  Image.asset(
                    "assets/images/option 1.png",
                    height: 190,
                  )
                ]);
              } else if (state is GiftError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBar(
                        backgroundColor: AppColors.white,
                        elevation: 2,
                        shadowColor: AppColors.unselected,
                        title: Text(
                          'My gifts'.tr(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
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
                );
              } else {
                return Column(children: [
                  AppBar(
                    backgroundColor: AppColors.white,
                    elevation: 2,
                    shadowColor: AppColors.unselected,
                    title: Text(
                      'My gifts'.tr(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                  ),
                  // Text(
                  //   "There is no Campaigns yet",
                  //   style: AppTextStyle.b,
                  // ),
                  Image.asset(
                    "assets/images/option 1.png",
                    height: 190,
                  )
                ]);
              }
            },
          )),
        ),
      );
    });
  }
}
