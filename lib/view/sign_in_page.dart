import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/models/login_model.dart';
import 'package:charity_project/services/google_auth_sevice.dart';
import 'package:charity_project/view/Verification_password_class.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/change_password_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/reset_password_page.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:charity_project/view/sign_up_page.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class sign_in_page extends StatefulWidget {
  sign_in_page({super.key});

  @override
  State<sign_in_page> createState() => _sign_in_pageState();
}

class _sign_in_pageState extends State<sign_in_page> {
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => Center(
            //       child: CircularProgressIndicator(
            //     color: AppColors.secondary,

            //   )
            //   ),
            // );
          } 
   else if (state is LoginSuccess) {
  () async {
    
    context.read<BlocCartBloc>().add(ClearCart());

    
    final token = await SharedPrefs.getToken(); 
    await SharedPrefs.savePhone(phoneNumber.text.trim());

    
    // final phone = await SharedPrefs.getPhone();
     final userid = await SharedPrefs.getUserId();
    // context.read<BlocCartBloc>().add(LoadCart(phone));
    context.read<BlocCartBloc>().add(LoadCart(userid.toString()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logged in".tr()),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainNavbarPage()),
      (route) => false,
    );
  }();
}
          // else if (state is LoginSuccess) {
            
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //         content: Text("Logged in".tr()),
          //         backgroundColor: Colors.green),
          //   );
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (_) => MainNavbarPage()),
          //     (route) => false,
          //   );

          // } 
          else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Unable to log on'.tr()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BackgroundWrapper(
                child: Container(
              height: 900,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      "assets/images/signin.png",
                      width: 600,
                      height: 250,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        decoration:
                            AppInputDecoration.defaultDecoration.copyWith(
                          label: Text(
                            "Phone Number".tr(),
                          ),
                          labelStyle: TextStyle(color: AppColors.primary),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: AppColors.primary,
                            size: 24,
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
                      height: 20,
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
                    Row(
                      children: [
                        SizedBox(
                          width: 190,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        reset_password_page()));
                          },
                          child: Text(
                            'Did you forget your password?'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final loginmodel = LoginModel(
                              phone: phoneNumber.text,
                              password: password.text,
                            );
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginUser(
                                phone: phoneNumber.text.trim(),
                                password: password.text,
                              ),
                            );
                          }
                        },
                        child: Text('Sign in'.tr()),
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
                          final googleAuthService = GoogleAuthService();
                          final savedLang =
                              await SharedPrefs.getLanguage() ?? 'en';

                          try {
                            final account =
                                await googleAuthService.signInWithGoogle();

                            if (account != null) {
                              final accessToken = await googleAuthService
                                  .getAccessToken(account);

                              if (accessToken != null) {
                                print('✅ Google Access Token: $accessToken');
                                BlocProvider.of<AuthBloc>(context).add(
                                  LoginWithGoogle(
                                      accessToken: accessToken,
                                      preferredLanguage: savedLang),
                                );
                              } else {
                                print('❌ Failed to get access token');
                              }
                            } else {
                              print('❌ User cancelled Google sign-in');
                            }
                          } catch (e) {
                            print('❌ Google Sign-in error: $e');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Sign in with Google'.tr()),
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
                          'Don`t have an account?'.tr(),
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
                                    builder: (context) => sign_up_page()));
                          },
                          child: Text(
                            "Sign up".tr(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    TextButton(
                      onPressed: () {
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
                    SizedBox(
                      height: 10,
                    ),
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
