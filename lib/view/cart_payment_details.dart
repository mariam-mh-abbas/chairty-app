import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
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

class CartPaymentDetails extends StatefulWidget {
  const CartPaymentDetails({super.key, required this.paydetails});
  final List<CartItemModel> paydetails;
  @override
  State<CartPaymentDetails> createState() => _CartPaymentDetailsState();
}

class _CartPaymentDetailsState extends State<CartPaymentDetails> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocListener<OncePaymentBloc, OncePaymentState>(
      listener: (context, state) {
        if (state is OncePaymentSuccess) {
            PaymentResultDialog.showSuccessDialog(context);
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
                            "Total amount:".tr() +
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
                          builder: (context, state) {
                            final cartBloc = context.read<BlocCartBloc>();
                            return ElevatedButton(
                              onPressed: cartBloc.cartItems.isEmpty
                                  ? null
                                  : () {
                                  final List<OncePaymentmodel> items = widget.paydetails.map((e) {
                return OncePaymentmodel(
                  campaignId: e.Campainid,
                  boxId: e.boxId,
                  amount: e.Amount ?? 0,
                );
              }).toList();
              context.read<OncePaymentBloc>().add(OncePayment(items));
                                    },
                              child: Text('Pay Now'.tr(),style: TextStyle(fontSize: 15),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                foregroundColor: AppColors.white,
                                fixedSize: Size(300, 40),
                              ),
                            );
                          },
                        ),
                      ),
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
