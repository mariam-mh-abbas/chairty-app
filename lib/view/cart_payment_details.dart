import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/service_locater.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/donation_categories_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPaymentDetails extends StatefulWidget {
  const CartPaymentDetails({super.key, required this.paydetails});
  final List<CartItemModel> paydetails;
  @override
  State<CartPaymentDetails> createState() => _CartPaymentDetailsState();
}

String? selectedMethod;

final List<Map<String, dynamic>> paymentMethods = [
  {"name": "PayPal", "image": "assets/images/patpal.png", "id": "paypal"},
  {"name": "wallet", "image": "assets/images/wallet.png", "id": "wallet"},
  {"name": "Visa card", "image": "assets/images/visa.png", "id": "visa"},
  {
    "name": "Syriatel cash",
    "image": "assets/images/syriatel.png",
    "id": "syriatel"
  },
  {"name": "MTN cash", "image": "assets/images/mtn.png", "id": "mtn"},
];

class _CartPaymentDetailsState extends State<CartPaymentDetails> {
  @override
  void initState() {
    super.initState();
    selectedMethod = "wallet";
  }

  Widget build(BuildContext context) {
    return BlocListener<OncePaymentBloc, OncePaymentState>(
      listener: (context, state) async {
        if (state is OncePaymentSuccess) {
          PaymentResultDialog.showSuccessDialog(context);
          final prefs = serviceLocater<SharedPreferences>();
          final userId = await SharedPrefs.getUserId();
          final String useridstring = userId.toString();
          if (useridstring != null && useridstring.isNotEmpty) {
            await prefs.remove('cart_items_user_$userId');
          }
          context.read<BlocCartBloc>().add(ClearCart());
        } else if (state is OncePaymentFailure) {
          PaymentResultDialog.showFailureDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "Cart Payment Checkout".tr(),
            style: AppTextStyle.a,
          ),
        ),
        body: BackgroundWrapper(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cart Payment Details:".tr(), style: AppTextStyle.a),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: widget.paydetails.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      final item = widget.paydetails[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name ?? "",
                              style: AppTextStyle.helpReq,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "\$${item.Amount ?? '0'}",
                            style: AppTextStyle.a,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 161,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment method:".tr(),
                            style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: paymentMethods.length,
                            itemBuilder: (context, index) {
                              final method = paymentMethods[index];
                              final isSelected = selectedMethod == method["id"];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedMethod = method["id"];
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.grey,
                                            width: isSelected ? 2 : 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Image.asset(
                                            method["image"],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(height: 8),
                                      // Text(
                                      //   method["name"],
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //     fontWeight: isSelected
                                      //         ? FontWeight.bold
                                      //         : FontWeight.normal,
                                      //     color: isSelected
                                      //         ? AppColors.primary
                                      //         : AppColors.unselected,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<BlocCartBloc, BlocCartState>(
                          builder: (context, state) {
                            final cartBloc = context.read<BlocCartBloc>();
                            return Text(
                              "Total amount: ".tr() +
                                  "${context.read<BlocCartBloc>().get()} \$",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: BlocBuilder<BlocCartBloc, BlocCartState>(
                            builder: (context, cartState) {
                              final cartBloc = context.read<BlocCartBloc>();

                              return BlocBuilder<OncePaymentBloc,
                                  OncePaymentState>(
                                builder: (context, paymentState) {
                                  final isLoading =
                                      paymentState is OncePaymentProcess;

                                  return ElevatedButton(
                                    onPressed: cartBloc.cartItems.isEmpty ||
                                            isLoading
                                        ? null
                                        : () async {
                                            final List<OncePaymentmodel> items =
                                                widget.paydetails.map((e) {
                                              return OncePaymentmodel(
                                                campaignId: e.Campainid,
                                                boxId: e.boxId,
                                                amount: e.Amount ?? 0,
                                              );
                                            }).toList();
                                            context
                                                .read<OncePaymentBloc>()
                                                .add(OncePayment(items));
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.secondary,
                                      foregroundColor: AppColors.white,
                                      fixedSize: const Size(300, 40),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            'Pay Now'.tr(),
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                  );
                                },
                              );
                            },
                          ),
                        )

                        // Center(
                        //   child:
                        //   BlocBuilder<BlocCartBloc, BlocCartState>(
                        //     builder: (context, state) {
                        //       final cartBloc = context.read<BlocCartBloc>();
                        //       return ElevatedButton(
                        //         onPressed: cartBloc.cartItems.isEmpty
                        //             ? null
                        //             : () async {
                        //                 final List<OncePaymentmodel> items =
                        //                     widget.paydetails.map((e) {
                        //                   return OncePaymentmodel(
                        //                     campaignId: e.Campainid,
                        //                     boxId: e.boxId,
                        //                     amount: e.Amount ?? 0,
                        //                   );
                        //                 }).toList();
                        //                 context
                        //                     .read<OncePaymentBloc>()
                        //                     .add(OncePayment(items));
                        //               },
                        //         child: Text(
                        //           'Pay Now'.tr(),
                        //           style: TextStyle(fontSize: 15),
                        //         ),
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: AppColors.secondary,
                        //           foregroundColor: AppColors.white,
                        //           fixedSize: Size(300, 40),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
