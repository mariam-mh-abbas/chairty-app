import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/reset_password_bloc/bloc/reset_password_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/reset_password_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verification_password_class extends StatefulWidget {
  final String phone;
  final String password;
  final String confirmPassword;

  const Verification_password_class(
      {super.key,
      required this.phone,
      required this.password,
      required this.confirmPassword});

  @override
  _VerificationDialogContentState createState() =>
      _VerificationDialogContentState();
}

class _VerificationDialogContentState
    extends State<Verification_password_class> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  bool isCodeComplete = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkCodeComplete);
    }
  }

  void _checkCodeComplete() {
    setState(() {
      isCodeComplete = _controllers.every((c) => c.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("The password was changeded".tr()),
                    backgroundColor: Colors.green),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainNavbarPage()),
                (route) => false,
              );
            } else if (state is ResetPasswordFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The password could not be changeded'.tr()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Enter the Verification code'.tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: EdgeInsets.zero,
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   borderSide: BorderSide(color: AppColors.secondary),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: AppColors.primary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: AppColors.secondary),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                              _checkCodeComplete();
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: isCodeComplete
                        ? () {
                            final otpCode =
                                _controllers.map((c) => c.text).join();
                            final submitResetPassword = SubmitResetPassword(
                              phone: widget.phone,
                              password: widget.password,
                              passwordConfirmation: widget.confirmPassword,
                              otp: otpCode,
                            );
                            context.read<ResetPasswordBloc>().add(
                                  SubmitResetPassword(
                                    phone: widget.phone,
                                    password: widget.password,
                                    passwordConfirmation:
                                        widget.confirmPassword,
                                    otp: otpCode,
                                  ),
                                );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCodeComplete
                          ? AppColors.secondary
                          : AppColors.unselected,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Verify'.tr(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
