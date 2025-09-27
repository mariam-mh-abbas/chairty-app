// import 'package:charity_project/app_colors.dart';
// import 'package:flutter/material.dart';

// class PaymentMethodsUI extends StatefulWidget {
//   const PaymentMethodsUI({super.key});

//   @override
//   State<PaymentMethodsUI> createState() => _PaymentMethodsUIState();
// }

// class _PaymentMethodsUIState extends State<PaymentMethodsUI> {
//   String? selectedMethod;

//   final List<Map<String, dynamic>> paymentMethods = [
//     {"name": "MTN cash", "icon": Icons.signal_cellular_alt, "id": "mtn"},
//     {"name": "Syriatel cash", "icon": Icons.network_cell, "id": "syriatel"},
//     {"name": "wallet", "icon": Icons.account_balance_wallet, "id": "cash"},
//     {"name": "Visa card", "icon": Icons.credit_card, "id": "visa"},
//     {"name": "PayPal", "icon": Icons.account_balance, "id": "paypal"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text(" ")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: paymentMethods.length,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             final method = paymentMethods[index];
//             final isSelected = selectedMethod == method["id"];

//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   selectedMethod = method["id"];
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 70,
//                       height: 70,
//                       decoration: BoxDecoration(
//                           color: isSelected ? AppColors.white : Colors.white,
//                           border: Border.all(
//                             color: isSelected ? AppColors.primary : Colors.grey,
//                             width: isSelected ? 2 : 1,
//                           ),
//                           shape: BoxShape.circle),
//                       child: Icon(
//                         method["icon"],
//                         size: 24,
//                         color: isSelected
//                             ? AppColors.primary
//                             : AppColors.unselected,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       method["name"],
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight:
//                             isSelected ? FontWeight.bold : FontWeight.normal,
//                         color: isSelected
//                             ? AppColors.primary
//                             : AppColors.unselected,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     if (isSelected)
//                       const Padding(
//                         padding: EdgeInsets.only(top: 8),
//                         child:
//                             Icon(Icons.check_circle, color: AppColors.primary),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
