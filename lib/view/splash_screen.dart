// import 'package:charity_project/app_colors.dart';
// import 'package:charity_project/view/background.dart';
// import 'package:charity_project/view/set_language_page.dart';
// import 'package:flutter/material.dart';

// class Splash_Screen extends StatelessWidget {
//   const Splash_Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: BackgroundWrapper(child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>set_language_page()));
//             },
//               child: Image.asset("assets/images/logo2.png",height: 200,)),
//               Image.asset("assets/images/logo3.png",height: 100,)
//           ],
//         ),
//       )),
//     );
//   }
// }
import 'dart:async';
import 'package:charity_project/app_colors.dart';
import 'package:charity_project/config/shared_prefs.dart';
import 'package:charity_project/view/background.dart';
import 'package:charity_project/view/main_navBar_page.dart';
import 'package:charity_project/view/set_language_page.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeLogo2;
  late Animation<double> _fadeLogo3;
  late Animation<Offset> _slideLogo2;
  late Animation<Offset> _slideLogo3;

  @override
  void initState() {
    super.initState();

    // تشغيل الأنيميشن
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeLogo2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _fadeLogo3 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _slideLogo2 =
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _slideLogo3 =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();

    // الانتقال التلقائي بعد 3 ثواني
    Timer(const Duration(seconds: 6), () async {
      final token = await SharedPrefs.getToken();
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavbarPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const set_language_page()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BackgroundWrapper(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeLogo2,
                child: SlideTransition(
                  position: _slideLogo2,
                  child: Image.asset("assets/images/logo5.png", height: 200),
                ),
              ),
              // const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeLogo3,
                child: SlideTransition(
                  position: _slideLogo3,
                  child: Image.asset("assets/images/logo4.png", height: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
