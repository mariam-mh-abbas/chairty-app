import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/DetailsCampaignModel.dart';
import 'package:charity_project/model/DetailsHumannCasesModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/service/BaseService.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/donate_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class DonateHumancasePage extends StatefulWidget {
  const DonateHumancasePage({super.key, required this.detailshumanncasesmodel});

  final Detailshumanncasesmodel detailshumanncasesmodel;

  @override
  State<DonateHumancasePage> createState() => _DonateHumancasePageState();
}

class _DonateHumancasePageState extends State<DonateHumancasePage> {
  final formKey = GlobalKey<FormState>();
  final List<int> amounts = [10, 20, 50, 100];
  int? selectedAmount;
  final TextEditingController amountController = TextEditingController();

  void updateAmount(int amount) {
    setState(() {
      selectedAmount = amount;
      amountController.text = amount.toString();
    });
  }

  void onTextChanged(String value) {
    final entered = int.tryParse(value);
    setState(() {
      selectedAmount = (entered != null &&
              entered > 0 &&
              entered <= widget.detailshumanncasesmodel.remainingAmount!)
          ? entered
          : null;
    });
  }

  bool get isValid => selectedAmount != null;

  @override
  Widget build(BuildContext context) {
    final displayAmount = selectedAmount ?? 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "HumanCase Donation".tr(),
          style: AppTextStyle.a,
        ),
        backgroundColor: AppColors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: BackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 40),
                child: Center(
                  child: Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primary)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$ ${widget.detailshumanncasesmodel.remainingAmount.toString()}",
                                style: AppTextStyle.a,
                              ),
                              Text(
                                "Remaining amount".tr(),
                                style:
                                    AppTextStyle.helpReq.copyWith(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Image.asset(
                          "assets/images/donate.png",
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "Set Donation Amount".tr(),
                  style: AppTextStyle.a,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: amounts.map((amount) {
                        final isSelected = selectedAmount == amount;

                        final isDisabled = amount >
                            widget.detailshumanncasesmodel.remainingAmount!;

                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: isDisabled
                                  ? null
                                  : () => updateAmount(amount),
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
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        onChanged: onTextChanged,
                        cursorColor: AppColors.primary,
                        validator: (value) {
                          final val = int.tryParse(value ?? '') ?? 0;
                          if (val >
                              widget.detailshumanncasesmodel.remainingAmount!)
                            return "Amount exceeds remaining campaign amount";
                          if (val <= 0) return "Please enter a valid amount";
                          return null;
                        },
                        decoration: AppInputDecoration.paymentInput.copyWith(
                          labelText: "Another amount".tr(),
                          suffix: const Text("\$"),
                          labelStyle: TextStyle(color: AppColors.primary),
                        ),
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

                  const SizedBox(height: 30),

                  // زر الدفع
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      onPressed: isValid &&
                              selectedAmount! <=
                                  widget.detailshumanncasesmodel
                                      .remainingAmount! &&
                              formKey.currentState!.validate()
                          ? () {
                              final item = CartItemModel(
                                  id: widget.detailshumanncasesmodel.id,
                                  name: widget.detailshumanncasesmodel.title,
                                  Campainid:
                                      widget.detailshumanncasesmodel.campaignId,
                                  boxId: null,
                                  image: widget.detailshumanncasesmodel.image,
                                  Amount: selectedAmount,
                                  donationType: "HumanCase",
                                  periodic: "Once");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PayDetailsPage(paydetails: item)));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        fixedSize: const Size(250, 50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment, size: 24),
                          SizedBox(width: 10),
                          Text("Pay Now".tr(), style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // زر الإضافة إلى السلة
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      onPressed: isValid &&
                              selectedAmount! <=
                                  widget.detailshumanncasesmodel
                                      .remainingAmount! &&
                              formKey.currentState!.validate()
                          ? () async {
                              final amount = amountController.text;
                              // final phone = await SharedPrefs.getPhone();
                              final userid = await SharedPrefs.getUserId();

                              final item = CartItemModel(
                                  id: widget.detailshumanncasesmodel.id,
                                  name: widget.detailshumanncasesmodel.title,
                                  Campainid:
                                      widget.detailshumanncasesmodel.campaignId,
                                  boxId: null,
                                  image:
                                      "$baseUrl/storage/${widget.detailshumanncasesmodel.image}",
                                  Amount: selectedAmount,
                                  donationType: "HumanCase",
                                  periodic: "Once");
                              context.read<BlocCartBloc>().add(AddToCart(item));
                              //  context.read<BlocCartBloc>().add(SaveCart(phone));
                              context
                                  .read<BlocCartBloc>()
                                  .add(SaveCart(userid.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('added_to_cart'.tr(namedArgs: {
                                    'amount': amount.toString()
                                  })
                                      // "Added $amount \$ to cart "
                                      ),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CharityFundPage()),
                                (route) => route.isFirst,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        fixedSize: const Size(250, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, size: 24),
                          SizedBox(width: 10),
                          Text("Add to Cart".tr(),
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
// import 'package:charity_project/config/shared_prefs.dart';
// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/main.dart';
// import 'package:charity_project/model/CartItemModel.dart';
// import 'package:charity_project/model/DetailsCampaignModel.dart';
// import 'package:charity_project/model/DetailsHumannCasesModel.dart';
// import 'package:charity_project/model/OncePaymentModel.dart';
// import 'package:charity_project/service/BaseService.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/charity_fund_page.dart';
// import 'package:charity_project/view/donate_page.dart';
// import 'package:charity_project/view/input_decoraition.dart';
// import 'package:charity_project/view/pay_details_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:percent_indicator/flutter_percent_indicator.dart';

// class DonateHumancasePage extends StatefulWidget {
//   const DonateHumancasePage({super.key, required this.detailshumanncasesmodel});

//   final Detailshumanncasesmodel detailshumanncasesmodel;

//   @override
//   State<DonateHumancasePage> createState() => _DonateHumancasePageState();
// }

// class _DonateHumancasePageState extends State<DonateHumancasePage> {
//   final formKey = GlobalKey<FormState>();
//   final List<int> amounts = [10, 20, 50, 100];
//   int? selectedAmount;
//   final TextEditingController amountController = TextEditingController();

//   void updateAmount(int amount) {
//     setState(() {
//       selectedAmount = amount;
//       amountController.text = amount.toString();
//     });
//   }

//   void onTextChanged(String value) {
//     final entered = int.tryParse(value);
//     setState(() {
//       selectedAmount = (entered != null &&
//               entered > 0 &&
//               entered <= widget.detailshumanncasesmodel.remainingAmount!)
//           ? entered
//           : null;
//     });
//   }

//   bool get isValid => selectedAmount != null;

//   @override
//   Widget build(BuildContext context) {
//     final displayAmount = selectedAmount ?? 0;
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: Text(
//           "HumanCase Donation".tr(),
//           style: AppTextStyle.a,
//         ),
//         backgroundColor: AppColors.white,
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: BackgroundWrapper(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20, top: 40),
//                 child: Center(
//                   child: Container(
//                     width: 350,
//                     height: 100,
//                     decoration: BoxDecoration(
//                         color: AppColors.primary.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: AppColors.primary)),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "\$ ${widget.detailshumanncasesmodel.remainingAmount.toString()}",
//                                 style: AppTextStyle.a,
//                               ),
//                               Text(
//                                 "Remaining amount".tr(),
//                                 style: AppTextStyle.helpReq,
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 60,
//                         ),
//                         Image.asset(
//                           "assets/images/donate.png",
//                           height: 70,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Text(
//                   "Set Donation Amount".tr(),
//                   style: AppTextStyle.a,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: amounts.map((amount) {
//                         final isSelected = selectedAmount == amount;

//                         final isDisabled = amount >
//                             widget.detailshumanncasesmodel.remainingAmount!;

//                         return Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 4),
//                             child: GestureDetector(
//                               onTap: isDisabled
//                                   ? null
//                                   : () => updateAmount(amount),
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? AppColors.primary
//                                       : AppColors.input,
//                                   border: Border.all(color: AppColors.primary),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "$amount \$",
//                                   style: TextStyle(
//                                     color: isSelected
//                                         ? AppColors.input
//                                         : AppColors.primary,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),

//                   // إدخال يدوي للمبلغ
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Form(
//                       key: formKey,
//                       child: TextFormField(
//                         controller: amountController,
//                         keyboardType: TextInputType.number,
//                         onChanged: onTextChanged,
//                         cursorColor: AppColors.primary,
//                         validator: (value) {
//                           final val = int.tryParse(value ?? '') ?? 0;
//                           if (val >
//                               widget.detailshumanncasesmodel.remainingAmount!)
//                             return "Amount exceeds remaining campaign amount";
//                           if (val <= 0) return "Please enter a valid amount";
//                           return null;
//                         },
//                         decoration: AppInputDecoration.paymentInput.copyWith(
//                           labelText: "Another amount".tr(),
//                           suffix: const Text("\$"),
//                           labelStyle: TextStyle(color: AppColors.primary),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // عرض المبلغ الإجمالي
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Total Amount :",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ).tr(),
//                       Text(
//                         isValid ? "$displayAmount \$" : "__",
//                         style: TextStyle(
//                           color: AppColors.primary,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     ],
//                   ),

//                   const SizedBox(height: 30),

//                   // زر الدفع
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 50),
//                     child: ElevatedButton(
//                       onPressed: isValid &&
//                               selectedAmount! <=
//                                   widget.detailshumanncasesmodel
//                                       .remainingAmount! &&
//                               formKey.currentState!.validate()
//                           ? () {
//                               final item = CartItemModel(
//                                   id: widget.detailshumanncasesmodel.id,
//                                   name: widget.detailshumanncasesmodel.title,
//                                   Campainid:
//                                       widget.detailshumanncasesmodel.campaignId,
//                                   boxId: null,
//                                   image: widget.detailshumanncasesmodel.image,
//                                   Amount: selectedAmount,
//                                   donationType: "HumanCase",
//                                   periodic: "Once");

//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           PayDetailsPage(paydetails: item)));
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary,
//                         foregroundColor: Colors.white,
//                         fixedSize: const Size(250, 50),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.payment, size: 24),
//                           SizedBox(width: 10),
//                           Text("Pay Now".tr(), style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // زر الإضافة إلى السلة
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 50),
//                     child: ElevatedButton(
//                       onPressed: isValid &&
//                               selectedAmount! <=
//                                   widget.detailshumanncasesmodel
//                                       .remainingAmount! &&
//                               formKey.currentState!.validate()
//                           ? () async {
//                               final amount = amountController.text;
//                               // final phone = await SharedPrefs.getPhone();
//                               final userid = await SharedPrefs.getUserId();
//                               final item = CartItemModel(
//                                   id: widget.detailshumanncasesmodel.id,
//                                   name: widget.detailshumanncasesmodel.title,
//                                   Campainid: widget.detailshumanncasesmodel.id,
//                                   boxId: null,
//                                   image:
//                                       "$baseUrl/storage/${widget.detailshumanncasesmodel.image}",
//                                   Amount: selectedAmount,
//                                   donationType: "HumanCase",
//                                   periodic: "Once");
//                               context.read<BlocCartBloc>().add(AddToCart(item));
//                               //  context.read<BlocCartBloc>().add(SaveCart(phone));
//                               context
//                                   .read<BlocCartBloc>()
//                                   .add(SaveCart(userid.toString()));
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   backgroundColor: Colors.green,
//                                   content: Text('added_to_cart'.tr(namedArgs: {
//                                     'amount': amount.toString()
//                                   })
//                                       // "Added $amount \$ to cart "
//                                       ),
//                                 ),
//                               );
//                               Navigator.pushAndRemoveUntil(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const CharityFundPage()),
//                                 (route) => route.isFirst,
//                               );
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 50),
// //           child: ElevatedButton(
// //             onPressed: isValid && selectedAmount! <=widget.detailshumanncasesmodel.remainingAmount! && formKey.currentState!.validate()
// //                 ? ()async {
// //                     final amount = amountController.text;
// //                       final phone = await SharedPrefs.getPhone();
// //                       final item = CartItemModel(
// //                        id: widget.detailshumanncasesmodel.id,
// //               name: widget.detailshumanncasesmodel.title,
// //               Campainid: widget.detailshumanncasesmodel.id,
// //               boxId: null,
// //               image: "http://localhost:8000/storage/${widget.detailshumanncasesmodel.image}",
// //               Amount: selectedAmount,
// //                donationType: "HumanCase",
// //               periodic: "Once"
// //                     );
// //                      context.read<BlocCartBloc>().add(AddToCart(item));
// //                      context.read<BlocCartBloc>().add(SaveCart(phone));
// //                      ScaffoldMessenger.of(context)
// //                                                       .showSnackBar(
// //                                                     SnackBar(
// //                                                       backgroundColor: Colors.green,
// //                                                       content: Text(
// //                                                         'added_to_cart'.tr(namedArgs: {'amount':amount.toString()})
// //                                                           // "Added $amount \$ to cart "
// //                                                           ),

// //                                                     ),
// //                                                   );
// // Navigator.pushAndRemoveUntil(
// //   context,
// //   MaterialPageRoute(builder: (context) => const CharityFundPage()),
// //   (route) => route.isFirst,
// // );
//                             }
//                           : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: AppColors.primary,
//                         fixedSize: const Size(250, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           side: BorderSide(color: AppColors.primary, width: 2),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.shopping_cart, size: 24),
//                           SizedBox(width: 10),
//                           Text("Add to Cart".tr(),
//                               style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
