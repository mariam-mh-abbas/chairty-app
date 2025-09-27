import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/recharge_bloc/bloc/recharge_bloc.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class receipts_page extends StatelessWidget {
  const receipts_page({super.key});
  Future<void> refreshData(BuildContext context) async {
    context.read<RechargeBloc>().add(GetRechargeEvent());

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
                'My recharges'.tr(),
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: BlocBuilder<RechargeBloc, RechargeState>(
                builder: (context, state) {
                  if (state is RechargeLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      // backgroundColor: AppColors.secondary,
                      color: AppColors.secondary,
                    ));
                  } else if (state is RechargeSuccess) {
                    final recharges = state.recharges;
                    return ListView.builder(
                        itemCount: recharges.length,
                        itemBuilder: (context, index) {
                          final recharge = recharges[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Container(
                              height: 110,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.primary)),
                                          child: Icon(
                                            Icons.receipt_long_outlined,
                                            color: AppColors.secondary,
                                            size: 34,
                                          )
                                          //  Image.asset(
                                          //   'assets/images/6.png',
                                          //   color: AppColors.secondary,
                                          // ),
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
                                                Image.asset(
                                                  "assets/images/as.png",
                                                  height: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  recharge.amount.toString() +
                                                      ' \$',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
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
                                                      .format(recharge.date),
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.unselected,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (state is RechargeEmpty) {
                    return Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/option 1.png",
                          height: 190,
                        ),
                      ),
                    );
                  } else if (state is RechargetError) {
                    // return Center(child: Text('${state.message}'));
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
