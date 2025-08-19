import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocs/auth_bloc/bloc/auth_bloc_bloc.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:charity_project/view/sign_in_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class log_out extends StatefulWidget {
  const log_out({super.key});

  @override
  State<log_out> createState() => _change_languageState();
}

class _change_languageState extends State<log_out> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
                child: CircularProgressIndicator(
              color: AppColors.secondary,
            )),
          );
        } else if (state is LogoutSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logged out'.tr()),
              backgroundColor: AppColors.primary,
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => sign_in_page()),
            (route) => false,
          );
        } else if (state is LogoutFailure) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('unable to log off'.tr()),
              // backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            'Are you sure you want'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary),
          ),
          Text(
            'to log out'.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primary),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LogoutUser());
                },
                child: Text('Yes'.tr()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    fixedSize: Size(100, 40),
                    foregroundColor: AppColors.white),
              ),
              SizedBox(
                width: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'.tr()),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    fixedSize: Size(100, 40),
                    foregroundColor: AppColors.white),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
