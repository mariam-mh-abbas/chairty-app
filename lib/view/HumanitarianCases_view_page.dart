import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
import 'package:charity_project/blocForApp/blocHumanCaseByCategory/bloc/humancase_by_category_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/service/AllHumanCasesServices.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/emergency_cases_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/one_HumanitarianCases_view_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HumanitariancasesViewPage extends StatefulWidget {
  const HumanitariancasesViewPage(
      {super.key, required this.Category, required this.categoryId});
  final String Category;
  final int categoryId;
  @override
  State<HumanitariancasesViewPage> createState() =>
      _HumanitariancasesViewPageState();
}

class _HumanitariancasesViewPageState extends State<HumanitariancasesViewPage> {
  Future<void> refreshData( BuildContext context)async{
  context.read<AllHumanCasesBloc>()..add(FetchAllHumanCases());
  
   context.read<HumancaseByCategoryBloc>()..add(FetchHumancaseByCategoryEvent(widget.categoryId));
  
 await Future.delayed(Duration(seconds: 1));
} 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
            BlocProvider(
          create: (context) => AllHumanCasesBloc()..add(FetchAllHumanCases()),
    
        ),
            BlocProvider(
                create: (context) => HumancaseByCategoryBloc()..add(FetchHumancaseByCategoryEvent(widget.categoryId)),
            ),
        ],
              child: Scaffold(
            backgroundColor: AppColors.background,
            body: RefreshIndicator(
              onRefresh: () => refreshData(context),
              child: BackgroundWrapper(
                child: widget.categoryId == 0
                ? BlocBuilder<AllHumanCasesBloc, AllHumanCasesState>(
                  builder: (context, state) {
                    if (state is AllHumanCasesLoading) {
                     return Center(child: CircularProgressIndicator(color: AppColors.primary,));
                     
                    }
                    else if (state is AllHumanCasesError){
                      return Center(child: Text(state.ErrorMsg),);
                    
                    }
                    else if (state is AllHumanCasesLoaded)
                    {
                      if (state.humanCasemodel.isEmpty) {
                        return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("There is no HumanitarianCases yet",style: AppTextStyle.b,),
                          Image.asset("assets/images/option 1.png",height: 190,)
                        ],
                      ),
                    );
                      } else {
                        return Expanded(
                    child: ListView.builder(
                        itemCount: state.humanCasemodel.length,
                        itemBuilder: (context, index) {
                           final String? imageUrl=state.humanCasemodel[index].image;
                          final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;
                                 final collected = state.humanCasemodel[index].collectedAmount ?? 0;
                            final goal =state.humanCasemodel[index].goalAmount ?? 0;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              child: Card(
                                elevation: 10,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20, right: 20),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image:finalImage != null
                                 ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                                 : DecorationImage(image: AssetImage("assets/images/general.png"),fit: BoxFit.cover)
                                                ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(textmax(state.humanCasemodel[index].title ?? "unknown", 25)
                                            ,
                                            style: AppTextStyle.b,
                                          ),
                                          SizedBox(
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                state.humanCasemodel[index].description ?? "",
                                                style: AppTextStyle.c,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: LinearPercentIndicator(
                                                  maskFilter: MaskFilter.blur(
                                                      BlurStyle.solid, 3),
                                                  linearGradient: LinearGradient(
                                                      colors: [
                                                        AppColors.primary,
                                                        AppColors.teal
                                                      ]),
                                                  barRadius: Radius.circular(10),
                                                  curve: Curves.easeInOut,
                                                  clipLinearGradient: true,
                                                  lineHeight: 10,
                                                  
                                                  percent: goal > 0 ? (collected/goal) : 0.0,
                                                  animation: true,
                                                  animationDuration: 1000,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "\$ ${ state.humanCasemodel[index].collectedAmount} / \$ ${state.humanCasemodel[index].goalAmount}",
                                                        style: AppTextStyle.c)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 90, top: 5),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OneHumanitariancasesViewPage(id: state.humanCasemodel[index].id ?? 0,
                  
                                                )));
                                              },
                                              child: Text("Details".tr()),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.secondary,
                                                  foregroundColor: AppColors.white,
                                                  fixedSize: Size(100, 30)),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                      }
                    
                    }
                    else{
                      return Text("failed");
                    }
                  },
                )
                 :  BlocBuilder<HumancaseByCategoryBloc, HumancaseByCategoryState>(
                  builder: (context, state) {
                    if (state is HumancaseByCategoryLoading) {
                     return Center(child: CircularProgressIndicator(color: AppColors.primary,));
                     
                    }
                    else if (state is HumancaseByCategoryError){
                      return Center(child: Text(state.ErrorMsg),);
                    
                    }
                    else if (state is HumancaseByCategoryLoaded)
                    {
                      if (state.humancasebycategory.isEmpty) {
                        return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("There is no HumanitarianCases yet".tr(),style: AppTextStyle.b,),
                          Image.asset("assets/images/option 1.png",height: 190,)
                        ],
                      ),
                    );
                      } else {
                        return Expanded(
                    child: ListView.builder(
                        itemCount: state.humancasebycategory.length,
                        itemBuilder: (context, index) {
                           final String? imageUrl=state.humancasebycategory[index].image;
                            final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;
                                 final collected = state.humancasebycategory[index].collectedAmount!;
                            final goal =state.humancasebycategory[index].goalAmount!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              child: Card(
                                elevation: 10,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20, right: 20),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: finalImage != null
                                 ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                                 : DecorationImage(image: AssetImage("assets/images/general.png"),fit: BoxFit.cover)
                                                ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(textmax(state.humancasebycategory[index].title ?? "unknown", 25)
                                            ,
                                            style: AppTextStyle.b,
                                          ),
                                          SizedBox(
                                              height: 50,
                                              width: 200,
                                              child: Text(
                                                state.humancasebycategory[index].description ?? "",
                                                style: AppTextStyle.c,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: LinearPercentIndicator(
                                                  maskFilter: MaskFilter.blur(
                                                      BlurStyle.solid, 3),
                                                  linearGradient: LinearGradient(
                                                      colors: [
                                                        AppColors.primary,
                                                        AppColors.teal
                                                      ]),
                                                  barRadius: Radius.circular(10),
                                                  curve: Curves.easeInOut,
                                                  clipLinearGradient: true,
                                                  lineHeight: 10,
                                                  
                                                  percent: goal > 0 ? (collected/goal) : 0.0,
                                                  animation: true,
                                                  animationDuration: 1000,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "\$ ${ state.humancasebycategory[index].collectedAmount!} / \$ ${state.humancasebycategory[index].goalAmount!}",
                                                        style: AppTextStyle.c)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 90, top: 5),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OneHumanitariancasesViewPage(id: state.humancasebycategory[index].id ?? 0,
                  
                                                )));
                                              },
                                              child:  Text("Details").tr(),
                                    style:ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.secondary,
                                      foregroundColor: AppColors.white,
                                      fixedSize: Size(100, 30)
                                    )
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                      }
                    
                    }
                    else{
                      return Text("failed");
                    }
                  },
                 )
              ),
            ),
          ),
    );
  }
}
