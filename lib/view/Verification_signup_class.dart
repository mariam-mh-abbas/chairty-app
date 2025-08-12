import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Verification_signup_class extends StatefulWidget {
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;

  const Verification_signup_class({
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    super.key,
  });

  @override
  _VerificationDialogContentState createState() =>
      _VerificationDialogContentState();
}

class _VerificationDialogContentState extends State<Verification_signup_class> {
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
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pop(); // close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("The account was created".tr()),
                backgroundColor: Colors.green),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainNavbarPage()),
            (route) => false,
          );
        } else if (state is RegisterFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("The account could not be created".tr()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
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
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: AppColors.secondary),
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
                    ? () async {
                        final otpCode = _controllers.map((c) => c.text).join();
                        final savedLang =
                            await SharedPrefs.getLanguage() ?? 'en';
                        // final registerUser = RegisterUser(
                        //     name: widget.name,
                        //     phone: widget.phone,
                        //     password: widget.password,
                        //     confirmPassword: widget.confirmPassword,
                        //     otp: otpCode,
                        //     preferredLanguage: );
                        BlocProvider.of<AuthBloc>(context).add(
                          RegisterUser(
                              name: widget.name,
                              phone: widget.phone,
                              password: widget.password,
                              confirmPassword: widget.confirmPassword,
                              otp: otpCode,
                              preferredLanguage: savedLang),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCodeComplete
                      ? AppColors.secondary
                      : AppColors.unselected,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
  }
}
