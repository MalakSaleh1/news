import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../layout/view/screens/layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Layout()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: Image.asset("assets/images/news_logo.png"))),
            Image.asset("assets/images/news_branding.png",width: 214,height: 86,),
          ],
        ),
      ),
    );
  }
}
