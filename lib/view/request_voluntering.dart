import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/volunteering_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Request_Voluntering extends StatefulWidget {
  const Request_Voluntering({super.key});

  @override
  State<Request_Voluntering> createState() => _Request_VolunteringState();
}

Future<void> refreshData(BuildContext context) async {
  context.read<RequestBloc>().add(VolunteerRequestEvent());

  await Future.delayed(Duration(seconds: 1));
}

class _Request_VolunteringState extends State<Request_Voluntering> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => refreshData(context),
        child: BackgroundWrapper(
          child: Expanded(
            child: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is RequestLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ));
                } else if (state is RequestSuccess) {
                  final requests = state.requests;
                  return ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<RequestBloc>(context).add(
                              VolunteerRequestDetailsEvent(request.id),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => volunteering_details(
                                          requestId: request.id,
                                        )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Container(
                              height: 120,
                              width: 200,
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
                                          'assets/images/help.png',
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
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
                                                  Icons.person_outline,
                                                  color: AppColors.secondary,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  request.name,
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.secondary,
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
                                                  request.status ==
                                                              "accepted" ||
                                                          request.status ==
                                                              "مقبول"
                                                      ? Icons
                                                          .check_circle_outline
                                                      : request.status ==
                                                                  "rejected" ||
                                                              request.status ==
                                                                  "مرفوض"
                                                          ? Icons
                                                              .cancel_outlined
                                                          : Icons
                                                              .pause_circle_outline,
                                                  color: request.status ==
                                                              "accepted" ||
                                                          request.status ==
                                                              "مقبول"
                                                      ? Colors.green
                                                      : request.status ==
                                                                  "rejected" ||
                                                              request.status ==
                                                                  "مرفوض"
                                                          ? Colors.red
                                                          : Colors.black,
                                                  size: 17,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  request.status,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                          request.createdAt),
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.unselected,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                          ),
                        );
                      });
                } else if (state is RequestError) {
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
                } else if (state is RequestEmpty) {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
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
