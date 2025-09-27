import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocEmergencyHumanCases/bloc/bloc_emergency_human_cases_bloc.dart';
import 'package:charity_project/blocForApp/blocHomeCampaign/bloc/campaign_home_bloc.dart';
import 'package:charity_project/blocs/notification_bloc/bloc/notification_bloc.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/services/notification_service.dart';
import 'package:charity_project/view/ArchivedTabbarPage.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/before_gift.dart';
import 'package:charity_project/view/before_inKind_donaition.dart';
import 'package:charity_project/view/before_volunteer_page.dart';
import 'package:charity_project/view/campaign_view_page.dart';
import 'package:charity_project/view/d.dart';
import 'package:charity_project/view/donaition_category_tabbar.dart';
import 'package:charity_project/view/emergency_cases_page.dart';
import 'package:charity_project/view/notification_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:charity_project/view/pay.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:charity_project/view/periodically_donaition.dart';
import 'package:charity_project/view/sadakah_page.dart';
import 'package:charity_project/view/squares_page.dart';
import 'package:charity_project/view/zakah_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final String baseUrlImage = "$baseUrl/storage/";

class HomaPage extends StatelessWidget {
  const HomaPage({super.key});
  Future<void> refreshData(BuildContext context) async {
    context.read<CampaignHomeBloc>().add(FetchedCampaign());

    context.read<BlocEmergencyHumanCasesBloc>().add(FetchEmergencyHumanCases());

    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CampaignHomeBloc>(
          create: (context) => CampaignHomeBloc()..add(FetchedCampaign()),
        ),
        BlocProvider<BlocEmergencyHumanCasesBloc>(
          create: (context) =>
              BlocEmergencyHumanCasesBloc()..add(FetchEmergencyHumanCases()),
        ),
        // BlocProvider(
        //   create: (_) => NotificationBloc(NotificationService()),
        //   child: Builder(
        //     builder: (context) {
        //       // هنا الـ NotificationBloc موجود، فينا نضيف الأحداث
        //       context.read<NotificationBloc>().add(GetNotificationEvent());
        //       final state = context.read<NotificationBloc>().state;
        //       if (state is NotificationBadgeState) {
        //         context.read<NotificationBloc>().add(
        //               UpdateLastSeenNotifications(state.currentCount),
        //             );
        //       }

        //       return HomaPage(); // أو أي صفحة تريد
        //     },
        //   ),
        // )
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        //  const Color.fromARGB(255, 246, 240, 232),
        //  const Color.fromARGB(255, 249, 247, 243),
        appBar:
            // AppBar(
            //   title: Text(
            //     'Kun Auna'.tr(),
            //     style: TextStyle(
            //       color: AppColors.primary,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            //   backgroundColor: AppColors.white,
            //   elevation: 0,
            //   actions: [
            //     BlocBuilder<NotificationBloc, NotificationState>(
            //       builder: (context, state) {
            //         print(state);
            //         int badgeCount = 0;
            //         int currentCount = 0;

            //         if (state is NotificationBadgeState) {
            //           badgeCount = state.badgeCount;
            //           currentCount = state.currentCount;
            //         }

            //         return Stack(
            //           clipBehavior: Clip.none,
            //           children: [
            //             IconButton(
            //               onPressed: () {
            //                 if (state is NotificationBadgeState) {
            //                   context.read<NotificationBloc>().add(
            //                         UpdateLastSeenNotifications(currentCount),
            //                       );
            //                 }

            //                 context
            //                     .read<NotificationBloc>()
            //                     .add(GetNotificationEvent());

            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (_) => notification_page()),
            //                 ).then((_) {
            //                   if (state is NotificationBadgeState) {
            //                     context.read<NotificationBloc>().add(
            //                           UpdateLastSeenNotifications(currentCount),
            //                         );
            //                   }
            //                 });
            //               },
            //               icon: Icon(
            //                 Icons.notifications,
            //                 color: AppColors.secondary,
            //                 size: 30,
            //               ),
            //             ),
            //             if (badgeCount > 0)
            //               Positioned(
            //                 right: 4,
            //                 top: 4,
            //                 child: Container(
            //                   padding: EdgeInsets.all(4),
            //                   decoration: BoxDecoration(
            //                     color: Colors.red,
            //                     shape: BoxShape.circle,
            //                   ),
            //                   constraints:
            //                       BoxConstraints(minWidth: 18, minHeight: 18),
            //                   child: Center(
            //                     child: Text(
            //                       badgeCount.toString(),
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 12,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //           ],
            //         );
            //       },
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10, left: 10),
            //       child: InkWell(
            //         child: Image.asset(
            //           "assets/images/logo2.png",
            //           height: 70,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            AppBar(
          title: Text(
            'Kun Auna'.tr(),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0, // يلغي الظل إذا ما بدك يبين
          actions: [
            IconButton(
              onPressed: () {
                context.read<NotificationBloc>().add(GetNotificationEvent());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notification_page()),
                );
              },
              icon: Icon(
                Icons.notifications,
                color: AppColors.secondary,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: InkWell(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => PaymentMethodsUI()),
                //   );
                // },
                child: Image.asset(
                  "assets/images/logo2.png",
                  height: 70,
                ),
              ),
            ),
          ],
        ),
        body: BackgroundWrapper(
          child: RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => refreshData(context),
            child: SizedBox(
              // height: 700,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 130,
                      width: 600,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: MyWidget(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    'assets/images/background.jpg',
                    //  'assets/images/1231.jpg',
                    // 'assets/images/fgg.jpg',
                    // 'assets/images/1212.png',
                    height: 220,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ongoing Campaigns'.tr(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DonaitionCategoryTabbar(
                                            category: "Campaign",
                                            title: "Campaigns")));
                          },
                          child: Text(
                            'More'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.unselected),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CampaignHomeBloc, CampaignHomeState>(
                    builder: (context, state) {
                      if (state is CampaignHomeLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ));
                      } else if (state is CampaignHomeError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Internet connection is not available".tr(),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );

                        // return Center(
                        //   child: Text(state.ErrorMsg),
                        // );
                      } else if (state is CampaignHomeLoaded) {
                        return SizedBox(
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  height: 190,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.6,
                                  autoPlay: true),
                              items: List.generate(state.Campaigns.length,
                                  (index) {
                                final String? imageUrl =
                                    state.Campaigns[index].image;
                                final String? finalImage =
                                    imageUrl != null && imageUrl.isNotEmpty
                                        ? Uri.parse(baseUrlImage)
                                            .resolve(imageUrl)
                                            .toString()
                                        : null;
                                return Builder(builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OneCampaignPage(
                                                      id: state.Campaigns[index]
                                                          .id!)));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height: 50,
                                      width: 200,
                                      child: Card(
                                        elevation: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: finalImage != null
                                                ? DecorationImage(
                                                    image: NetworkImage(
                                                        finalImage
                                                        //  "$baseUrlImage${state.Campaigns[index].image!}"
                                                        ),
                                                    fit: BoxFit.cover)
                                                : DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/general.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                child: Container(
                                                  height: 200,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                          colors: [
                                                            AppColors.primary
                                                                .withOpacity(
                                                                    0.9),
                                                            Colors.transparent
                                                          ])),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 2,
                                                left: 8,
                                                right: 8,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    state.Campaigns[index]
                                                            .title ??
                                                        "",
                                                    style: TextStyle(
                                                        color: AppColors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              }),
                            ),
                          ),
                        );
                      }
                      return Text("");
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Emergency Cases'.tr(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DonaitionCategoryTabbar(
                                            category: "HumanCase",
                                            title: "HumanitarianCases")));
                          },
                          child: Text(
                            'More'.tr(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.unselected),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: EmergencyCasesPage()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Text(
                      'Services'.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 30),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 160,
                                height: 140,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BeforeGift()));
                                  },
                                  child: Card(
                                    elevation: 10,
                                    color: Color(0xffeaf8f9),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/giftt.png',
                                          height: 90,
                                          width: 90,
                                          color: AppColors.teal,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('Gift'.tr(),
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 160,
                                height: 140,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BeforeInkindDonaition()));
                                  },
                                  child: Card(
                                    elevation: 10,
                                    color: Color(0xffeaf8f9),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Image.asset(
                                              'assets/images/l.png',
                                              height: 80,
                                              width: 80,
                                              color:
                                                  // AppColors.teal)
                                                  const Color.fromARGB(
                                                      255, 219, 90, 163)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('In-kind Donations'.tr(),
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
