import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/donation_bloc/bloc/donation_bloc.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/in_kind_donations.dart';
import 'package:charity_project/view/periodically_donations.dart';
import 'package:charity_project/view/regular_donations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class donations_page extends StatefulWidget {
  const donations_page({super.key});

  @override
  State<donations_page> createState() => _donations_pageState();
}

class _donations_pageState extends State<donations_page>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final bloc = context.read<DonationBloc>();
      if (_tabController.index == 0) {
      } else if (_tabController.index == 1) {
        bloc.add(DonationInKindEvent());
      } else if (_tabController.index == 2) {
        bloc.add(DonationPeriodicallyEvent());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            // elevation: 2,
            // shadowColor: AppColors.unselected,
            title: Text(
              'My donations'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            color: AppColors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.unselected,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: 'regular'.tr()),
                Tab(text: 'in-kind'.tr()),
                Tab(text: 'periodically'.tr()),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Regular_Donations(),
                in_kind_Donations(),
                periodically_Donations(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
