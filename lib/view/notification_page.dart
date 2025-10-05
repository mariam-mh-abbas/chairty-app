import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/notification_bloc/bloc/notification_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class notification_page extends StatelessWidget {
  const notification_page({super.key});
  Future<void> refreshData(BuildContext context) async {
    context.read<NotificationBloc>().add(GetNotificationEvent());

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
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                bool hasNotifications = false;

                if (state is NotificationSuccess &&
                    state.notifications.isNotEmpty) {
                  hasNotifications = true;
                }

                return AppBar(
                  backgroundColor: AppColors.white,
                  elevation: 2,
                  shadowColor: AppColors.unselected,
                  title: Text(
                    'Notifications'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: IconButton(
                        onPressed: hasNotifications
                            ? () {
                                context
                                    .read<NotificationBloc>()
                                    .add(DeleteAllNotifications());
                                context
                                    .read<NotificationBloc>()
                                    .add(GetNotificationEvent());
                              }
                            : null, // 🔹 تعطيل الزر
                        icon: Icon(
                          Icons.delete,
                          color: hasNotifications
                              ? AppColors.primary
                              : AppColors
                                  .unselected, // 🔹 لون رمادي عند التعطيل
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
                child: BlocConsumer<NotificationBloc, NotificationState>(
                    listener: (context, state) {
              if (state is NotificationDeleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleted successfully'.tr()),
                    backgroundColor: AppColors.primary,
                  ),
                );
              }
            }, builder: (context, state) {
              if (state is NotificationLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  // backgroundColor: AppColors.secondary,
                  color: AppColors.secondary,
                ));
              } else if (state is NotificationSuccess) {
                final notifications = state.notifications;
                int newCount = state.notifications.length;
                return Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Container(
                          height: 140,
                          width: double.infinity,
                          child: Card(
                            elevation: 3,
                            color: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 1.5,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          width: 50,
                                          height: 50,
                                          'assets/images/logo5.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      child: Text(
                                        notification.title,
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 230,
                                      child: Text(
                                        notification.body,
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
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
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          notification.createdAt.toString(),
                                          //  DateFormat('d/M/yyyy', 'en').format(
                                          //     '22/2/2025'),

                                          // DateFormat('d/M/yyyy', 'en')
                                          //     .format(notification.createdAt),
                                          style: TextStyle(
                                              color: AppColors.unselected,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<NotificationBloc>().add(
                                          DeleteNotificationById(
                                              notification.id));
                                      context
                                          .read<NotificationBloc>()
                                          .add(GetNotificationEvent());
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.primary,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (state is NotificationEmpty) {
                return Center(
                  child: Container(
                    child: Image.asset(
                      "assets/images/option 1.png",
                      height: 190,
                    ),
                  ),
                );
              } else if (state is NotificationError) {
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
            }))
          ],
        )),
      ),
    );
  }
}
