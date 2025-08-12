import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/request_bloc/bloc/request_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/request_service.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/request_help.dart';
import 'package:charity_project/view/request_voluntering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class requests_page extends StatefulWidget {
  const requests_page({super.key});

  @override
  State<requests_page> createState() => _requests_pageState();
}

class _requests_pageState extends State<requests_page>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final bloc = context.read<RequestBloc>();
      if (_tabController.index == 0) {
        bloc.add(HelpRequestEvent());
      } else if (_tabController.index == 1) {
        bloc.add(VolunteerRequestEvent());
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
    return Builder(builder: (context) {
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
                'My requests'.tr(),
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
                  Tab(text: 'help'.tr()),
                  Tab(text: 'volunteering'.tr()),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Request_Help(),
                  Request_Voluntering(),
                ],
              ),
            ),
          ],
        )),
      );
    });
  }
}
