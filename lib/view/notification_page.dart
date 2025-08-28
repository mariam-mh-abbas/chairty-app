import 'package:charity_project/app_colors.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class notification_page extends StatelessWidget {
  const notification_page({super.key});

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
              'Notifications'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
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
                            padding: const EdgeInsets.all(15),
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
                                child: Image.asset(
                                  'assets/images/logoo.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'notification',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Text(
                                'notification',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    //  DateFormat('d/M/yyyy', 'en').format(
                                    //     '22/2/2025'),

                                    '22/2/2025',
                                    style: TextStyle(
                                        color: AppColors.unselected,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
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
          ))
        ],
      )),
    );
  }
}
