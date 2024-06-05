
import 'package:ecomm/screens/auth%20ui/welcome_screen.dart';
import 'package:ecomm/utils/app-constants.dart';
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light),
        title: Text(AppConstant.appMainName),
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async{
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth _auth= FirebaseAuth.instance;
               await _auth.signOut();
              await FirebaseAuth.instance.signOut();

            // GoogleSignIn googleSignIn = GoogleSignIn();
             // await googleSignIn.signIn();
              Get.offAll(()=> WelcomeScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
    );
  }
}
