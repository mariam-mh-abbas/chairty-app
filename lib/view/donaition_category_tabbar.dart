// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/AllSponsorships/bloc/all_sponsorships_bloc_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
// import 'package:charity_project/blocForApp/blocCategoryByMainCategory/bloc/categorybymaincategory_bloc.dart';
// import 'package:charity_project/blocForApp/blocHumanCaseByCategory/bloc/humancase_by_category_bloc.dart';
// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/donaition_category_view_page.dart';
// import 'package:charity_project/view/donate_campaigns_page.dart';
// import 'package:charity_project/view/donation_categories_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DonaitionCategoryTabbar extends StatefulWidget {
//   final String category;
// final String title;
//   const DonaitionCategoryTabbar({super.key, required this.category,required this.title});

//   @override
//   State<DonaitionCategoryTabbar> createState() => _CampaignsPageState();
// }

// class _CampaignsPageState extends State<DonaitionCategoryTabbar> {
//   late List<Map<String, String>> campaignCategories;
// Future<void> refreshData( BuildContext context)async{
//   context.read<CategorybymaincategoryBloc>()..add(FetchCategoryByMainCategory(widget.category));

//  await Future.delayed(Duration(seconds: 1));
// }
//   @override
//   void initState() {
//     super.initState();

//     // campaignCategories = Donaition.firstWhere(
//     //         (element) => element['category'] == widget.category)['tabs']
//     //     .cast<Map<String, String>>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<CategorybymaincategoryBloc>(
//           create: (context) => CategorybymaincategoryBloc()
//             ..add(FetchCategoryByMainCategory(widget.category)),
//         ),
//       ],
//       child: BlocBuilder<CategorybymaincategoryBloc, CategorybymaincategoryState>(
//         builder: (context, state) {
//           if (state is CategorybymaincategoryLoading) {
//             return DefaultTabController( length: 4,
//               child: Scaffold( appBar: AppBar(

//               ),
//                 backgroundColor: AppColors.background,
//                 body: BackgroundWrapper(child: Center(child: CircularProgressIndicator(color: AppColors.primary,),)),
//               ),
//             );

//           }
//           else if (state is CategorybymaincategoryError){
//             return Center(child: Text(state.ErrorMsg),);
//           }
//           else if (state is CategorybymaincategoryLoaded){
// return DefaultTabController(
//             length: state.categorybymaincategory.length,
//             child: Scaffold(
//               backgroundColor: AppColors.background,
//               appBar: AppBar(
//                 backgroundColor: AppColors.white,
//                 title: Text(widget.title.tr(), style: AppTextStyle.a),
//                 bottom: TabBar(
//                   dividerColor: AppColors.primary,
//                   indicatorColor: AppColors.primary,
//                   unselectedLabelColor: AppColors.unselected,
//                   labelColor: AppColors.primary,
//                   isScrollable: true,
//                   tabs: state.categorybymaincategory
//                       .map((cat) => Tab(text: cat.name))
//                       .toList(),
//                 ),
//               ),
//               body: BackgroundWrapper(
//                 child: RefreshIndicator(
//                   onRefresh: () => refreshData(context),
//                   color: AppColors.primary,
//                   child: TabBarView(
//                     children: state.categorybymaincategory
//                         .asMap()
//                         .entries
//                         .map((entry) {
//                           final index = entry.key;
//                           final cat = entry.value;
//                           return DonaitionCategoryViewPage(
//                             Category: widget.category,
//                             categoryId: cat.id,
//                           );
//                         }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//           );
//           }
//           return Text("data");
//         },
//       ),
//     );
//   }
// }

import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCategoryByMainCategory/bloc/categorybymaincategory_bloc.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonaitionCategoryTabbar extends StatefulWidget {
  final String category;
  final String title;

  const DonaitionCategoryTabbar({
    super.key,
    required this.category,
    required this.title,
  });

  @override
  State<DonaitionCategoryTabbar> createState() =>
      _DonaitionCategoryTabbarState();
}

class _DonaitionCategoryTabbarState extends State<DonaitionCategoryTabbar> {
  Future<void> refreshData(BuildContext context) async {
    context.read<CategorybymaincategoryBloc>()
      ..add(FetchCategoryByMainCategory(widget.category));
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategorybymaincategoryBloc>(
          create: (context) => CategorybymaincategoryBloc()
            ..add(FetchCategoryByMainCategory(widget.category)),
        ),
      ],
      child: BlocBuilder<CategorybymaincategoryBloc, CategorybymaincategoryState>(
        builder: (context, state) {
          if (state is CategorybymaincategoryLoading) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          } else if (state is CategorybymaincategoryError) {
            return Center(child: Text(state.ErrorMsg));
          } else if (state is CategorybymaincategoryLoaded) {

            final tabs = [
              {"id": 0, "name": "All".tr()},
              ...state.categorybymaincategory.map((cat) => {
                    "id": cat.id,
                    "name": cat.name ?? "Unknown",
                  }),
            ];

            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  title: Text(widget.title.tr(), style: AppTextStyle.a),
                  bottom: TabBar(
                    dividerColor: AppColors.primary,
                    indicatorColor: AppColors.primary,
                    unselectedLabelColor: AppColors.unselected,
                    labelColor: AppColors.primary,
                    isScrollable: true,
                    tabs: tabs.map((tab) => Tab(text: tab["name"].toString())).toList(),
                  ),
                ),
                body: BackgroundWrapper(
                  child: RefreshIndicator(
                    onRefresh: () => refreshData(context),
                    color: AppColors.primary,
                    child: TabBarView(
                      children: tabs.map((tab) {
                        final id = tab["id"] as int;
                        return DonaitionCategoryViewPage(
                          Category: widget.category,
                          categoryId: id,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
