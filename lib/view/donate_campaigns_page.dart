import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/main.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/DetailsCampaignModel.dart';
import 'package:charity_project/model/DetailsHumannCasesModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
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

class DonateCampaignsPage extends StatefulWidget {
  const DonateCampaignsPage({super.key, required this.detailsCampaignModel});

final DetailsCampaignModel detailsCampaignModel;

  @override
  State<DonateCampaignsPage> createState() => _DonateCampaignsPageState();
}

class _DonateCampaignsPageState extends State<DonateCampaignsPage> {
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
      selectedAmount = (entered != null && entered > 0 && entered <=widget.detailsCampaignModel.remainingAmount!) ? entered : null;
    });
  }

  bool get isValid => selectedAmount != null;
  
  @override
  Widget build(BuildContext context) {
        final displayAmount = selectedAmount ?? 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Campaign Donation".tr(),style: AppTextStyle.a,),
        backgroundColor: AppColors.white,
      ),

      body: 
      Container(height: double.infinity,
            width: double.infinity,
        child: BackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Padding(
                padding: const EdgeInsets.only(bottom: 20,top: 40),
                child: Center(
                  child: Container(
                    width: 350,height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary)
                    ),
                    child: Row(
                      children: [Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\$ ${widget.detailsCampaignModel.remainingAmount.toString()}" , style: AppTextStyle.a,),
                            Text("Remaining amount",style: AppTextStyle.helpReq,).tr()
                          ],
                        ),
                      ),
                      SizedBox(width: 60,),
                      Image.asset("assets/images/donate.png",height: 70,)
                      
                      ],
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Text("Set Donation Amount".tr(),style: AppTextStyle.a,),
              ),
              
            
                
           Column(
                
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  amounts.map((amount) {
        final isSelected = selectedAmount == amount;
        
        final isDisabled = amount > widget.detailsCampaignModel.remainingAmount!;
                
        return Expanded(
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
        onTap: isDisabled ? null : () => updateAmount(amount),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.input,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            "$amount \$",
            style: TextStyle(
              color: isSelected ? AppColors.input : AppColors.primary,
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
                if (val > widget.detailsCampaignModel.remainingAmount!) return "Amount exceeds remaining campaign amount";
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            onPressed: isValid && selectedAmount! <=widget.detailsCampaignModel.remainingAmount! && formKey.currentState!.validate()
                ? () {
                    final item = CartItemModel(
                       id: widget.detailsCampaignModel.id,
              name: widget.detailsCampaignModel.title,
              Campainid: widget.detailsCampaignModel.id,
              boxId: null,
              image: widget.detailsCampaignModel.image,
              Amount: selectedAmount,
              donationType: "Campaign",
              periodic: "Once"
                    );
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PayDetailsPage(paydetails: item)));
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              fixedSize: const Size(250, 50),
            ),
            child:  Row(
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
                
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            onPressed: isValid && selectedAmount! <=widget.detailsCampaignModel.remainingAmount! && formKey.currentState!.validate()
                ? () async{
                    final amount = amountController.text;
                      final phone = await SharedPrefs.getPhone();
                     final item = CartItemModel(
                       id: widget.detailsCampaignModel.id,
              name: widget.detailsCampaignModel.title,
              Campainid: widget.detailsCampaignModel.id,
              boxId: null,
              image: "http://localhost:8000/storage/${widget.detailsCampaignModel.image}",
              Amount: selectedAmount,
              donationType: "Campaign",
              periodic: "Once"
                    );
                    
                     
                     context.read<BlocCartBloc>().add(AddToCart(item));
                   context.read<BlocCartBloc>().add(SaveCart(phone));
                       ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: AppColors.primary,
                                                      content: Text(
                                                        'added_to_cart'.tr(namedArgs: {'amount':amount.toString()})
                                                          // "Added $amount \$ to cart "
                                                          ),
                                                          
                                                    ),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CharityFundPage()));
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
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart, size: 24),
                SizedBox(width: 10),
                 Text("Add to Cart".tr(),
                                                style: TextStyle(fontSize: 16))
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


