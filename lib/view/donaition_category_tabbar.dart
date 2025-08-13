import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCategoryByMainCategory/bloc/categorybymaincategory_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/donation_categories_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonaitionCategoryTabbar extends StatefulWidget {
  final String category;
final String title;
  const DonaitionCategoryTabbar({super.key, required this.category,required this.title});

  @override
  State<DonaitionCategoryTabbar> createState() => _CampaignsPageState();
}

class _CampaignsPageState extends State<DonaitionCategoryTabbar> {
  late List<Map<String, String>> campaignCategories;

  @override
  void initState() {
    super.initState();

    // campaignCategories = Donaition.firstWhere(
    //         (element) => element['category'] == widget.category)['tabs']
    //     .cast<Map<String, String>>();
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
            return DefaultTabController( length: 4,
              child: Scaffold( appBar: AppBar(

              ),
                backgroundColor: AppColors.background,
                body: BackgroundWrapper(child: Center(child: CircularProgressIndicator(color: AppColors.primary,),)),
              ),
            );

          }
          else if (state is CategorybymaincategoryError){
            return Center(child: Text(state.ErrorMsg),);
          }
          else if (state is CategorybymaincategoryLoaded){
return DefaultTabController(
            length: state.categorybymaincategory.length,
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
                  tabs: state.categorybymaincategory
                      .map((cat) => Tab(text: cat.name))
                      .toList(),
                ),
              ),
              body: BackgroundWrapper(
                child: TabBarView(
  children: state.categorybymaincategory
      .asMap()
      .entries
      .map((entry) {
        final index = entry.key;
        final cat = entry.value;
        return DonaitionCategoryViewPage(
          Category: widget.category,
          categoryId: cat.id,
        );
      }).toList(),
),
              ),
            ),
          );
          }
          return Text("data");
        },
      ),
    );
  }
}
