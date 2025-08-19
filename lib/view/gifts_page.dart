import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/gift_service.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class gifts_page extends StatelessWidget {
  const gifts_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(child: BlocBuilder<GiftBloc, GiftState>(
          builder: (context, state) {
            if (state is GiftLoading) {
              return Center(child: CircularProgressIndicator());
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
                                                    color: AppColors.secondary,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    gift.recipient_name,
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.secondary,
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
                                                    color: AppColors.unselected,
                                                    size: 16,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('d/M/yyyy', 'en')
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
                                        )
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
                        color: AppColors.primary, fontWeight: FontWeight.w700),
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
              return Center(child: Text('${state.message}'));
            } else {
              return Column(children: [
                AppBar(
                  backgroundColor: AppColors.white,
                  elevation: 2,
                  shadowColor: AppColors.unselected,
                  title: Text(
                    'My gifts'.tr(),
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w700),
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
      );
    });
  }
}
