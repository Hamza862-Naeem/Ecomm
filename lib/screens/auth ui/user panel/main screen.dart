
import 'package:ecomm/screens/auth%20ui/welcome_screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:ecomm/widgets/custom-drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light),
        title: Text(AppConstant.appMainName,
        style: TextStyle(color: AppConstant.appTextColor),),
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
    );
  }
}
