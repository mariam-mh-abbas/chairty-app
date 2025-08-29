import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/view/before_help_request.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/donation_categories_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/my_list_page.dart';

import 'package:charity_project/view/request_help_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;

class MainNavbarPage extends StatefulWidget {
  const MainNavbarPage({super.key});

  @override
  State<MainNavbarPage> createState() => _MainNavbarPageState();
}

class _MainNavbarPageState extends State<MainNavbarPage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    HomaPage(),
    DonationCategoriesPage(),
    CharityFundPage(),
    BeforeHelpRequest(),
    MyListPage()
  ];
  @override
  void initState() {
    super.initState();
    _loadCartAfterRestart();
  }

  void _loadCartAfterRestart() async {
    // final userId = await SharedPrefs.getPhone();
     final userId  = await SharedPrefs.getUserId();
     final String useridstring = userId.toString();
    final token = await SharedPrefs.getToken();
    if (useridstring != null && useridstring.isNotEmpty && token !=null ) {
      context.read<BlocCartBloc>().add(LoadCart(useridstring));
    }
    else{
       context.read<BlocCartBloc>().add(ClearCart());
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCartBloc, BlocCartState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
              backgroundColor: AppColors.white,
              animationDuration: Duration(seconds: 4),
              shadowColor: Colors.grey,
              selectedIndex: selectedIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorColor: Colors.transparent,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: AppColors.secondary,
                    ),
                    selectedIcon: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: AppColors.primary,
                    ),
                    label: 'Home'.tr()),
                NavigationDestination(
                  icon: Image.asset('assets/images/donaition1.png',
                      height: 35, width: 35, color: AppColors.secondary),
                  label: 'Donaition Categories'.tr(),
                  selectedIcon: Image.asset('assets/images/donaition1.png',
                      height: 35, width: 35, color: AppColors.primary),
                ),
                NavigationDestination(
                    icon: badges.Badge(
                      showBadge: context.read<BlocCartBloc>().cartItems.length > 0,
               badgeContent: Text("${context.read<BlocCartBloc>().cartItems.length}",style: TextStyle(color: AppColors.white,fontSize: 10),),
               position: badges.BadgePosition.topEnd(top: -8, end: -8),
                      child: Image.asset(
                        'assets/images/fund.png',
                        height: 30,
                        width: 30,
                        color: AppColors.secondary,
                      ),
                    ),
                    selectedIcon: badges.Badge(
                       showBadge: context.read<BlocCartBloc>().cartItems.length > 0,
               badgeContent: Text("${context.read<BlocCartBloc>().cartItems.length}",style: TextStyle(color: AppColors.white,fontSize: 10),),
               position: badges.BadgePosition.topEnd(top: -8, end: -8),
                      child: Image.asset('assets/images/fund.png',
                          height: 30, width: 30, color: AppColors.primary),
                    ),
                    label: 'Goodness Box'.tr()),
                NavigationDestination(
                    icon: Image.asset('assets/images/help.png',
                        height: 40, width: 40, color: AppColors.secondary),
                    selectedIcon: Image.asset('assets/images/help.png',
                        height: 40, width: 40, color: AppColors.primary),
                    label: 'Help Request'.tr()),
                NavigationDestination(
                    icon: Icon(
                      Icons.format_list_bulleted,
                      color: AppColors.secondary,
                    ),
                    selectedIcon: Icon(
                      Icons.format_list_bulleted,
                      color: AppColors.primary,
                    ),
                    label: 'My List'.tr())
              ]),
          body: pages[selectedIndex],
        );
      },
    );
  }
}

