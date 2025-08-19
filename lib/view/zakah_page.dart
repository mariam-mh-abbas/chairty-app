import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/view/PaymentResultDialog.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/charity_fund_page.dart';
import 'package:charity_project/view/homa_page.dart';
import 'package:charity_project/view/input_decoraition.dart';
import 'package:charity_project/view/pay_details_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final formkey = GlobalKey<FormState>();

class ZakahPage extends StatefulWidget {
  ZakahPage({super.key});

  @override
  State<ZakahPage> createState() => _zakahPageState();
}

class _zakahPageState extends State<ZakahPage> {
  final List<int> amounts = [10, 20, 50, 100];
  int? selectedamount;
  TextEditingController amountin = TextEditingController();

  void updateAmount(int amount) {
    setState(() {
      selectedamount = amount;
      amountin.text = amount.toString();
    });
  }

  void onTextChanged(String value) {
    final entered = int.tryParse(value);
    setState(() {
      selectedamount = (entered != null ) ? entered : null;
    });
  }

  bool get isValid => selectedamount != null;

  @override
  Widget build(BuildContext context) {
 
    final displayamount = selectedamount ?? 0;
    return BlocProvider(
      create: (context) => BoxBloc()..add(FetchBoxData("Zakat")),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
          child: BlocBuilder<BoxBloc, BoxState>(
            builder: (context, state) {
              if (state is BoxLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.primary,),);

            }
            else if (state is BoxError){
              return Center(child: Text(state.ErrorMsg),);
            }
            else if(state is BoxLoaded){
               final String? imageUrl = state.box.image  ;
   final String? finalImage = imageUrl != null && imageUrl.isNotEmpty
    ? Uri.parse(baseUrlImage).resolve(imageUrl).toString()
    : null;
     return Form(
      
                key: formkey,
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColors.white,
                              )),
                          pinned: true,
                          floating: false,
                          backgroundColor: Color(0xff028174),
                          expandedHeight: 220,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                state.box.name ?? "unknown",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            // centerTitle: true,
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    image: finalImage != null
                                 ? DecorationImage(image: NetworkImage(finalImage),fit: BoxFit.cover)
                                 : DecorationImage(image: AssetImage("assets/images/zakah.jpg"),fit: BoxFit.cover)
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(state.box.description ?? "unknown",
             
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                      fontSize: 16),
                                ),
                                Divider(color: AppColors.primary),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: Text('Set Zakah amount'.tr(),
                                      style: AppTextStyle.a),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: TextFormField(
                                    controller: amountin,
                                    keyboardType: TextInputType.number,
                                    onChanged: onTextChanged,
                                    cursorColor: AppColors.primary,
                                    validator: (value) {
                                      final val =
                                          int.tryParse(value ?? '') ?? 0;
                                    
                                      if (val <= 0)
                                        return "Please enter a valid amount".tr();
                                      
                                    },
                                    decoration: AppInputDecoration
                                        .paymentInput
                                        .copyWith(
                                      labelText: "Zakah amount".tr(),
                                      suffix: const Text("\$"),
                                      labelStyle:
                                          TextStyle(color: AppColors.primary),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
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
                                      isValid ? "$displayamount \$ " : "__",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  ],
                                ),
                    
                                SizedBox(height: 40),
                                Column(
                                  
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: ElevatedButton(
                                        onPressed: isValid
                                            ? () async {
                                               final token = await SharedPrefs.getToken() ?? '';
                                              if (token == null || token.isEmpty) {
                                                return PaymentResultDialog.Guest(context);
                                              } else{
 if (formkey.currentState!.validate()&& amountin != null) {
                        final item = CartItemModel(
              id: state.box.id!,
              name: state.box.name,
              Campainid: null,
              boxId: state.box.id!,
              image: finalImage,
              Amount: int.tryParse(amountin.text),
               donationType: "Zakah",
              periodic: "Once"
            );
   Navigator.push(context, MaterialPageRoute(builder: (context)=> PayDetailsPage(paydetails: item)));
            
          }
                                              }
         
        }
      : null,
                                            
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.payment,
                                                color: AppColors.white,
                                                size: 30),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: ElevatedButton(
                                        onPressed: isValid
                                            ? () async {
                                              final token = await SharedPrefs.getToken() ?? '';
                                              if (token == null || token.isEmpty) {
                                                return PaymentResultDialog.Guest(context);
                                              } else {
                                                if (formkey.currentState!
                                                    .validate() && amountin != null) {
                                                        final phone = await SharedPrefs.getPhone();
    
                                                  
                                                                   final item = CartItemModel(
              id: state.box.id!,
              name: state.box.name,
              Campainid: null,
              boxId: state.box.id,
              image: finalImage,
              Amount: int.tryParse(amountin.text),
               donationType: "Zakah",
              periodic: "Once"
            );
                                                    context.read<BlocCartBloc>().add(AddToCart(item));
                                                    context.read<BlocCartBloc>().add(SaveCart(phone));
                                                  final amount = amountin.text;
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: Colors.green,
                                                      content: Text(
                                                        'added_to_cart'.tr(namedArgs: {'amount':amount.toString()})
                                                          // "Added $amount \$ to cart "
                                                          ),
                                                          
                                                    ),
                                                  );
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const CharityFundPage()),
  (route) => route.isFirst,
);
                                                }
                                              }
                                                
                                              }
                                            : null,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/fund.png',
                                                color: AppColors.primary,
                                                height: 30),
                                            SizedBox(width: 10),
                                            Text("Add to Cart".tr(),
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: AppColors.primary,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(25),
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
                      ],
                    )
                  ],
                ),
              );
            }
         return Text("data");
            },
          ),
        ),
      ),
    );
  }
}
