// import 'package:flutter/material.dart';

// class OrphanSponsorshipPage extends StatefulWidget {
//   const OrphanSponsorshipPage({super.key});

//   @override
//   State<OrphanSponsorshipPage> createState() => _OrphanSponsorshipPageState();
// }

// class _OrphanSponsorshipPageState extends State<OrphanSponsorshipPage> {
//   TextEditingController amountController = TextEditingController();
//   int selectedIndex = 0; // 0 = Monthly, 1 = Yearly
//   int duration = 1; // Number of months or years

//   int get amount {
//     final text = amountController.text;
//     return int.tryParse(text) ?? 0;
//   }

//   int get total {
//     if (selectedIndex == 0) {
//       // Monthly
//       return amount * duration;
//     } else {
//       // Yearly
//       return amount * (duration * 12);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orphan Sponsorship'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Sponsorship Amount",
//                 prefixIcon: Icon(Icons.attach_money),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (_) => setState(() {}),
//             ),
//             const SizedBox(height: 20),

//             // Toggle for Monthly / Yearly
//             ToggleButtons(
//               isSelected: [selectedIndex == 0, selectedIndex == 1],
//               onPressed: (int index) {
//                 setState(() {
//                   selectedIndex = index;
//                   duration = 1;
//                 });
//               },
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text("Monthly"),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Text("Yearly"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Duration selector
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(selectedIndex == 0 ? "Months: $duration" : "Years: $duration"),
//                 Expanded(
//                   child: Slider(
//                     value: duration.toDouble(),
//                     min: 1,
//                     max: 24,
//                     divisions: 23,
//                     label: duration.toString(),
//                     onChanged: (value) {
//                       setState(() {
//                         duration = value.toInt();
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Total
//             Text(
//               "Total: \$${total}",
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//             const SizedBox(height: 30),

//             ElevatedButton.icon(
//               onPressed: amount > 0 ? () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text("You paid \$${total}")),
//                 );
//               } : null,
//               icon: const Icon(Icons.payment),
//               label: const Text("Pay Now"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';

// class DonationSliderPage extends StatefulWidget {
//   @override
//   _DonationSliderPageState createState() => _DonationSliderPageState();
// }

// class _DonationSliderPageState extends State<DonationSliderPage> {
//   double monthlyAmount = 800;
//   String donationType = 'monthly'; // 'monthly' or 'yearly'

//   double get totalAmount =>
//       donationType == 'monthly' ? monthlyAmount : monthlyAmount * 12;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFCEFF5),
//       appBar: AppBar(
//         title: Text("BARDHYL"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Circular slider indicator
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 CircularPercentIndicator(
//                   radius: 110.0,
//                   lineWidth: 12.0,
//                   percent: (monthlyAmount - 400) / (1200 - 400),
//                   center: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.star, color: Colors.amber),
//                       SizedBox(height: 4),
//                       Text(
//                         "${monthlyAmount.toInt()}",
//                         style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.pink),
//                       ),
//                       Text("QAR",
//                           style:
//                               TextStyle(fontSize: 16, color: Colors.grey[700])),
//                       Text("Monthly amount",
//                           style:
//                               TextStyle(fontSize: 12, color: Colors.grey[600])),
//                     ],
//                   ),
//                   progressColor: Colors.pink,
//                   backgroundColor: Colors.grey[200]!,
//                   circularStrokeCap: CircularStrokeCap.round,
//                 ),
//               ],
//             ),

//             // Slider (Horizontal under the circle)
//             Slider(
//               value: monthlyAmount,
//               min: 400,
//               max: 1200,
//               divisions: 8,
//               label: monthlyAmount.toInt().toString(),
//               activeColor: Colors.pink,
//               inactiveColor: Colors.pink.shade100,
//               onChanged: (value) {
//                 setState(() {
//                   monthlyAmount = value;
//                 });
//               },
//             ),
//             Text(
//               "Please consider increasing your donation for more impact",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.black54),
//             ),
//             SizedBox(height: 20),

//             // Radio buttons for Monthly / Yearly
//             Column(
//               children: [
//                 RadioListTile(
//                   value: 'monthly',
//                   groupValue: donationType,
//                   onChanged: (val) => setState(() => donationType = val!),
//                   title: Text("${monthlyAmount.toInt()} QAR"),
//                   subtitle:
//                       Text("Monthly donation –– Automatically deducted"),
//                 ),
//                 RadioListTile(
//                   value: 'yearly',
//                   groupValue: donationType,
//                   onChanged: (val) => setState(() => donationType = val!),
//                   title: Text(
//                       "${(monthlyAmount * 12).toInt()} QAR (${monthlyAmount.toInt()} × 12 Month)"),
//                 ),
//               ],
//             ),

//             Spacer(),

//             // Total + Donate Button
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)]),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Total Donation",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         Text(
//                           "${totalAmount.toInt()} QAR",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.pink,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ]),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                               "You donated ${totalAmount.toInt()} QAR")));
//                     },
//                     icon: Icon(Icons.payment),
//                     label: Text("Donate"),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink,
//                         shape: StadiumBorder(),
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class AssistanceRequestPage extends StatefulWidget {
  @override
  _AssistanceRequestPageState createState() => _AssistanceRequestPageState();
}

class _AssistanceRequestPageState extends State<AssistanceRequestPage> {
  final _formKey = GlobalKey<FormState>();

