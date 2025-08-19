import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/benefits_bloc/bloc/benefits_bloc.dart';
import 'package:charity_project/view/Sponsorships_page.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class benefits_page extends StatelessWidget {
  const benefits_page({super.key});

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
              'My benefits',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: BlocBuilder<BenefitsBloc, BenefitsState>(
              builder: (context, state) {
                if (state is BenefitsSuccess) {
                  final benefits = state.benefits;
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: benefits.length,
                        itemBuilder: (context, index) {
                          final benefit = benefits[index];

                          final imageUrl = benefit.image != null
                              ? constructImageUrl(benefit.image!)
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7mV6wrTwSt3fM0uNZz8TXSzgqYRSQ3F0epjHuGTmQa3UPF2ZL0bgJC3GUusfKcoSw5E&usqp=CAU';
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Container(
                              height: 150,
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
                                        height: 130,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(imageUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                      // Container(
                                      //   height: 75,
                                      //   width: 75,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.transparent,
                                      //       borderRadius:
                                      //           BorderRadius.circular(12),
                                      //       border: Border.all(
                                      //           width: 2,
                                      //           color: AppColors.primary)),
                                      //   child: Image.asset(
                                      //     'assets/images/q.png',
                                      //     color: AppColors.secondary,
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              benefit.beneficiaryName,
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              benefit.type +
                                                  ' / ' +
                                                  benefit.category,
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              benefit.title,
                                              style: TextStyle(
                                                  color: AppColors.secondary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.query_builder,
                                                  color: AppColors.unselected,
                                                  size: 17,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  DateFormat('d/M/yyyy', 'en')
                                                      .format(benefit.date),
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.unselected,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
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
                        }),
                  );
                } else if (state is BenefitsEmpty) {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                } else if (state is BenefitsError) {
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
