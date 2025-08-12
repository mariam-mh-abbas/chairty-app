import 'dart:io';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:charity_project/services/pdf_service.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfUrl;

  PdfViewerPage({required this.pdfUrl, super.key});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late final dynamic _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final bytes = await fetchPdfBytes(widget.pdfUrl);
      final document = PdfDocument.openData(bytes);
      if (Platform.isWindows) {
        _controller = PdfController(
          document: document,
        );
      } else {
        _controller = PdfControllerPinch(
          document: document,
        );
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
            child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.unselected,
              // title: Text(
              //   'Receipt',
              //   style: TextStyle(
              //       color: AppColors.primary, fontWeight: FontWeight.w700),
              // ),
            ),
            SizedBox(
              height: 250,
            ),
            CircularProgressIndicator()
          ],
        )),
      );
    }
    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
            child: Column(
          children: [
            AppBar(
              backgroundColor: AppColors.white,
              elevation: 2,
              shadowColor: AppColors.unselected,
              // title: Text(
              //   'Receipt',
              //   style: TextStyle(
              //       color: AppColors.primary, fontWeight: FontWeight.w700),
              // ),
            ),
            SizedBox(
              height: 250,
            ),
            Text('Error loading PDF'.tr())
          ],
        )),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Column(
        children: [
          AppBar(
            backgroundColor: AppColors.white,
            elevation: 2,
            shadowColor: AppColors.unselected,
            // title: Text(
            //   'Receipt',
            //   style: TextStyle(
            //       color: AppColors.primary, fontWeight: FontWeight.w700),
            // ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Platform.isWindows
                ? PdfView(controller: _controller as PdfController)
                : PdfViewPinch(controller: _controller as PdfControllerPinch),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
