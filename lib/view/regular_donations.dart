import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/background.dart';
import 'package:flutter/material.dart';

class Regular_Donations extends StatefulWidget {
  const Regular_Donations({super.key});

  @override
  State<Regular_Donations> createState() => _Request_VolunteringState();
}

class _Request_VolunteringState extends State<Regular_Donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Container(
                      height: 140,
                      width: 200,
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
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                              AssetImage("assets/images/d.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clean Water Project',
                                    style: TextStyle(
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/images/as.png",
                                        height: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '150 ' + '\$',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              SizedBox(
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {},
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
