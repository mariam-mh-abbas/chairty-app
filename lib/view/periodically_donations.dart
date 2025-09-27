import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class periodically_Donations extends StatefulWidget {
  const periodically_Donations({super.key});

  @override
  State<periodically_Donations> createState() => _Request_VolunteringState();
}

Future<void> refreshData(BuildContext context) async {
  context.read<DonationBloc>().add(DonationPeriodicallyEvent());

  await Future.delayed(Duration(seconds: 1));
}

class _Request_VolunteringState extends State<periodically_Donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => refreshData(context),
        child: BackgroundWrapper(
          child: Expanded(
            child: BlocConsumer<DonationBloc, DonationState>(
              listener: (context, state) {
                if (state is PlanActionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Updated successfully'.tr()),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                } else if (state is DonationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Update failed'.tr()),
                      // backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DonationLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ));
                } else if (state is DonationPeriodicallySuccess) {
                  final plans = state.plans;
                  return ListView.builder(
                      itemCount: plans.length,
                      itemBuilder: (context, index) {
                        final plan = plans[index];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Container(
                            height: 220,
                            width: 200,
                            child: Card(
                              elevation: 3,
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 85,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.primary)),
                                          child: Image.asset(
                                            'assets/images/7.png',
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
                                                    Icons.event_repeat_outlined,
                                                    color: AppColors.secondary,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    plan.recurrenceLabel
                                                        .toString(),
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.secondary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(
                                              //   height: 4,
                                              // ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    plan.status == "active" ||
                                                            plan.status ==
                                                                "نشطة"
                                                        ? Icons
                                                            .check_circle_outline
                                                        : Icons.cancel_outlined,
                                                    color: plan.status ==
                                                                "active" ||
                                                            plan.status ==
                                                                "نشطة"
                                                        ? Colors.green
                                                        : Colors.red,
                                                    size: 18,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    plan.status.toString(),
                                                    style: TextStyle(
                                                        color: AppColors.black,
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
                                                    plan.amount.toString() +
                                                        ' \$',
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
                                                        .format(plan.startDate),
                                                    // plan.startDate.toString(),
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
                                                        DateFormat('d/M/yyyy',
                                                                'en')
                                                            .format(
                                                                plan.endDate),
                                                    // plan.endDate.toString(),
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
                                              //       color: AppColors.unselected,
                                              //       size: 16,
                                              //     ),
                                              //     SizedBox(
                                              //       width: 5,
                                              //     ),
                                              //     Text(
                                              //       DateFormat('d/M/yyyy', 'en')
                                              //           .format(plan.endDate),
                                              //       // plan.endDate.toString(),
                                              //       style: TextStyle(
                                              //           color:
                                              //               AppColors.unselected,
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
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: plan.isActivated
                                              ? () {
                                                  context
                                                      .read<DonationBloc>()
                                                      .add(DeactivatePlanEvent(
                                                          plan.id));
                                                }
                                              : () {
                                                  context
                                                      .read<DonationBloc>()
                                                      .add(ReactivatePlanEvent(
                                                          plan.id));
                                                },
                                          child: Text(plan.isActivated
                                              ? 'Cancel'.tr()
                                              : 'Activate'.tr()),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
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
                                        //       backgroundColor: AppColors.primary,
                                        //       fixedSize: Size(95, 30),
                                        //       foregroundColor: AppColors.white),
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
                                        //       backgroundColor: AppColors.primary,
                                        //       fixedSize: Size(95, 30),
                                        //       foregroundColor: AppColors.white),
                                        // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (plan.transactions.isNotEmpty) {
                                              final rawPdfUrl =
                                                  plan.transactions.last.pdfUrl;
                                              if (rawPdfUrl!.isNotEmpty) {
                                                final url =
                                                    constructPdfUrl(rawPdfUrl!);
                                                print('Final PDF URL: $url');
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
                                                  'Not Found'.tr(),
                                                )),
                                              );
                                            }
                                          },
                                          child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
          ),
        ),
      ),
    );
  }
}