  // General applicant controllers
  final fullNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final familyMembersController = TextEditingController();
  final educationLevelController = TextEditingController();
  final hasJobController = TextEditingController();
  final housingTypeController = TextEditingController();
  final hasIncomeController = TextEditingController();
  final incomeAmountController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final caseDescriptionController = TextEditingController();

  // Request type controllers
  String selectedMainType = '';
  String selectedSubType = '';

  // Dynamic controllers
  Map<String, TextEditingController> dynamicControllers = {};

  final Map<String, Map<String, List<String>>> dynamicFieldsMap = {
    "كفالة": {
      "يتيم": ["اسم الأب المتوفي", "تاريخ الوفاة", "سبب الوفاة", "من يعيله حاليًا؟"],
      "طالب علم": ["المرحلة الدراسية الحالية", "اسم المدرسة / الجامعة", "معدل الطالب (إن وجد)", "الشهادة الأخيرة"],
      "ذوي احتياجات خاصة": ["نوع الإعاقة", "درجة الإعاقة (جزئية / كاملة)"],
      "غارم": ["المبلغ المترتب عليه", "سبب الدين"],
    },
    "مساعدات إنسانية": {
      "صحة": ["نوع المرض", "زمرة الدم", "التاريخ المرضي", "هل يأخذ علاج دائم؟"],
      "تعليم": ["المرحلة الدراسية الحالية", "اسم المدرسة / الجامعة", "معدل الطالب (إن وجد)", "الشهادة الأخيرة"],
      "غذاء": ["هل لديه مصدر دخل غذائي؟", "كم مرة تحتاج الأسرة دعم غذائي؟ (شهري، كل أسبوعين، طارئ)"],
    },
    "تبرعات عينية": {
      "لعب أطفال": ["عدد الأطفال", "أعمار الأطفال", "نوع الألعاب المفضلة (اختياري)"],
      "عفش": ["نوع الأثاث المطلوب (سرير / فرش / طاولة / كراسي)", "عدد القطع"],
      "ملابس": ["عدد الأفراد", "المقاسات أو الأعمار", "ملابس صيفية أم شتوية؟"],
      "أجهزة إلكترونية": ["نوع الجهاز (براد، غسالة، سخان، تلفاز...)", "هل يوجد بديل يعمل؟ (نعم/لا)", "سبب الحاجة للجهاز"],
    },
  };

  void updateDynamicControllers(String mainType, String subType) {
    final fields = dynamicFieldsMap[mainType]?[subType] ?? [];
    dynamicControllers.clear();
    for (var field in fields) {
      dynamicControllers[field] = TextEditingController();
    }
  }

  List<Widget> buildDynamicFields() {
    return dynamicControllers.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: entry.value,
          decoration: InputDecoration(labelText: entry.key),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("طلب مساعدة")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(controller: fullNameController, decoration: InputDecoration(labelText: 'الاسم الكامل')),
              TextFormField(controller: fatherNameController, decoration: InputDecoration(labelText: 'اسم الأب')),
              TextFormField(controller: motherNameController, decoration: InputDecoration(labelText: 'اسم الأم')),
              TextFormField(controller: birthDateController, decoration: InputDecoration(labelText: 'تاريخ الميلاد')),
              TextFormField(controller: maritalStatusController, decoration: InputDecoration(labelText: 'الحالة الاجتماعية')),
              TextFormField(controller: familyMembersController, decoration: InputDecoration(labelText: 'عدد أفراد الأسرة')),
              TextFormField(controller: educationLevelController, decoration: InputDecoration(labelText: 'مستوى الدراسة')),
              TextFormField(controller: hasJobController, decoration: InputDecoration(labelText: 'هل لديه عمل؟')),
              TextFormField(controller: housingTypeController, decoration: InputDecoration(labelText: 'نوع السكن')),
              TextFormField(controller: hasIncomeController, decoration: InputDecoration(labelText: 'هل لديه دخل ثابت؟')),
              TextFormField(controller: incomeAmountController, decoration: InputDecoration(labelText: 'المبلغ (إن وجد)')),
              TextFormField(controller: addressController, decoration: InputDecoration(labelText: 'العنوان')),
              TextFormField(controller: phoneController, decoration: InputDecoration(labelText: 'رقم الهاتف')),
              TextFormField(controller: caseDescriptionController, decoration: InputDecoration(labelText: 'وصف الحالة')),
              Divider(),
              DropdownButtonFormField<String>(
                value: selectedMainType.isEmpty ? null : selectedMainType,
                items: dynamicFieldsMap.keys
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                decoration: InputDecoration(labelText: 'نوع المساعدة الرئيسي'),
                onChanged: (val) {
                  setState(() {
                    selectedMainType = val!;
                    selectedSubType = '';
                    dynamicControllers.clear();
                  });
                },
              ),
              if (selectedMainType.isNotEmpty)
                DropdownButtonFormField<String>(
                  value: selectedSubType.isEmpty ? null : selectedSubType,
                  items: dynamicFieldsMap[selectedMainType]!.keys
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  decoration: InputDecoration(labelText: 'نوع المساعدة الفرعي'),
                  onChanged: (val) {
                    setState(() {
                      selectedSubType = val!;
                      updateDynamicControllers(selectedMainType, selectedSubType);
                    });
                  },
                ),
              ...buildDynamicFields(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Send request here
                  }
                },
                child: Text("إرسال الطلب"),
              )
            ],
          ),
        ),
      ),
    );
  }
}