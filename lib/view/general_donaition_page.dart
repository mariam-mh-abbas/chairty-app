import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/BoxModel.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/donate_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralDonaitionPage extends StatefulWidget {
  const GeneralDonaitionPage({super.key});

  @override
  State<GeneralDonaitionPage> createState() => _GeneralDonaitionPageState();
}

class _GeneralDonaitionPageState extends State<GeneralDonaitionPage> {
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
      selectedAmount = (entered != null && entered > 0) ? entered : null;
    });
  }

  bool get isValid => selectedAmount != null;

  BoxModel? selectedDonation;
  late List<BoxModel> allDonations = [];

  @override
  Widget build(BuildContext context) {
    final displayAmount = selectedAmount ?? 0;

    return BlocProvider(
      create: (context) => BoxBloc()..add(FetchBoxData("General Donation")),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "General Donaition".tr(),
            style: AppTextStyle.a,
          ),
        ),
        body: BackgroundWrapper(child: BlocBuilder<BoxBloc, BoxState>(
          builder: (context, state) {
            if (state is BoxLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (state is BoxError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 270,
                    ),
                    Container(
                      child: Image.asset(
                        "assets/images/error.png",
                        height: 190,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Internet connection is not available".tr(),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is BoxLoaded) {
              final parent = state.box;
              allDonations = [parent, ...parent.children];

              selectedDonation ??= allDonations.first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: DropdownButtonFormField<BoxModel>(
                        decoration: AppInputDecoration.defaultDecoration
                            .copyWith(
                                label: Text("select type of general donation")
                                    .tr()),
                        value: selectedDonation,
                        items: allDonations.map((item) {
                          return DropdownMenuItem<BoxModel>(
                            value: item,
                            child: Text(item.name!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDonation = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () => updateAmount(amount),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.input,
                                      border:
                                          Border.all(color: AppColors.primary),
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
                              if (val > 1000)
                                return "Amount must be less than 1000";
                              if (val <= 0)
                                return "Please enter a valid amount";
                              return null;
                            },
                            decoration:
                                AppInputDecoration.paymentInput.copyWith(
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
                                  formKey.currentState!.validate() &&
                                  selectedDonation != null
                              ? () async {
                                  final token =
                                      await SharedPrefs.getToken() ?? '';
                                  if (token == null || token.isEmpty) {
                                    return PaymentResultDialog.Guest(context);
                                  } else {
                                    final amount = amountController.text;
                                    final CartItemModel item = CartItemModel(
                                        id: int.parse(
                                            "${selectedDonation!.id!}1"),
                                        name: state.box.name,
                                        Campainid: null,
                                        boxId: selectedDonation!.id!,
                                        image: null,
                                        Amount: selectedAmount,
                                        donationType: "General Donaition",
                                        periodic: "Once");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PayDetailsPage(
                                                    paydetails: item)));
                                  }
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
                              Text("Pay Now".tr(),
                                  style: TextStyle(fontSize: 16)),
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
                                  formKey.currentState!.validate() &&
                                  selectedDonation != null
                              ? () async {
                                  final token =
                                      await SharedPrefs.getToken() ?? '';
                                  if (token == null || token.isEmpty) {
                                    return PaymentResultDialog.Guest(context);
                                  } else {
                                    final amount = amountController.text;
                                    //  final phone = await SharedPrefs.getPhone();
                                    final userid =
                                        await SharedPrefs.getUserId();
                                    final CartItemModel item = CartItemModel(
                                        id: int.parse(
                                            "${selectedDonation!.id!}1"),
                                        name: selectedDonation!.name!,
                                        Campainid: null,
                                        boxId: selectedDonation!.id!,
                                        image: null,
                                        Amount: selectedAmount,
                                        donationType: "General Donaition",
                                        periodic: "Once");
                                    context
                                        .read<BlocCartBloc>()
                                        .add(AddToCart(item));
                                    // context.read<BlocCartBloc>().add(SaveCart(phone));
                                    context
                                        .read<BlocCartBloc>()
                                        .add(SaveCart(userid.toString()));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primary,
                                        content: Text('added_to_cart'.tr(
                                                namedArgs: {
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
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            fixedSize: const Size(250, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                  color: AppColors.primary, width: 2),
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
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/error.png",
                      height: 190,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Internet connection is not available".tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}


// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
// import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
// import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
// import 'package:charity_project/config/shared_prefs.dart';
// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/model/BoxModel.dart';
// import 'package:charity_project/model/CartItemModel.dart';
// import 'package:charity_project/view/PaymentResultDialog.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/charity_fund_page.dart';
// import 'package:charity_project/view/donate_page.dart';
// import 'package:charity_project/view/input_decoraition.dart';
// import 'package:charity_project/view/pay_details_page.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GeneralDonaitionPage extends StatefulWidget {
//   const GeneralDonaitionPage({super.key});

//   @override
//   State<GeneralDonaitionPage> createState() => _GeneralDonaitionPageState();
// }

// class _GeneralDonaitionPageState extends State<GeneralDonaitionPage> {
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
//       selectedAmount = (entered != null && entered > 0) ? entered : null;
//     });
//   }

//   bool get isValid => selectedAmount != null;

//   BoxModel? selectedDonation;
//   late List<BoxModel> allDonations = [];

//   @override
//   Widget build(BuildContext context) {
//     final displayAmount = selectedAmount ?? 0;

//     return BlocProvider(
//       create: (context) => BoxBloc()..add(FetchBoxData("General Donation")),
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           title: Text(
//             "General Donaition".tr(),
//             style: AppTextStyle.a,
//           ),
//         ),
//         body: BackgroundWrapper(child: BlocBuilder<BoxBloc, BoxState>(
//           builder: (context, state) {
//             if (state is BoxLoading) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: AppColors.primary,
//                 ),
//               );
//             } else if (state is BoxError) {
//               return Center(
//                 child: Text(state.ErrorMsg),
//               );
//             } else if (state is BoxLoaded) {
//               final parent = state.box;
//               allDonations = [parent, ...parent.children];

//               selectedDonation ??= allDonations.first;
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 20),
//                       child: DropdownButtonFormField<BoxModel>(
//                         decoration: AppInputDecoration.defaultDecoration
//                             .copyWith(
//                                 label: Text("select type of general donation")
//                                     .tr()),
//                         value: selectedDonation,
//                         items: allDonations.map((item) {
//                           return DropdownMenuItem<BoxModel>(
//                             value: item,
//                             child: Text(item.name!),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedDonation = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     child: Text(
//                       "Set Donation Amount".tr(),
//                       style: AppTextStyle.a,
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: amounts.map((amount) {
//                             final isSelected = selectedAmount == amount;
//                             return Expanded(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 4),
//                                 child: GestureDetector(
//                                   onTap: () => updateAmount(amount),
//                                   child: Container(
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: isSelected
//                                           ? AppColors.primary
//                                           : AppColors.input,
//                                       border:
//                                           Border.all(color: AppColors.primary),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "$amount \$",
//                                       style: TextStyle(
//                                         color: isSelected
//                                             ? AppColors.input
//                                             : AppColors.primary,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),

//                       // إدخال يدوي للمبلغ
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Form(
//                           key: formKey,
//                           child: TextFormField(
//                             controller: amountController,
//                             keyboardType: TextInputType.number,
//                             onChanged: onTextChanged,
//                             cursorColor: AppColors.primary,
//                             validator: (value) {
//                               final val = int.tryParse(value ?? '') ?? 0;
//                               if (val > 1000)
//                                 return "Amount must be less than 1000";
//                               if (val <= 0)
//                                 return "Please enter a valid amount";
//                               return null;
//                             },
//                             decoration:
//                                 AppInputDecoration.paymentInput.copyWith(
//                               labelText: "Another amount".tr(),
//                               suffix: const Text("\$"),
//                               labelStyle: TextStyle(color: AppColors.primary),
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // عرض المبلغ الإجمالي
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Total Amount :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ).tr(),
//                           Text(
//                             isValid ? "$displayAmount \$" : "__",
//                             style: TextStyle(
//                               color: AppColors.primary,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         ],
//                       ),

//                       const SizedBox(height: 30),

//                       // زر الدفع
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         child: ElevatedButton(
//                           onPressed: isValid &&
//                                   formKey.currentState!.validate() &&
//                                   selectedDonation != null
//                               ? () async {
//                                   final token =
//                                       await SharedPrefs.getToken() ?? '';
//                                   if (token == null || token.isEmpty) {
//                                     return PaymentResultDialog.Guest(context);
//                                   } else {
//                                     final amount = amountController.text;
//                                     final CartItemModel item = CartItemModel(
//                                         id: state.box.id,
//                                         name: state.box.name,
//                                         Campainid: null,
//                                         boxId: state.box.id!,
//                                         image: null,
//                                         Amount: selectedAmount,
//                                         donationType: "General Donaition",
//                                         periodic: "Once");
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 PayDetailsPage(
//                                                     paydetails: item)));
//                                   }
//                                 }
//                               : null,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             foregroundColor: Colors.white,
//                             fixedSize: const Size(250, 50),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.payment, size: 24),
//                               SizedBox(width: 10),
//                               Text("Pay Now".tr(),
//                                   style: TextStyle(fontSize: 16)),
//                             ],
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // زر الإضافة إلى السلة

//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 50),
//                         child: ElevatedButton(
//                           onPressed: isValid &&
//                                   formKey.currentState!.validate() &&
//                                   selectedDonation != null
//                               ? () async {
//                                   final token =
//                                       await SharedPrefs.getToken() ?? '';
//                                   if (token == null || token.isEmpty) {
//                                     return PaymentResultDialog.Guest(context);
//                                   } else {
//                                     final amount = amountController.text;
//                                     //  final phone = await SharedPrefs.getPhone();
//                                     final userid =
//                                         await SharedPrefs.getUserId();
//                                     final CartItemModel item = CartItemModel(
//                                         id: selectedDonation!.id!,
//                                         name: selectedDonation!.name!,
//                                         Campainid: null,
//                                         boxId: selectedDonation!.id!,
//                                         image: null,
//                                         Amount: selectedAmount,
//                                         donationType: "General Donaition",
//                                         periodic: "Once");
//                                     context
//                                         .read<BlocCartBloc>()
//                                         .add(AddToCart(item));
//                                     // context.read<BlocCartBloc>().add(SaveCart(phone));
//                                     context
//                                         .read<BlocCartBloc>()
//                                         .add(SaveCart(userid.toString()));
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         backgroundColor: Colors.green,
//                                         content: Text('added_to_cart'.tr(
//                                                 namedArgs: {
//                                               'amount': amount.toString()
//                                             })
//                                             // "Added $amount \$ to cart "
//                                             ),
//                                       ),
//                                     );
//                                     Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const CharityFundPage()),
//                                       (route) => route.isFirst,
//                                     );
//                                   }
//                                 }
//                               : null,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: AppColors.primary,
//                             fixedSize: const Size(250, 50),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25),
//                               side: BorderSide(
//                                   color: AppColors.primary, width: 2),
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.shopping_cart, size: 24),
//                               SizedBox(width: 10),
//                               Text("Add to Cart".tr(),
//                                   style: TextStyle(fontSize: 16)),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.symmetric(horizontal: 50),
//                       //   child: ElevatedButton(
//                       //     onPressed: isValid &&
//                       //             formKey.currentState!.validate() &&
//                       //             selectedDonation != null
//                       //         ? () async {
//                       //             final token =
//                       //                 await SharedPrefs.getToken() ?? '';
//                       //             if (token == null || token.isEmpty) {
//                       //               return PaymentResultDialog.Guest(context);
//                       //             } else {
//                       //               final amount = amountController.text;
//                       //               final phone = await SharedPrefs.getPhone();
//                       //               final CartItemModel item = CartItemModel(
//                       //                   id: selectedDonation!.id!,
//                       //                   name: selectedDonation!.name!,
//                       //                   Campainid: null,
//                       //                   boxId: selectedDonation!.id!,
//                       //                   image: null,
//                       //                   Amount: selectedAmount,
//                       //                   donationType: "General Donaition",
//                       //                   periodic: "Once");
//                       //               context
//                       //                   .read<BlocCartBloc>()
//                       //                   .add(AddToCart(item));
//                       //               context
//                       //                   .read<BlocCartBloc>()
//                       //                   .add(SaveCart(phone));
//                       //               ScaffoldMessenger.of(context).showSnackBar(
//                       //                 SnackBar(
//                       //                   backgroundColor: Colors.green,
//                       //                   content: Text('added_to_cart'.tr(
//                       //                           namedArgs: {
//                       //                         'amount': amount.toString()
//                       //                       })
//                       //                       // "Added $amount \$ to cart "
//                       //                       ),
//                       //                 ),
//                       //               );
//                       //               Navigator.pushAndRemoveUntil(
//                       //                 context,
//                       //                 MaterialPageRoute(
//                       //                     builder: (context) =>
//                       //                         const CharityFundPage()),
//                       //                 (route) => route.isFirst,
//                       //               );
//                       //             }
//                       //           }
//                       //         : null,
//                       //     style: ElevatedButton.styleFrom(
//                       //       backgroundColor: Colors.white,
//                       //       foregroundColor: AppColors.primary,
//                       //       fixedSize: const Size(250, 50),
//                       //       shape: RoundedRectangleBorder(
//                       //         borderRadius: BorderRadius.circular(25),
//                       //         side: BorderSide(
//                       //             color: AppColors.primary, width: 2),
//                       //       ),
//                       //     ),
//                       //     child: Row(
//                       //       mainAxisAlignment: MainAxisAlignment.center,
//                       //       children: [
//                       //         Icon(Icons.shopping_cart, size: 24),
//                       //         SizedBox(width: 10),
//                       //         Text("Add to Cart".tr(),
//                       //             style: TextStyle(fontSize: 16)),
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ],
//               );
//             }
//             return Text("data");
//           },
//         )),
//       ),
//     );
//   }
// }

