import 'package:charity_project/app_colors.dart';

import 'package:charity_project/view/Verification_password_class.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/change_password_page.dart';
import 'package:charity_project/view/input_decoraition.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class reset_password_page extends StatefulWidget {
  reset_password_page({super.key});

  @override
  State<reset_password_page> createState() => _reset_password_pageState();
}

class _reset_password_pageState extends State<reset_password_page> {
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController newPassword = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showNew = false;

  bool showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: AppColors.white,
                // elevation: 2,
                // shadowColor: AppColors.unselected,
                // title: Text(
                //   'Volunteering',
                //   style: TextStyle(
                //       color: AppColors.primary, fontWeight: FontWeight.w700),
                // ),
              ),
              Image.asset(
                'assets/images/password.png',
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: AppInputDecoration.defaultDecoration.copyWith(
                    label: Text("Phone Number".tr()),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary,
                    ),
                    // prefix: Text('+963')
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your phone Number'.tr();
                    } else if (value.length != 10) {
                      return 'it must be 10 numbers'.tr();
                      // } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                      //   return 'Only digits are allowed';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: buildPasswordField(
                  controller: newPassword,
                  showPassword: showNew,
                  toggleVisibility: () {
                    setState(() {
                      showNew = !showNew;
                    });
                  },
                  label: "New Password".tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter new password'.tr();
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters'.tr();
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: buildPasswordField(
                  controller: confirmPassword,
                  showPassword: showConfirm,
                  toggleVisibility: () {
                    setState(() {
                      showConfirm = !showConfirm;
                    });
                  },
                  label: "Confirm New Password".tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password'.tr();
                    } else if (value != newPassword.text) {
                      return 'Passwords do not match'.tr();
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            content: Verification_password_class(
                              phone: phoneNumber.text,
                              password: newPassword.text,
                              confirmPassword: confirmPassword.text,
                            ),
                          );
                        },
                      );
                      showFlash(
                        context: context,
                        duration: Duration(seconds: 10),
                        builder: (_, controller) {
                          return FlashBar(
                            controller: controller,
                            position: FlashPosition.top,
                            backgroundColor: AppColors.secondary,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            content: Text(
                              "The otp code is 759412",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text('Confirm'.tr()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      fixedSize: Size(100, 40),
                      foregroundColor: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
