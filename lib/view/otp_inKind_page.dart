import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/InKindDonaition/bloc/in_kind_donaition_bloc.dart';
import 'package:charity_project/model/InKindCategoryModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpInkindPage extends StatefulWidget {
  final String address;
  final String phone;
  final List<int> categoryIds;

  const OtpInkindPage({
    super.key,
    required this.address,
    required this.phone,
    required this.categoryIds,
  });

  @override
  State<OtpInkindPage> createState() => _OtpInkindPageState();
}

class _OtpInkindPageState extends State<OtpInkindPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  bool isCodeComplete = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    for (var c in _controllers) {
      c.addListener(_checkCodeComplete);
    }
  }

  void _checkCodeComplete() {
    setState(() {
      isCodeComplete = _controllers.every((c) => c.text.trim().isNotEmpty);
    });
  }

  void _submitOtp() {
    final otp = _controllers.map((c) => c.text).join();

    final inKindData = InKindCategorymodel(
      address: widget.address,
      phone: "0${widget.phone}",
      otp: otp,
      categoryIds: widget.categoryIds,
    );

    setState(() => isLoading = true);

    context.read<InKindDonaitionBloc>().add(
          donateInKind(inKindData),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InKindDonaitionBloc, InKindDonaitionState>(
      listener: (context, state) {
        if (state is InKindDonaitionSuccess) {
          setState(() => isLoading = false);
          PaymentResultDialog.showSuccessInKindRequest(context);
          
        } else if (state is InKindDonaitionError) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed ${state.ErrorMsg}')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.white),
        body: Container(height: double.infinity,
            width: double.infinity,
          child: BackgroundWrapper(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 60),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50,),
                  Text(
                    "Enter the Verification code".tr(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: SizedBox(
                          width: 40,
                          height: 45,
                          child: TextField(
                            controller: _controllers[index],
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: EdgeInsets.zero,
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
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: isCodeComplete && !isLoading ? _submitOtp : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isCodeComplete
                          ? AppColors.secondary
                          : AppColors.unselected,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Verify",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ).tr(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
