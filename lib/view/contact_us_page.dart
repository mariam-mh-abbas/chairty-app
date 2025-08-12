import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/contact_us_bloc/bloc/contact_us_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/services/contact_us_service.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class contact_us_page extends StatelessWidget {
  contact_us_page({super.key});
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController massage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsBloc(ContactUsService()),
      child: Builder(builder: (context) {
        return BlocListener<ContactUsBloc, ContactUsState>(
          listener: (context, state) {
            // if (state is MessageLoading){
            //   //  return  Center(child: CircularProgressIndicator());
            // } else
            if (state is MessageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Message sent'.tr()),
                    backgroundColor: Colors.green),
              );
            } else if (state is MessageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to sent message".tr()),
                  backgroundColor: Colors.red,
                ),
              );
            } else {}
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: BackgroundWrapper(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: AppColors.white,
                    elevation: 2,
                    shadowColor: AppColors.unselected,
                    title: Text(
                      'Contact us'.tr(),
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, bottom: 15),
                    child: SizedBox(
                      height: 120,
                      width: 370,
                      child: Text(
                          'If you want to communicate with the assonciation: you can type you number, your massage and the assonciation will continue at the nearest time'
                              .tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: AppInputDecoration.defaultDecoration.copyWith(
                        label: Text(
                          "Phone Number".tr(),
                        ),
                        labelStyle: TextStyle(color: AppColors.primary),
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
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      maxLines: 4,
                      minLines: 4,
                      controller: massage,
                      keyboardType: TextInputType.text,
                      decoration: AppInputDecoration.defaultDecoration.copyWith(
                        label: Text("The Massage".tr()),
                        alignLabelWithHint: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 70), // تعدل مكان الأيقونة
                          child: Icon(
                            Icons.article_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter your massege'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //                   final phone = phoneNumber.text.trim();
                      // final msg = massage.text.trim();
                      context.read<ContactUsBloc>().add(
                            SendMessageEvent(
                              phone: phoneNumber.text,
                              message: massage.text,
                            ),
                          );
                    },
                    child: Text('Send'.tr()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        fixedSize: Size(100, 40),
                        foregroundColor: AppColors.white),
                  ),
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
