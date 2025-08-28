import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/reports_bloc/bloc/reports_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/pdf_service.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/pdf_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reports_Page extends StatelessWidget {
  const Reports_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.unselected,
            title: Text(
              'My reports'.tr(),
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: BlocBuilder<ReportsBloc, ReportsState>(
              builder: (context, state) {
                if (state is ReportsLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    // backgroundColor: AppColors.secondary,
                    color: AppColors.secondary,
                  ));
                } else if (state is ReportsSuccess) {
                  final reports = state.reports;
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: InkWell(
                              onTap: () {
                                if (report.fileUrl.isNotEmpty) {
                                  final rawPdfUrl = report.fileUrl;
                                  if (rawPdfUrl!.isNotEmpty) {
                                    final url = constructPdfUrl(rawPdfUrl!);
                                    print(
                                        'Final PDF URL: $url'); // تتأكد شو الرابط اللي عم يتبني
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            PdfViewerPage(pdfUrl: url),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Not Found'.tr())),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Not Found'.tr())),
                                  );
                                }
                              },
                              child: Container(
                                height: 125,
                                width: 200,
                                child: Card(
                                  elevation: 3,
                                  color: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    width: 2,
                                                    color: AppColors.primary)),
                                            child: Icon(
                                              Icons.text_snippet_outlined,
                                              color: AppColors.secondary,
                                              size: 34,
                                            )
                                            //  Image.asset(
                                            //   'assets/images/6.png',
                                            //   color: AppColors.secondary,
                                            // ),
                                            ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  report.campaign!.title,
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.query_builder,
                                                    color: AppColors.unselected,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    DateFormat('d/M/yyyy', 'en')
                                                        .format(
                                                            report.createdAt),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .unselected,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
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
                            ),
                          );
                        }),
                  );
                } else if (state is ReportsEmpty) {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                } else if (state is ReportsError) {
                  return Center(child: Text('${state.message}'));
                } else {
                  return Center(
                    child: Container(
                      child: Image.asset(
                        "assets/images/option 1.png",
                        height: 190,
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }
}
