// import 'dart:math';

// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/homa_page.dart';
// import 'package:charity_project/view/one_Sponsorships_page.dart';
// import 'package:charity_project/view/one_kaffarat_and_sadaqah_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class KaffaratAndSadaqahView extends StatefulWidget {
//   const KaffaratAndSadaqahView({super.key, required this.Type});
//   final String Type;
//   @override
//   State<KaffaratAndSadaqahView> createState() => _KaffaratAndSadaqahViewState();
// }

// class _KaffaratAndSadaqahViewState extends State<KaffaratAndSadaqahView> {
//   @override
//   Widget build(BuildContext context) {
   
//     return BlocProvider(
//       create: (context) => BoxBloc()..add(FetchBoxData(widget.Type)),
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           title: Text(
//             "Kaffarat and Sadaqah".tr(),
//             style: AppTextStyle.a,
//           ),
//         ),
//         body: BackgroundWrapper(child: BlocBuilder<BoxBloc, BoxState>(
//           builder: (context, state) {
//             if (state is BoxLoading) {
//               return Center(child: CircularProgressIndicator(color: AppColors.primary,),);

//             }
//             else if (state is BoxError){
//               return Center(child: Text(state.ErrorMsg),);
//             }
//             else if(state is BoxLoaded){

// return Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: state.box.children.length,
//                       itemBuilder: (context, index) {
//                          final String imageUrl=state.box.children[index].image!;
//                           final String finalImage =Uri.parse("$baseUrlImage").resolve(imageUrl).toString();
//                         return InkWell(
//                           onTap: () {},
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: AnimatedContainer(
//                               duration: Duration(microseconds: 10000),
//                               curve: Curves.easeInOut,
//                               height: 130,
//                               width: double.infinity,
//                               child: Card(
//                                 elevation: 10,
//                                 color: AppColors.white,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 20, right: 20),
//                                       child: Stack(children: [
//                                         Container(
//                                           height: 100,
//                                           width: 100,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               image: DecorationImage(
//                                                   image: NetworkImage(finalImage
//                                                      ),
//                                                   fit: BoxFit.cover)),
//                                         ),
//                                         Container(
//                                           height: 100,
//                                           width: 100,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 AppColors.primary
//                                                     .withOpacity(0.5),
//                                                 Colors.transparent
//                                               ],
//                                               begin: Alignment.bottomCenter,
//                                               end: Alignment.topCenter,
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Column(
//                                           children: [
//                                             SizedBox(
//                                                 height: 50,
//                                                 width: 150,
//                                                 child: Text(
//                                                  state.box.children[index].name!,
//                                                   style: TextStyle(
//                                                     color: AppColors.primary,
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 17,
//                                                   ),
//                                                 )),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 0),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Image.asset(
//                                                     "assets/images/as.png",
//                                                     height: 20,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 6,
//                                                   ),
//                                                   Text(
//                                                     "\$ ${state.box.children[index].price}",
//                                                     style: AppTextStyle.helpReq,
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 6,),
//                                      Align(
//                                               alignment: context.locale
//                                                           .languageCode ==
//                                                       "ar"
//                                                   ? Alignment.centerLeft
//                                                   : Alignment.centerRight,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(left: 10,right: 10),
//                                                 child: ElevatedButton(
//                                                   onPressed: () {
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             OneKaffaratAndSadaqahPage(
//                                                           box: state.box
//                                                               .children[index],
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor:
//                                                         AppColors.secondary,
//                                                     foregroundColor:
//                                                         AppColors.white,
//                                                     fixedSize:
//                                                         const Size(100, 30),
//                                                   ),
//                                                   child: Text("Donate".tr()),
//                                                 ),
//                                               ),
//                                             ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 )
//               ],
//             );
//             }
//             return Text("data");
//           },
//         )),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/one_kaffarat_and_sadaqah_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KaffaratAndSadaqahView extends StatefulWidget {
  const KaffaratAndSadaqahView({super.key, required this.Type});
  final String Type;
  @override
  State<KaffaratAndSadaqahView> createState() => _KaffaratAndSadaqahViewState();
}

class _KaffaratAndSadaqahViewState extends State<KaffaratAndSadaqahView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoxBloc()..add(FetchBoxData(widget.Type)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "Kaffarat and Sadaqah".tr(),
            style: AppTextStyle.a,
          ),
        ),
        body: BackgroundWrapper(
          child: BlocBuilder<BoxBloc, BoxState>(
            builder: (context, state) {
              if (state is BoxLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is BoxError) {
                return Center(child: Text(state.ErrorMsg));
              } else if (state is BoxLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.box.children.length,
                        itemBuilder: (context, index) {
                          final String? imageUrl =
                              state.box.children[index].image;
                         final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;

                          return InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: 130,
                                width: double.infinity,
                                child: Card(
                                  elevation: 10,
                                  color: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                     
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: finalImage != null
                                 ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                                 : DecorationImage(image: AssetImage("assets/images/general.png"),fit: BoxFit.cover)
                                              ),
                                            ),
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    AppColors.primary
                                                        .withOpacity(0.5),
                                                    Colors.transparent
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // التفاصيل
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                       
                                            SizedBox(
                                              width: 160,
                                              child: Text(
                                                state.box.children[index].name ?? "",
                                                // textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                ),
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            // السعر
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/as.png",
                                                  height: 20,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "\$ ${state.box.children[index].price ?? ""}",
                                                  style: AppTextStyle.helpReq,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            // زر التبرع يروح يمين أو يسار حسب اللغة
                                            Align(
                                              alignment: context.locale
                                                          .languageCode ==
                                                      "ar"
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10,right: 10),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OneKaffaratAndSadaqahPage(
                                                          box: state.box
                                                              .children[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.secondary,
                                                    foregroundColor:
                                                        AppColors.white,
                                                    fixedSize:
                                                        const Size(100, 30),
                                                  ),
                                                  child: Text("Donate".tr()),
                                                ),
                                              ),
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
                      ),
                    )
                  ],
                );
              }
              return const Text("data");
            },
          ),
        ),
      ),
    );
  }
}
