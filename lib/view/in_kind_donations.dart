import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/view/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class in_kind_Donations extends StatefulWidget {
  const in_kind_Donations({super.key});

  @override
  State<in_kind_Donations> createState() => _in_kind_DonationsState();
}

class _in_kind_DonationsState extends State<in_kind_Donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Expanded(
            child: BlocBuilder<DonationBloc, DonationState>(
              builder: (context, state) {
                if (state is DonationLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ));
                } else if (state is DonationInKindSuccess) {
                  final inkinds = state.inkinds;
                  return ListView.builder(
                      itemCount: inkinds.length,
                      itemBuilder: (context, index) {
                        final inkind = inkinds[index];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Container(
                            height: 125,
                            // width: 200,
                            child: Card(
                              elevation: 3,
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              width: 2,
                                              color: AppColors.primary)),
                                      child: Image.asset(
                                        'assets/images/l.png',
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
                                                Icons
                                                    .volunteer_activism_outlined,
                                                color: AppColors.secondary,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                inkind.category.name,
                                                style: TextStyle(
                                                    color: AppColors.secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 4,
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   children: [
                                          //     SizedBox(
                                          //       width: 2,
                                          //     ),
                                          //     Icon(
                                          //       Icons.query_builder,
                                          //       color: AppColors.unselected,
                                          //       size: 16,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     Text(
                                          //       '5/7/2025',
                                          //       style: TextStyle(
                                          //           color: AppColors.unselected,
                                          //           fontWeight: FontWeight.w600,
                                          //           fontSize: 14),
                                          //     ),
                                          //   ],
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                inkind.campaign.status ==
                                                        "accepted"
                                                    ? Icons.check_circle_outline
                                                    : inkind.campaign.status ==
                                                            "rejected"
                                                        ? Icons.cancel_outlined
                                                        : Icons
                                                            .pause_circle_outline,
                                                color: inkind.campaign.status ==
                                                        "accepted"
                                                    ? Colors.green
                                                    : inkind.campaign.status ==
                                                            "rejected"
                                                        ? Colors.red
                                                        : Colors.black,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                inkind.campaign.status,
                                                style: TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w500,
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
                                                Icons.location_on_outlined,
                                                color: AppColors.primary,
                                                size: 18,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                inkind.address,
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w500,
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
                } else if (state is DonationEmpty) {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                } else if (state is DonationError) {
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
          ),
        ),
      ),
    );
  }
}
