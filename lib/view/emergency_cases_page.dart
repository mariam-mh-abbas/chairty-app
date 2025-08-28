import 'package:charity_project/blocForApp/blocEmergencyHumanCases/bloc/bloc_emergency_human_cases_bloc.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:flutter/material.dart';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donaition_category_view_page.dart';
import 'package:charity_project/view/one_HumanitarianCases_view_page.dart';
import 'package:charity_project/view/one_campaign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EmergencyCasesPage extends StatelessWidget {
  const EmergencyCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocEmergencyHumanCasesBloc,
        BlocEmergencyHumanCasesState>(
      builder: (context, state) {
        if (state is BlocEmergencyHumanCasesLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: AppColors.primary,
          ));
        } else if (state is BlocEmergencyHumanCasesError) {
          return Center(
            child: Text(state.ErrorMsg),
          );
        } else if (state is BlocEmergencyHumanCasesLoaded) {
          return ListView.builder(
            itemCount: state.Emergencyhumancases.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final String? imageUrl = state.Emergencyhumancases[index].image!;
              final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
                  ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
                  : null;
              final collected =
                  state.Emergencyhumancases[index].collectedAmount ?? 0;
              final goal = state.Emergencyhumancases[index].goalAmount ?? 0;
              int calculateDonationPercentage(
                  int collectedAmount, int goalAmount) {
                if (goalAmount <= 0) return 0;
                int percent = ((collectedAmount / goalAmount) * 100).round();
                return percent.clamp(0, 100);
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OneHumanitariancasesViewPage(
                              id: state.Emergencyhumancases[index].id ?? 0),
                        ));
                  },
                  child: Container(
                    height: 180,
                    width: 180,
                    child: Card(
                      elevation: 10,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: finalImage != null
                                    ? DecorationImage(
                                        image: NetworkImage(finalImage),
                                        fit: BoxFit.cover)
                                    : DecorationImage(
                                        image: AssetImage(
                                            "assets/images/general.png"),
                                        fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, left: 6, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textmax(
                                      state.Emergencyhumancases[index].title ??
                                          "Unknown",
                                      20),
                                  style: AppTextStyle.emergency,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            "${calculateDonationPercentage(collected, goal)}%",
                                            style: AppTextStyle.c,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: LinearPercentIndicator(
                                        maskFilter:
                                            MaskFilter.blur(BlurStyle.solid, 3),
                                        linearGradient: LinearGradient(colors: [
                                          AppColors.primary,
                                          AppColors.teal,
                                        ]),
                                        barRadius: Radius.circular(10),
                                        curve: Curves.easeInOut,
                                        clipLinearGradient: true,
                                        lineHeight: 10,
                                        percent:
                                            goal > 0 ? (collected / goal) : 0.0,
                                        animation: true,
                                        animationDuration: 1000,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, left: 10, right: 10),
                                      child: Text(
                                        "\$${collected} / \$${goal}",
                                        style: AppTextStyle.c,
                                      ),
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
            },
          );
        }
        return Text("data");
      },
    );
    ;
  }
}

String textmax(String text, int maxlength) {
  if (text.length > maxlength) {
    return text.substring(0, maxlength) + "....";
  }
  return text;
}
