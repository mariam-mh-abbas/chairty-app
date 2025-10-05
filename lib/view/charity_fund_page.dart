import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/cart_payment_details.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:flutter/material.dart';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/blocForApp/InKindDonaition/bloc/in_kind_donaition_bloc.dart';
import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
import 'package:charity_project/helpers/app_language.dart';
import 'package:charity_project/model/CartItemModel.dart';
import 'package:charity_project/model/OncePaymentModel.dart';
import 'package:charity_project/view/app_text_style.dart';
import 'package:charity_project/view/background.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharityFundPage extends StatelessWidget {
  const CharityFundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainNavbarPage()),
          (route) => false,
        );
        return false; // ⬅️ مهم حتى ما يغلق الصفحة الحالية قبل ما ننقلك
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BackgroundWrapper(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainNavbarPage()),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.arrow_back)),
                backgroundColor: AppColors.white,
                // elevation: 5,
                // shadowColor: AppColors.unselected,
                title: Text(
                  'Goodness Box'.tr(),
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(child: BlocBuilder<BlocCartBloc, BlocCartState>(
                builder: (context, state) {
                  if (context.read<BlocCartBloc>().cartItems.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Goodness Box is currently empty.\nExplore donation opportunities and add what your heart inspires."
                                .tr(),
                            style: AppTextStyle.b,
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(
                            "assets/images/option 1.png",
                            height: 190,
                          )
                        ],
                      ),
                    );
                  }
                  return SizedBox(
                    height: 530,
                    child: ListView.builder(
                        itemCount:
                            context.read<BlocCartBloc>().cartItems.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              height: 100,
                              width: 200,
                              child: Card(
                                elevation: 3,
                                color: AppColors.white,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: context
                                                        .read<BlocCartBloc>()
                                                        .cartItems[index]
                                                        .image !=
                                                    null
                                                ? NetworkImage(context
                                                    .read<BlocCartBloc>()
                                                    .cartItems[index]
                                                    .image!)
                                                : const AssetImage(
                                                        "assets/images/general.png")
                                                    as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 180,
                                          child: Text(
                                            context
                                                .read<BlocCartBloc>()
                                                .cartItems[index]
                                                .name!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Text(
                                          context
                                                  .read<BlocCartBloc>()
                                                  .cartItems[index]
                                                  .donationType ??
                                              "AA",
                                          style: TextStyle(
                                              color: AppColors.primary
                                                  .withOpacity(0.5),
                                              fontWeight: FontWeight.w500),
                                        ).tr(),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      context
                                              .read<BlocCartBloc>()
                                              .cartItems[index]
                                              .Amount!
                                              .toString() +
                                          '\$',
                                      style: TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // IconButton(
                                    //     onPressed: () async {
                                    //       final phone =
                                    //           await SharedPrefs.getPhone();
                                    //       context.read<BlocCartBloc>().add(
                                    //           DeleteFromCart(
                                    //               context
                                    //                       .read<BlocCartBloc>()
                                    //                       .cartItems[index]
                                    //                       .id ??
                                    //                   0,
                                    //               phone!));
                                    //       ScaffoldMessenger.of(context)
                                    //           .showSnackBar(
                                    //         SnackBar(
                                    //             backgroundColor: Colors.green,
                                    //             content: Text(
                                    //                     'Item Has Been Deleted Successfully')
                                    //                 .tr()),
                                    //       );
                                    //     },
                                    //     icon: Icon(
                                    //       Icons.delete,
                                    //       color: AppColors.primary,
                                    //     ))
                                    IconButton(
                                        onPressed: () async {
                                          // final phone = await SharedPrefs.getPhone();
                                          final userid =
                                              await SharedPrefs.getUserId();
                                          // context.read<BlocCartBloc>().add(DeleteFromCart(context.read<BlocCartBloc>().cartItems[index].id ?? 0,phone!));
                                          context.read<BlocCartBloc>().add(
                                              DeleteFromCart(
                                                  context
                                                          .read<BlocCartBloc>()
                                                          .cartItems[index]
                                                          .id ??
                                                      0,
                                                  userid.toString()!));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                backgroundColor:
                                                    AppColors.primary,
                                                content: Text(
                                                        'Item Has Been Deleted Successfully')
                                                    .tr()),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: AppColors.primary,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              )),
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
                        child:
                            // BlocBuilder<BlocCartBloc, BlocCartState>(
                            //   builder: (context, state) {
                            //     final cartBloc = context.read<BlocCartBloc>();

                            //     final isLoading =
                            //         state is CartLoading; // غير الاسم حسب حالتك
                            //     final isDisabled =
                            //         cartBloc.cartItems.isEmpty || isLoading;

                            //     return ElevatedButton(
                            //       onPressed: isDisabled
                            //           ? null
                            //           : () {
                            //               Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                   builder: (context) => CartPaymentDetails(
                            //                     paydetails: cartBloc.cartItems,
                            //                   ),
                            //                 ),
                            //               );
                            //             },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: AppColors.secondary,
                            //         foregroundColor: AppColors.white,
                            //         fixedSize: const Size(300, 40),
                            //       ),
                            //       child: isLoading
                            //           ? const SizedBox(
                            //               height: 20,
                            //               width: 20,
                            //               child: CircularProgressIndicator(
                            //                 strokeWidth: 2,
                            //                 color: Colors.white,
                            //               ),
                            //             )
                            //           : Text(
                            //               'Proceed to Checkout',
                            //               style: const TextStyle(fontSize: 16),
                            //             ).tr(),
                            //     );
                            //   },
                            // )

                            BlocBuilder<BlocCartBloc, BlocCartState>(
                          builder: (context, state) {
                            final cartBloc = context.read<BlocCartBloc>();
                            return ElevatedButton(
                              onPressed: cartBloc.cartItems.isEmpty
                                  ? null
                                  : () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartPaymentDetails(
                                                      paydetails: context
                                                          .read<BlocCartBloc>()
                                                          .cartItems)));
                                    },
                              child: Text(
                                'Proceed to Checkout',
                                style: TextStyle(fontSize: 16),
                              ).tr(),
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
    );
  }
}

// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/Box/bloc/box_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/cart_payment_details.dart';
// import 'package:flutter/material.dart';
// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/InKindDonaition/bloc/in_kind_donaition_bloc.dart';
// import 'package:charity_project/blocForApp/OncePayment/bloc/once_payment_bloc.dart';
// import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/model/CartItemModel.dart';
// import 'package:charity_project/model/OncePaymentModel.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class CharityFundPage extends StatefulWidget {
//   const CharityFundPage({super.key});

//   @override
//   State<CharityFundPage> createState() => _CharityFundPageState();
// }

// class _CharityFundPageState extends State<CharityFundPage> {
// void initState() {
//     super.initState();
//     // Ensure blocs are loaded
//     context.read<AllCampaignBloc>().add(FetchAllCampaign());
//     context.read<AllHumanCasesBloc>().add(FetchAllHumanCases());
    
//   }
// Widget _buildItem(BuildContext context, CartItemModel item) {
//     String? name;
//     String? image;

//     final allCampaignState = context.read<AllCampaignBloc>().state;
//     final AllHumanCasesState = context.read<AllHumanCasesBloc>().state;

//     if (item.donationType == 'Campaign' && allCampaignState is AllCampaignLoaded) {
//       final campaign = allCampaignState.Allcampaigns.firstWhere(
//         (c) => c.id == item.id,
        
//       );
//       if (campaign != null) {
//         name =  campaign.title;
        
//       }
//     } 
//     else if (item.donationType == 'HumanCase' && AllHumanCasesState is AllHumanCasesLoaded) {
//       final Humancase = AllHumanCasesState.humanCasemodel
//       .firstWhere(
//         (c) => c.id == item.id,
        
//       );
//       if (Humancase != null) {
//         name =  Humancase.title;
        
//       }
//     } 

//     if (name == null) return SizedBox();

//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Card(
//         elevation: 3,
//         color: AppColors.white,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                 height: 70,
//                 width: 70,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: image != null
//                       ? DecorationImage(
//                           image: NetworkImage(item.image!),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name!,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: AppColors.primary,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     item.donationType ?? '',
//                     style: TextStyle(
//                       color: AppColors.primary.withOpacity(0.5),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               '${item.Amount} \$',
//               style: TextStyle(
//                 color: AppColors.secondary,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 context.read<BlocCartBloc>().add(DeleteFromCart(item.id!));
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Item has been deleted')),
//                 );
//               },
//               icon: Icon(Icons.delete, color: AppColors.primary),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: BackgroundWrapper(
//         child: Column(
//           children: [
//             AppBar(

//               backgroundColor: AppColors.white,
//               // elevation: 5,
//               // shadowColor: AppColors.unselected,
//               title: Text('Goodness Box'.tr(),style: TextStyle(
//                 color: AppColors.primary,fontWeight: FontWeight.w600
//               ),),
//             ),
//             Expanded(child: 
//             BlocBuilder<BlocCartBloc, BlocCartState>(
//               builder: (context, state) {
//                 if (context.read<BlocCartBloc>().cartItems.isEmpty) {
//                   return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Your Goodness Box is currently empty.\nExplore donation opportunities and add what your heart inspires."
//                                   .tr(),
//                               style: AppTextStyle.b,
//                               textAlign: TextAlign.center,
//                             ),
//                             Image.asset(
//                               "assets/images/option 1.png",
//                               height: 190,
//                             )
//                           ],
//                         ),
//                       );


//                 }
//                 return  SizedBox(height: 530,
//              child: ListView.builder(itemCount: context.read<BlocCartBloc>().cartItems.length,
//              scrollDirection: Axis.vertical,
//               itemBuilder: (context,index){
//                return _buildItem(context, context.read<BlocCartBloc>().cartItems[index]);
  

//              }),
//            );
//               },
//             )),
//           Container(
//                 height: 120,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: AppColors.white,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       BlocBuilder<BlocCartBloc, BlocCartState>(
//                         builder: (context, state) {
//                           final cartBloc = context.read<BlocCartBloc>();
//                           return Text(
//                             "Total amount:".tr() +
//                                 "${context.read<BlocCartBloc>().get()} \$",
//                             style: TextStyle(
//                               color: AppColors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18,
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       Center(
//                         child: BlocBuilder<BlocCartBloc, BlocCartState>(
//                           builder: (context, state) {
//                             final cartBloc = context.read<BlocCartBloc>();
//                             return ElevatedButton(
//                               onPressed: cartBloc.cartItems.isEmpty
//                                   ? null
//                                   : () {
//                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPaymentDetails(paydetails: context.read<BlocCartBloc>().cartItems)));
//                                     },
//                               child: Text('Proceed to Checkout',style: TextStyle(fontSize: 16),).tr(),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.secondary,
//                                 foregroundColor: AppColors.white,
//                                 fixedSize: Size(300, 40),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//           ],
//         ),
//       ),
//     );

//   }
// }


// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/blocForApp/blocAllCampaign/bloc/all_campaign_bloc.dart';
// import 'package:charity_project/blocForApp/blocAllHumanCases/bloc/all_human_cases_bloc.dart';
// import 'package:charity_project/blocForApp/blocCart/bloc/bloc_cart_bloc.dart';
// import 'package:charity_project/blocForApp/blocHumanCaseByCategory/bloc/humancase_by_category_bloc.dart';

// import 'package:charity_project/helpers/app_language.dart';
// import 'package:charity_project/model/CartItemModel.dart';
// import 'package:charity_project/view/app_text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CharityFundPage extends StatefulWidget {
//   const CharityFundPage({super.key});

//   @override
//   State<CharityFundPage> createState() => _CharityFundPageState();
// }

// class _CharityFundPageState extends State<CharityFundPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Ensure blocs are loaded
//     context.read<AllCampaignBloc>().add(FetchAllCampaign());
//     context.read<AllHumanCasesBloc>().add(FetchAllHumanCases());
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartItems = context.watch<BlocCartBloc>().cartItems;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//         backgroundColor: AppColors.primary,
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           return _buildItem(context, cartItems[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildItem(BuildContext context, CartItemModel item) {
//     String? name;
//     String? image;

//     final allCampaignState = context.read<AllCampaignBloc>().state;
//     final AllHumanCasesState = context.read<AllHumanCasesBloc>().state;

//     if (item.donationType == 'Campaign' && allCampaignState is AllCampaignLoaded) {
//       final campaign = allCampaignState.Allcampaigns.firstWhere(
//         (c) => c.id == item.Campainid,
        
//       );
//       if (campaign != null) {
//         name =  campaign.title;
//         image = campaign.image;
//       }
//     } 
//      if (item.donationType == 'HumanCase' && AllHumanCasesState is AllHumanCasesLoaded) {
//       final Humancase = AllHumanCasesState.humanCasemodel
//       .firstWhere(
//         (c) => c.id == item.Campainid,
        
//       );
//       if (Humancase != null) {
//         name =  Humancase.title;
        
//       }
//     } 

//     if (name == null) return SizedBox();

//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Card(
//         elevation: 3,
//         color: AppColors.white,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Container(
//                 height: 70,
//                 width: 70,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: image != null
//                       ? DecorationImage(
//                           image: NetworkImage(item.image!),
//                           fit: BoxFit.cover,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: AppColors.primary,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18,
//                     ),
//                   ),
//                   Text(
//                     item.donationType ?? '',
//                     style: TextStyle(
//                       color: AppColors.primary.withOpacity(0.5),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               '${item.Amount} \$',
//               style: TextStyle(
//                 color: AppColors.secondary,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 context.read<BlocCartBloc>().add(DeleteFromCart(item.id!));
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Item has been deleted')),
//                 );
//               },
//               icon: Icon(Icons.delete, color: AppColors.primary),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






