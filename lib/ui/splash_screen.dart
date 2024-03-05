import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newecommarce/const/AppColors.dart';
import 'package:newecommarce/ui/bottom_nav_pages/home.dart';
import 'package:newecommarce/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_nav_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(const Duration(seconds: 3),()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>
       auth.currentUser==null? LoginScreen():BottomNavController())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "E-Commerce",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 44.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
