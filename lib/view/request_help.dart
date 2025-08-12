import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/help_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Request_Help extends StatefulWidget {
  const Request_Help({super.key});

  @override
  State<Request_Help> createState() => _Request_HelpState();
}

class _Request_HelpState extends State<Request_Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: Expanded(
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, state) {
              if (state is RequestLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestSuccess) {
                final requests = state.requests;
                return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<RequestBloc>(context).add(
                            HelpRequestDetailsEvent(request.id),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => help_details(
                                        requestId: request.id,
                                      )));
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
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
                                          Text(
                                            request.name,
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            request.status,
                                            style: TextStyle(
                                                color: AppColors.secondary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
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
                                                request.createdAt,
                                                style: TextStyle(
                                                    color: AppColors.unselected,
                                                    fontWeight: FontWeight.w600,
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
              } else if (state is RequestEmpty) {
                return Center(
                  child: Container(
                    child: Image.asset(
                      "assets/images/option 1.png",
                      height: 190,
                    ),
                  ),
                );
              } else if (state is RequestError) {
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
    );
  }
}
