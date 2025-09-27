import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Gift/bloc/gift_donaition_bloc.dart';
import 'package:charity_project/model/GiftModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donate_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftRequest extends StatefulWidget {
  const GiftRequest({super.key});

  @override
  State<GiftRequest> createState() => _GiftRequestState();
}

class _GiftRequestState extends State<GiftRequest> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController letter = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool hideAmount = false;

  final List<int> amounts = [10, 20, 50, 100];
  int? selectedAmount;

  void submitForm() {
    if (formkey.currentState!.validate() && selectedAmount != null) {
      final gift = Giftmodel(
          amount: selectedAmount!,
          recipientName: name.text,
          recipientPhone: "0${phoneNumber.text}",
          message: letter.text,
          isHide: hideAmount);
      context.read<GiftDonaitionBloc>().add(DonateAsGift(gift));
    }
  }

  void updateAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      amountController.text = amount.toString();
    });
  }

  void onTextChanged(String value) {
    final entered = int.tryParse(value);
    setState(() {
      selectedAmount = (entered != null && entered > 0) ? entered : null;
    });
  }

  bool get isValid => selectedAmount != null;

  @override
  void dispose() {
    name.dispose();
    phoneNumber.dispose();
    letter.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayAmount = selectedAmount ?? 0;
    return BlocListener<GiftDonaitionBloc, GiftDonaitionState>(
      listener: (context, state) {
        if (state is GiftDonaitionSuccess) {
          PaymentResultDialog.showSuccessGiftRequest(context);
        } else if (state is GiftDonaitionError) {
          PaymentResultDialog.showFailureDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Gift".tr(), style: AppTextStyle.a),
        ),
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 100,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffeaf8f9),
                        ),
                        child: Image.asset(
                          'assets/images/giftt.png',
                          height: 100,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text("Set Your Gift Amount".tr(),
                        style: AppTextStyle.a),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: amounts.map((amount) {
                        final isSelected = selectedAmount == amount;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () => updateAmount(amount),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.input,
                                  border: Border.all(color: AppColors.primary),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "$amount \$",
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.input
                                        : AppColors.primary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // إدخال يدوي للمبلغ
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onChanged: onTextChanged,
                      cursorColor: AppColors.primary,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter amount to donate".tr();
                        } else {
                          final val = int.tryParse(value) ?? 0;
                          if (val <= 0) {
                            return "Please enter a valid amount".tr();
                          }
                        }
                        return null;
                      },
                      decoration: AppInputDecoration.paymentInput.copyWith(
                        labelText: "Another amount".tr(),
                        suffix: const Text("\$"),
                        labelStyle: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // عرض المبلغ الإجمالي
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Total Amount :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ).tr(),
                      Text(
                        isValid ? "$displayAmount \$" : "__",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 20),
                  Divider(endIndent: 20, indent: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child:
                        Text("Recipient details".tr(), style: AppTextStyle.a),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: AppInputDecoration.defaultDecoration.copyWith(
                        label: Text('Recipient name').tr(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Recipient name'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      decoration: AppInputDecoration.defaultDecoration.copyWith(
                        label: Text("Recipient phone number").tr(),
                        prefixIcon: Icon(Icons.phone),
                        prefix: Text('+963'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Recipient phone number'.tr();
                        } else if (value.length != 9) {
                          return 'it must be 9 numbers'.tr();
                        } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                          return 'Only digits are allowed'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                      controller: letter,
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      decoration: AppInputDecoration.defaultDecoration.copyWith(
                        label: Text('Your letter to Recipient').tr(),
                        prefixIcon: Icon(Icons.message),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.primary,
                          value: hideAmount,
                          onChanged: (val) {
                            setState(() {
                              hideAmount = val!;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hide the amount of the gift".tr(),
                              style: AppTextStyle.helpReq,
                            ),
                            Text(
                              "select this if you don't want to show\nthe gift's value"
                                  .tr(),
                              style: AppTextStyle.c,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 250, right: 20, top: 20, bottom: 20),
                    child: BlocBuilder<GiftDonaitionBloc, GiftDonaitionState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed:
                              state is GiftDonaitionProcess ? null : submitForm,
                          child: state is GiftDonaitionProcess
                              ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                              : Text('Submit').tr(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            fixedSize: Size(100, 40),
                            foregroundColor: AppColors.white,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
