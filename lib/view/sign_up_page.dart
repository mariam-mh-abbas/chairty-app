import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/auth_service.dart';
import 'package:charity_project/view/Verification_signup_class.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/change_password_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class sign_up_page extends StatefulWidget {
  sign_up_page({super.key});

  @override
  State<sign_up_page> createState() => _sign_up_pageState();
}

class _sign_up_pageState extends State<sign_up_page> {
  final TextEditingController phoneNumber1 = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController username = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  bool showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) async {
          if (state is GoogleSuccess) {
            final token = await SharedPrefs.getToken();
            context.read<BlocCartBloc>().add(ClearCart());

            // final phone = await SharedPrefs.getPhone();
            final userid = await SharedPrefs.getUserId();
            // context.read<BlocCartBloc>().add(LoadCart(phone));
            context.read<BlocCartBloc>().add(LoadCart(userid.toString()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Logged in".tr()),
                backgroundColor: AppColors.primary,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MainNavbarPage()),
              (route) => false,
            );
          } else if (state is GoogleFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Unable to log on'.tr()
                    // + state.message
                    ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BackgroundWrapper(
                child: Container(
              height: 1000,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/images/signup.png",
                      width: 600,
                      height: 250,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: username,
                        decoration:
                            AppInputDecoration.defaultDecoration.copyWith(
                          label: Text("User Name".tr()),
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: phoneNumber1,
                        keyboardType: TextInputType.number,
                        decoration:
                            AppInputDecoration.defaultDecoration.copyWith(
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
                          }
                          // else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                          //   return 'Only digits are allowed';
                          // }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: buildPasswordField(
                        controller: password,
                        showPassword: showPassword,
                        toggleVisibility: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        label: "Password".tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password'.tr();
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters'
                                .tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                        label: "Confirm Password".tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password'.tr();
                          } else if (value != password.text) {
                            return 'Passwords do not match'.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                                  content: Verification_signup_class(
                                    name: username.text,
                                    phone: phoneNumber1.text,
                                    password: password.text,
                                    confirmPassword: confirmPassword.text,
                                  ),
                                );
                              },
                            );
                            showFlash(
                              context: context,
                              duration: Duration(seconds: 10),
                              builder: (_, controller) {
                                return Container(
                                  height: 40,
                                  child: FlashBar(
                                    controller: controller,
                                    position: FlashPosition.top,
                                    backgroundColor: AppColors.secondary,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    content: Text(
                                      "The otp code is".tr() + " 351894",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Text('Sign up'.tr()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            fixedSize: Size(400, 40),
                            foregroundColor: AppColors.white),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child:
                              Divider(endIndent: 20, indent: 20, thickness: 1),
                        ),
                        Text(
                          'or'.tr(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary),
                        ),
                        Expanded(
                          child:
                              Divider(endIndent: 20, indent: 20, thickness: 1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          final savedLang =
                              await SharedPrefs.getLanguage() ?? 'en';
                          context.read<AuthBloc>().add(
                              LoginWithGoogle(preferredLanguage: savedLang));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Sign up with Google'.tr()),
                            SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 12,
                              foregroundImage:
                                  AssetImage("assets/images/google.jpg"),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            fixedSize: Size(400, 40),
                            foregroundColor: AppColors.primary),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.facebook,
                    //         color: Color(0xff3628f4),
                    //         size: 40,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     InkWell(
                    //       onTap: () {},
                    //       child: CircleAvatar(
                    //         radius: 18,
                    //         foregroundImage: AssetImage("assets/images/google.jpg"),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'If you have an account'.tr(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => sign_in_page()));
                          },
                          child: Text(
                            'Sign in'.tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    TextButton(
                      onPressed: () {
                        context.read<BlocCartBloc>().add(ClearCart());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainNavbarPage()));
                      },
                      child: Text(
                        'Log in as a guest'.tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
