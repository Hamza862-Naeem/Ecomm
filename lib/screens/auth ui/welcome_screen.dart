
import 'package:ecomm/controllers/google_sign_in_controller.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';



class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 final GoogleSignInController _googleSignInController=Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondaryColor,
        centerTitle: true,
        title: const Text('WellCome to shopping app',
        style: TextStyle(
          color: AppConstant.appTextColor
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: AppConstant.appSecondaryColor,
                  child: Lottie.asset('assets/images/cart.json'),
                ),
        
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text('Happy Shopping',
                  style: TextStyle(
                    fontSize: 22,
                  fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  height: Get.height/12,
                ),
                Material(
                  child:Container(
                    height: Get.height/12,
                    width: Get.width/1.3,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton.icon(
                      icon: Image.asset('assets/images/google_logo.webp'),
                      onPressed: () {
                        _googleSignInController.signInWithGoogle();
                      },
                      label: Text('Sign in with Google',
                      style: TextStyle(
                        color: AppConstant.appTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
        
        
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height/30,
                ),
                Material(
                  child:Container(
                    height: Get.height/12,
                    width: Get.width/1.3,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton.icon(
                      icon:Icon(
                        Icons.email,
                     size: 35,
                        color: AppConstant.appStatusColor,
                      ),
        
                      onPressed: () {
        
                      },
                      label: Text('Sign in with Email',
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
        
        
                    ),
                  ),
                ),
        
        
              ],
            )
        
        
            ),
      )
    );
  }
}
