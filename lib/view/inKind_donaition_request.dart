import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCategoryByMainCategory/bloc/categorybymaincategory_bloc.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/otp_inKind_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InkindDonaitionRequest extends StatefulWidget {
  const InkindDonaitionRequest({super.key});

  @override
  State<InkindDonaitionRequest> createState() => _InkindDonaitionRequestState();
}

class _InkindDonaitionRequestState extends State<InkindDonaitionRequest> {
  final formkey = GlobalKey<FormState>();
  // TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  Map<int, bool> selectedCategories = {};

  void submitForm() {
    if (formkey.currentState!.validate()) {
      bool atLeastOne =
          selectedCategories.values.any((isSelected) => isSelected);
      if (!atLeastOne) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("You have to select one of donaition kinds").tr()));
        return;
      }
      final selectedIds = selectedCategories.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      print("Selected category IDs: $selectedIds");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpInkindPage(
                    address: address.text,
                    phone: phoneNumber.text,
                    categoryIds: selectedIds,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategorybymaincategoryBloc()
        ..add(FetchCategoryByMainCategory("InKind")),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: BackgroundWrapper(
              child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: AppColors.white,
                    title: Text(
                      'In-kind Donation'.tr(),
                      style: AppTextStyle.a,
                    ),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 20),
                    child: Text(
                      'Select Donaition Kinds'.tr(),
                      style: AppTextStyle.helpReq,
                    ),
                  ),
                  BlocBuilder<CategorybymaincategoryBloc,
                      CategorybymaincategoryState>(
                    builder: (context, state) {
                      if (state is CategorybymaincategoryLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (state is CategorybymaincategoryError) {
                        return Center(
                          child: Text(state.ErrorMsg),
                        );
                      } else if (state is CategorybymaincategoryLoaded) {
                        return Column(
                          children:
                              state.categorybymaincategory.map((category) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.primary,
                                    value: selectedCategories[category.id] ??
                                        false,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedCategories[category.id] = val!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(category.name,
                                      style: AppTextStyle.helpReq),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return Container();
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                        child: Text(
                          'Donaition collection address'.tr(),
                          style: AppTextStyle.helpReq,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: address,
                          maxLines: 2,
                          keyboardType: TextInputType.text,
                          decoration: AppInputDecoration.defaultDecoration
                              .copyWith(label: Text("Your address").tr()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your address'.tr();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 20),
                        child: Text(
                          'Phone Number'.tr(),
                          style: AppTextStyle.helpReq,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 4),
                        child: Text(
                          'please make sure of the phone number\nwehere you will be connected'
                              .tr(),
                          style: AppTextStyle.helpReq,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: AppInputDecoration.defaultDecoration
                              .copyWith(
                                  label: Text("Your phone number").tr(),
                                  prefixIcon: Icon(Icons.phone),
                                  prefix: Text('+963')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone Number'.tr();
                            } else if (value.length != 9) {
                              return 'it must be 9 numbers'.tr();
                            } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                              return 'Only digits are allowed'.tr();
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 250, right: 20, top: 20, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        submitForm();
                      },
                      child: Text('Next').tr(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          fixedSize: Size(100, 40),
                          foregroundColor: AppColors.white),
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
