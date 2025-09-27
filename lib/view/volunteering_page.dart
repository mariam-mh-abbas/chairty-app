import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/volunteering_bloc/bloc/volunteering_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/Sponsorships_page.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class voluntering_page extends StatelessWidget {
  const voluntering_page({super.key});

  Future<void> refreshData(BuildContext context) async {
    context.read<VolunteeringBloc>().add(GetVolunteeringEvent());

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
                'My volunteers'.tr(),
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: BlocBuilder<VolunteeringBloc, VolunteeringState>(
                builder: (context, state) {
                  if (state is VolunteeringLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      // backgroundColor: AppColors.secondary,
                      color: AppColors.secondary,
                    ));
                  } else if (state is VolunteeringSuccess) {
                    final volunteerings = state.volunteerings;
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: volunteerings.length,
                          itemBuilder: (context, index) {
                            final volunteering = volunteerings[index];
                            final imageUrl = volunteering.campaignImage != null
                                ? constructImageUrl(volunteering.campaignImage!)
                                : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRh7mV6wrTwSt3fM0uNZz8TXSzgqYRSQ3F0epjHuGTmQa3UPF2ZL0bgJC3GUusfKcoSw5E&usqp=CAU';
                            return Container(
                              height: 150,
                              width: 200,
                              child: Card(
                                elevation: 3,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        width: 100,
                                        height: 100,
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
                                        Text(
                                          volunteering.volunteerName,
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          volunteering.campaignTitle,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          volunteering.volunteeringType
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.secondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 2,
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
                                                  .format(volunteering
                                                      .campaignDate),
                                              style: TextStyle(
                                                  color: AppColors.unselected,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (state is VolunteeringEmpty) {
                    return Center(
                      child: Container(
                        child: Image.asset(
                          "assets/images/option 1.png",
                          height: 190,
                        ),
                      ),
                    );
                  } else if (state is VolunteeringError) {
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
          ],
        )),
      ),
    );
  }
}
