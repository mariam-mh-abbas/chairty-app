import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/gift_bloc/bloc/gift_bloc.dart';
import 'package:charity_project/blocs/recharge_bloc/bloc/recharge_bloc.dart';
import 'package:charity_project/blocs/sponsorships_bloc/bloc/sponsorships_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/gift_service.dart';
import 'package:charity_project/view/Donations_page.dart';
import 'package:charity_project/view/Sponsorships_page.dart';
import 'package:charity_project/view/benefits_page.dart';
import 'package:charity_project/view/gifts_page.dart';
import 'package:charity_project/view/receipts_page.dart';
import 'package:charity_project/view/reports_page.dart';
import 'package:charity_project/view/requests_page.dart';
import 'package:charity_project/view/volunteering_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityExpandable extends StatefulWidget {
  const ActivityExpandable({super.key});

  @override
  State<ActivityExpandable> createState() => _ActivityExpandableState();
}

class _ActivityExpandableState extends State<ActivityExpandable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Icon(
                  Icons.diversity_1,
                  color: AppColors.primary,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Activity'.tr(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: AppColors.unselected,
                  size: 25,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => donations_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My donations'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => donations_page()));
                //   },
                //   child: Text(
                //     'Donations',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<SponsorshipsBloc>().add(
                          GetSponsorshipEvent(),
                        );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sponsorships_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My sponsorships'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => sponsorships_page()));
                //   },
                //   child: Text(
                //     'Sponsorships',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => requests_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My requests'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => requests_page()));
                //   },
                //   child: Text(
                //     'Requests',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => voluntering_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My volunteers'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => volunterring_page()));
                //   },
                //   child: Text(
                //     'Volunteering',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => benefits_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My benefits'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => benefits_page()));
                //   },
                //   child: Text(
                //     'Benefits',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BlocProvider(
                    //       create: (context) =>
                    //           GiftBloc(GiftService())..add(GetGiftEvent()),
                    //       child: gifts_page(),
                    //     ),
                    //   ),
                    // );
                    context.read<GiftBloc>().add(
                          GetGiftEvent(),
                        );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => gifts_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My gifts'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => gifts_page()));
                //   },
                //   child: Text(
                //     'Gifts',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reports_Page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My reports'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => Reports_Page()));
                //   },
                //   child: Text(
                //     'Reports',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<RechargeBloc>().add(
                          GetRechargeEvent(),
                        );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => receipts_page()));
                  },
                  child: SizedBox(
                    height: 25,
                    width: 270,
                    child: Text(
                      'My recharges'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => receipts_page()));
                //   },
                //   child: Text(
                //     'Receipts',
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black),
                //   ),
                // )
              ],
            ),
          ),
      ],
    );
  }
}
