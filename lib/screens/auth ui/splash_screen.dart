


import 'dart:async';

import 'package:ecomm/screens/auth%20ui/user%20panel/main%20screen.dart';
import 'package:ecomm/screens/auth%20ui/welcome_screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Get.offAll(() => WelcomeScreen());
    });
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppConstant.appSecondaryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
             Expanded(
               child: Container(
                 width: Get.width,
                 alignment: Alignment.center,
                  child: Lottie.asset('assets/images/splash screen.json',),
                ),
             ),

            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
