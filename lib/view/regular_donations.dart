import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/Sponsorships_page.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Regular_Donations extends StatefulWidget {
  const Regular_Donations({super.key});

  @override
  State<Regular_Donations> createState() => _Regular_DonationsState();
}

Future<void> refreshData(BuildContext context) async {
  context.read<DonationBloc>().add(DonationRegularEvent());

  await Future.delayed(Duration(seconds: 1));
}

class _Regular_DonationsState extends State<Regular_Donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => refreshData(context),
        child: BackgroundWrapper(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: BlocBuilder<DonationBloc, DonationState>(
              builder: (context, state) {
                if (state is DonationLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    // backgroundColor: AppColors.secondary,
                    color: AppColors.secondary,
                  ));
                } else if (state is DonationRegularSuccess) {
                  final regulars = state.regulars;
                  return ListView.builder(
                      itemCount: regulars.length,
                      itemBuilder: (context, index) {
                        final regular = regulars[index];
                        final imageUrl = regular.image != null
                            ? constructImageUrl(regular.image!)
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7mV6wrTwSt3fM0uNZz8TXSzgqYRSQ3F0epjHuGTmQa3UPF2ZL0bgJC3GUusfKcoSw5E&usqp=CAU';
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Container(
                            height: 140,
                            child: Card(
                              elevation: 3,
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(imageUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Column(
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
                                              Icons.volunteer_activism_outlined,
                                              color: AppColors.secondary,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                              width: 175,
                                              child: Text(
                                                regular.title,
                                                style: TextStyle(
                                                    color: AppColors.secondary,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),

                                        // Text(
                                        //   'Campaigns' + '/' + 'Construction',
                                        //   style: TextStyle(
                                        //       color: AppColors.unselected,
                                        //       fontWeight: FontWeight.w600,
                                        //       fontSize: 13),
                                        // ),
                                        // SizedBox(
                                        //   height: 4,
                                        // ),
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
                                              regular.amount.toString() + '\$',
                                              style: TextStyle(
                                                  color: AppColors.primary,
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
                                              Icons.query_builder,
                                              color: AppColors.unselected,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              DateFormat('d/M/yyyy', 'en')
                                                  .format(regular.date),
                                              style: TextStyle(
                                                  color: AppColors.unselected,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    InkWell(
                                      onTap: () {
                                        if (regular.pdfUrl!.isNotEmpty) {
                                          final rawPdfUrl = regular.pdfUrl;
                                          if (rawPdfUrl!.isNotEmpty) {
                                            final url =
                                                constructPdfUrl(rawPdfUrl!);
                                            print(
                                                'Final PDF URL: $url'); // تتأكد شو الرابط اللي عم يتبني
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    PdfViewerPage(pdfUrl: url),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('Not Found'.tr())),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Not Found'.tr())),
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
                                                  color: AppColors.primary)),
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
                                    // SizedBox(
                                    //   width: 15,
                                    // ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(bottom: 25),
                                    //   child: Column(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.end,
                                    //     children: [
                                    //       InkWell(
                                    //         onTap: () {},
                                    //         child: Container(
                                    //             height: 35,
                                    //             width: 35,
                                    //             decoration: BoxDecoration(
                                    //                 color: Colors.transparent,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         12),
                                    //                 border: Border.all(
                                    //                     width: 2,
                                    //                     color:
                                    //                         AppColors.primary)),
                                    //             child: Icon(
                                    //               Icons.receipt_long_outlined,
                                    //               color: AppColors.secondary,
                                    //               size: 24,
                                    //             )
                                    //             //  Image.asset(
                                    //             //   'assets/images/6.png',
                                    //             //   color: AppColors.secondary,
                                    //             // ),
                                    //             ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
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
