import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/blocForApp/kaffaratAndSadaqahCounter/bloc/kaffarat_and_sadaqah_counter_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/BoxModel.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/view/Kaffarat_and_Sadaqah_view.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/donate_campaigns_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:charity_project/view/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneKaffaratAndSadaqahPage extends StatelessWidget {
  const OneKaffaratAndSadaqahPage({super.key, required this.box});
  final BoxModel box;
  @override
  Widget build(BuildContext context) {
    final String imageUrl = box.image ?? '';
    final String finalImage =
        Uri.parse(baseUrlImage).resolve(imageUrl).toString();
    return BlocProvider(
      create: (context) => KaffaratAndSadaqahCounterBloc(),
      child: BlocBuilder<KaffaratAndSadaqahCounterBloc, KaffaratAndSadaqahCounterState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.white,
              ),
              body: BackgroundWrapper(
                  child: SizedBox(
                height: 800,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(finalImage),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Text(
                          box.name ?? "unknown",
                          style: AppTextStyle.a,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cost for one".tr(),
                                          style: AppTextStyle.helpReq,
                                        ),
                                        Text(
                                          "\$ ${box.price}" ?? "unknown",
                                          style: AppTextStyle.a,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                  ),
                                  Image.asset(
                                    "assets/images/ass.png",
                                    height: 90,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Please specify the desired quantity".tr(),
                          style: AppTextStyle.helpReq,
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<KaffaratAndSadaqahCounterBloc>().add(IncrementCounter(int.tryParse(box.price ?? '') ?? 0));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.black, width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              state.count.toString(),
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                               
                                context.read<KaffaratAndSadaqahCounterBloc>().add(DecrementCounter(int.tryParse(box.price ?? '') ?? 0));
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.black, width: 2),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                "\$ ${state.totalAmount.toString()}",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: ElevatedButton(
                                onPressed: state.totalAmount >0
                                ? (){
                                   
                        final item = CartItemModel(
              id: box.id,
              name: box.name,
              Campainid: null,
              boxId: box.id,
              image: finalImage,
              Amount: state.totalAmount,
               donationType: "Kaffarat and Sadaqah",
              periodic: "Once"
            );
   Navigator.push(context, MaterialPageRoute(builder: (context)=> PayDetailsPage(paydetails: item)));
            
          
                                }
                                : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.payment,
                                        color: AppColors.white, size: 30),
                                    SizedBox(width: 10),
                                    Text("Pay Now".tr(),
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  fixedSize: Size(250, 50),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                onPressed: state.totalAmount >0.0
                                ? (){
          final newItem = CartItemModel(
            id: box.id,
            name: box.name,
            Amount: state.totalAmount,
            image: finalImage,
            Campainid: null,
            boxId:box.id,
            donationType: "Kaffarat and Sadaqah",
              periodic: "Once"
            
          );
          context.read<BlocCartBloc>().add(AddToCart(newItem));
          ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: AppColors.primary,
                                                      content: Text(
                                                        'added_to_cart'.tr(namedArgs: {'amount':state.totalAmount.toString()})
                                                          // "Added $amount \$ to cart "
                                                          ),
                                                          
                                                    ),
                                                  );
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CharityFundPage()));
        }
                                : null,
                                
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/fund.png',
                                        color: AppColors.primary, height: 30),
                                    SizedBox(width: 10),
                                    Text("Add to Cart".tr(),
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: AppColors.primary, width: 2),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  backgroundColor: AppColors.white,
                                  foregroundColor: AppColors.primary,
                                  fixedSize: Size(250, 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )));
        },
      ),
    );
  }
}
