import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PeriodicallyDonaition extends StatefulWidget {
  const PeriodicallyDonaition({super.key});

  @override
  State<PeriodicallyDonaition> createState() => _PeriodicallyDonaitionState();
}

class _PeriodicallyDonaitionState extends State<PeriodicallyDonaition> {
  final List<int> amounts = [10, 20, 50, 100];
  final List<String> periodically = ['daily', 'weekly', 'monthly'];
  int? selectedamount;
  String? selectedperiodically;
  final _formkey = GlobalKey<FormState>();
  TextEditingController amountin = TextEditingController();

  void updateAmount(int amount) {
    setState(() {
      selectedamount = amount;
      amountin.text = amount.toString();
    });
  }

  void updatePeriod(String period) {
    setState(() {
      selectedperiodically = period;
    });
  }

  void onTextChanged(String value) {
    final entered = int.tryParse(value);
    setState(() {
      selectedamount = (entered != null) ? entered : null;
    });
  }

  bool get isValid => selectedamount != null && selectedperiodically != null;
  @override
  Widget build(BuildContext context) {
    final displayamount = selectedamount ?? 0;
    // final displayperiodically = selectedperiodically ?? "";
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: BackgroundWrapper(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: AppColors.white,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Recurring Donation'.tr(),
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffeaf8f9),
                    ),
                    child: Image.asset(
                      'assets/images/mmm.png',
                      height: 100,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: periodically.map((period) {
                      final isSelected = selectedperiodically == period;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => updatePeriod(period),
                            child: Container(
                              height: 55,
                              width: 70,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.input,
                                border: Border.all(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  'period.$period'.tr(),
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
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: amounts.map((amount) {
                      final isSelected = selectedamount == amount;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => updateAmount(amount),
                            child: Container(
                              height: 50,
                              width: 70,
                              padding: EdgeInsets.symmetric(vertical: 14),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: TextFormField(
                    cursorColor: AppColors.primary,
                    controller: amountin,
                    keyboardType: TextInputType.number,
                    onChanged: onTextChanged,
                    validator: (value) {
                      int val = int.tryParse(value ?? '') ?? 0;

                      if (val <= 0) return "Please enter a valid amount".tr();
                      return null;
                    },
                    decoration: AppInputDecoration.paymentInput.copyWith(
                      labelText: "Another amount".tr(),
                      suffix: const Text("\$"),
                      labelStyle: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Total Amount :'.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      isValid
                          ? "$displayamount ${'period.$selectedperiodically'.tr()}"
                          : "__",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: isValid
                          ? () async {
                              final token = await SharedPrefs.getToken() ?? '';
                              if (token == null || token.isEmpty) {
                                return PaymentResultDialog.Guest(context);
                              } else {
                                if (_formkey.currentState!.validate() &&
                                    selectedamount != null) {
                                  final amount = amountin.text;
                                  final item = CartItemModel(
                                      name: "Recurring Donation".tr(),
                                      Campainid: null,
                                      boxId: null,
                                      image: null,
                                      Amount: selectedamount,
                                      donationType: "Recurring Donation",
                                      periodic: selectedperiodically);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PayDetailsPage(
                                              paydetails: item)));
                                }
                              }
                            }
                          : null,
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: AppColors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Pay Now".tr(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          fixedSize: Size(260, 50)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
