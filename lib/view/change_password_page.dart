import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/change_password_bloc/bloc/change_passwrd_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class change_password_page extends StatefulWidget {
  change_password_page({super.key});

  @override
  State<change_password_page> createState() => _change_password_pageState();
}

class _change_password_pageState extends State<change_password_page> {
  final TextEditingController oldPassword = TextEditingController();

  final TextEditingController newPassword = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isOldPasswordCorrect = true;
  bool showOld = false;
  bool showNew = false;
  bool showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswrdBloc(),
      child: Builder(builder: (context) {
        return BlocListener<ChangePasswrdBloc, ChangePasswrdState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("The password was changeded".tr()),
                  backgroundColor: AppColors.primary,
                ),
              );
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (_) => MainNavbarPage()),
              //   (route) => false,
              // );
              Navigator.pop(context);
            } else if (state is ChangePasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The password could not be changeded'.tr()),
                  // backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: BackgroundWrapper(
                  child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBar(
                        backgroundColor: AppColors.white,
                        // elevation: 5,
                        // shadowColor: AppColors.unselected,
                        // title: Text(
                        //   'Donaition Categories',
                        //   style: TextStyle(
                        //       color: AppColors.primary, fontWeight: FontWeight.w700),
                        // ),
                      ),
                      // SizedBox(
                      //   height: 200,
                      // ),
                      Image.asset(
                        'assets/images/password.png',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: buildPasswordField(
                          controller: oldPassword,
                          label: "Old Password".tr(),
                          showPassword: showOld,
                          toggleVisibility: () {
                            setState(() {
                              showOld = !showOld;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your old password'.tr();
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters'
                                  .tr();
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
                              return 'Password must be at least 8 characters'
                                  .tr();
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ChangePasswrdBloc>().add(
                                  SubmitChangePasswordEvent(
                                    oldPassword: oldPassword.text,
                                    newPassword: newPassword.text,
                                    confirmPassword: confirmPassword.text,
                                  ),
                                );
                          }
                        },
                        child: Text('Confirm'.tr()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            fixedSize: Size(110, 40),
                            foregroundColor: AppColors.white),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      }),
    );
  }
}

Widget buildPasswordField({
  required TextEditingController controller,
  required String label,
  required String? Function(String?) validator,
  required bool showPassword,
  required VoidCallback toggleVisibility,
}) {
  return TextFormField(
    controller: controller,
    obscureText: !showPassword,
    validator: validator,
    decoration: AppInputDecoration.defaultDecoration.copyWith(
      label: Text(label),
      prefixIcon: Icon(
        Icons.lock_outlined,
        color: AppColors.primary,
        size: 24,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          showPassword ? Icons.visibility : Icons.visibility_off,
          color: AppColors.unselected,
          size: 15,
        ),
        onPressed: toggleVisibility,
      ),
    ),
  );
}
