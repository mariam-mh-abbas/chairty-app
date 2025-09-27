import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class help_details extends StatelessWidget {
  final int requestId;
  const help_details({super.key, required this.requestId});

  String formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.read<RequestBloc>().add(HelpRequestEvent());

                Navigator.of(context).pop();
              },
            ),
            backgroundColor: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.unselected,
            title: Text(
              'Order details'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: BlocBuilder<RequestBloc, RequestState>(
              builder: (context, state) {
                if (state is RequestLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  ));
                } else if (state is HelpRequestDetailSuccess) {
                  final detail = state.detail;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: 400,
                        child: Card(
                          elevation: 3,
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'The name:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.name.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The father name:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.fatherName.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The mother name:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.motherName.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The gender:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.gender.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The bairthday date:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      DateFormat('d/M/yyyy', 'en')
                                          .format(detail.birthDate),
                                      // formatDate(detail.birthDate).toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The marital status:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.maritalStatus.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The housing type:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.housingType.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The fixed income:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.fixedIncome.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The main category:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.mainCategory.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The sub category:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.subCategory.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Number of family members:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.numOfMembers.toString() ?? "-",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Phone number:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.phone.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Notes:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        detail.notes.toString(),
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Study qualification:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.study.toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'The job:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        detail.job.toString() ?? "-",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Order status:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      detail.status.toString(),
                                      style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Date of transmitter:'.tr(),
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      DateFormat('d/M/yyyy', 'en')
                                          .format(detail.createdAt),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is RequestError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                  return const SizedBox();
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
