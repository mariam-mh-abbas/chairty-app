// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
// import 'package:charity_project/blocForApp/PeriodicallyDonaition/bloc/periodically_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/SponsorshipDonaition/bloc/sponsorship_donaition_bloc.dart';
// import 'package:charity_project/model/CartItemModel.dart';
// import 'package:charity_project/model/OncePaymentModel.dart';
// import 'package:charity_project/model/PeriodicallyDonaitionModel.dart';
// import 'package:charity_project/view/PaymentResultDialog.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/donation_categories_page.dart';
// import 'package:charity_project/view/input_decoraition.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PayDetailsPage extends StatefulWidget {
//   const PayDetailsPage({super.key, required this.paydetails});
//   final CartItemModel paydetails;
//   @override
//   State<PayDetailsPage> createState() => _PayDetailsPageState();
// }

// class _PayDetailsPageState extends State<PayDetailsPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     return BlocListener<OncePaymentBloc, OncePaymentState>(
//       listener: (context, state) {
//         if (state is OncePaymentSuccess) {
//             PaymentResultDialog.showSuccessDialog(context);
//         } else if (state is OncePaymentFailure) {
//               PaymentResultDialog.showFailureDialog(context);
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           title: Text(
//             "Checkout",
//             style: AppTextStyle.a,
//           ),
//         ),
//         body: BackgroundWrapper(
//             child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "Donation Details ",
//               style: AppTextStyle.a,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Image.asset(
//               "assets/images/pay1.png",
//               height: 100,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Donation For :",
//                     style: AppTextStyle.a,
//                   ),
//                   SizedBox(
//                     width: 100,
//                   ),
//                   Text(
//                     widget.paydetails.name ?? "",
//                     style: AppTextStyle.helpReq,
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               endIndent: 10,
//               indent: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Donation Type :",
//                     style: AppTextStyle.a,
//                   ),
//                   SizedBox(
//                     width: 100,
//                   ),
//                   Text(
//                     "once",
//                     style: AppTextStyle.helpReq,
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               endIndent: 10,
//               indent: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Amount :",
//                     style: AppTextStyle.a,
//                   ),
//                   SizedBox(
//                     width: 155,
//                   ),
//                   Text(
//                     "\$ ${widget.paydetails.Amount}",
//                     style: AppTextStyle.helpReq,
//                   )
//                 ],
//               ),
//             ),
//             Divider(
//               endIndent: 10,
//               indent: 10,
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final Type = widget.paydetails.donationType!;
//                 if (Type == "Sponsorship") {
//                   context.read<SponsorshipDonaitionBloc>().add(DonateToSponsorship(widget.paydetails.id!, widget.paydetails.Amount!));
//                 }
//                 else if (Type == "OncePay"){
//                    final item = OncePaymentmodel(campaignId: widget.paydetails.Campainid ?? null, boxId: widget.paydetails.boxId ?? null, amount: widget.paydetails.Amount!);
//               context.read<OncePaymentBloc>().add(OncePayment([item]));
//                 }
//                  else if (Type == "Periodically Donaition"){
//                    final item = Periodicallydonaitionmodel(recurrence: widget.paydetails.periodic!, amount: widget.paydetails.Amount!);
//               context.read<PeriodicallyDonaitionBloc>().add(DonaitePeriodically(item));
//                 }
//               },
//               child: Text('Pay Now'),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   fixedSize: Size(150, 50),
//                   foregroundColor: AppColors.white),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }










import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/PeriodicallyDonaition/bloc/periodically_donaition_bloc.dart';
import 'package:charity_project/blocForApp/SponsorshipDonaition/bloc/sponsorship_donaition_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/model/PeriodicallyDonaitionModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayDetailsPage extends StatelessWidget {
  final CartItemModel paydetails;
  const PayDetailsPage({super.key, required this.paydetails});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OncePaymentBloc, OncePaymentState>(
          listener: (context, state) {
            if (state is OncePaymentSuccess) {
              PaymentResultDialog.showSuccessDialog(context);
            } else if (state is OncePaymentFailure) {
              PaymentResultDialog.showFailureDialog(context);
            }
          },
        ),
        BlocListener<PeriodicallyDonaitionBloc, PeriodicallyDonaitionState>(
          listener: (context, state) {
            if (state is PeriodicallyDonaitionSuccess) {
              PaymentResultDialog.showSuccessDialog(context);
            } else if (state is PeriodicallyDonaitionError) {
              PaymentResultDialog.showFailureDialog(context);
            }
          },
        ),
        BlocListener<SponsorshipDonaitionBloc, SponsorshipDonaitionState>(
          listener: (context, state) {
            if (state is SponsorshipDonaitionSuccess) {
              PaymentResultDialog.showSuccessDialog(context);
            } else if (state is SponsorshipDonaitionError) {
              PaymentResultDialog.showFailureDialog(context);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text(
            "Payment Checkout".tr(),
            style: AppTextStyle.a,
          ),
          
        ),
        body: BackgroundWrapper(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                 Image.asset(
                  "assets/images/payment.jpg",
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "Payment Details:".tr(),
                  style: AppTextStyle.a.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 20),
               
                

                /// Name
                _buildDetailRow("Donation For:", paydetails.name ?? ""),
                const Divider(),

        if (paydetails.donationType == "Recurring Donation")
  _buildDetailRow("Donation Frequency", LangHelper.getTranslatedPeriod(paydetails.periodic), skipValueTranslation: true),
                
                if(paydetails.donationType != "Recurring Donation") 
                _buildDetailRow("Donation Frequency:", paydetails.periodic ?? ""),
                
                const Divider(),

                /// Amount
                _buildDetailRow("Amount:", "\$${paydetails.Amount?.toString() ?? '0'}"),
                const Divider(),

                const Spacer(),

                /// Pay button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                       final Type = paydetails.donationType!;
                if (Type == "Sponsorship") {
                  context.read<SponsorshipDonaitionBloc>().add(DonateToSponsorship(paydetails.id!, paydetails.Amount!));
                }
                else if (Type == "Campaign" || Type == "Zakah"|| Type == "Sadaqah" || Type == "HumanCase"|| Type == "Kaffarat and Sadaqah"|| Type == "General Donaition"){
                   final item = OncePaymentmodel(campaignId: paydetails.Campainid ?? null, boxId: paydetails.boxId ?? null, amount: paydetails.Amount!);
              context.read<OncePaymentBloc>().add(OncePayment([item]));
                }
                 else if (Type == "Recurring Donation"){
                   final item = Periodicallydonaitionmodel(recurrence: paydetails.periodic!, amount: paydetails.Amount!);
              context.read<PeriodicallyDonaitionBloc>().add(DonaitePeriodically(item));
                }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child:  Text(
                      'Pay Now'.tr(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool skipValueTranslation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(title.tr(), style: AppTextStyle.a),
          ),
          Expanded(
            flex: 6,
            child: Text(
              skipValueTranslation ? value : value.tr(),
              style: AppTextStyle.helpReq,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  

}
