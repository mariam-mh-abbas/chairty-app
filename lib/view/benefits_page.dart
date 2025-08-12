import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/background.dart';
import 'package:flutter/material.dart';

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
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 2, color: AppColors.primary)),
                                  child: Image.asset(
                                    'assets/images/q.png',
                                    color: AppColors.secondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mariam Abbas',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'campaign' + ' / ' + 'health',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'rebuilding destroyed homes',
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
                                            '5/7/2025',
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
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
