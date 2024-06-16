
import 'package:ecomm/controllers/sign_in_controller.dart';
import 'package:ecomm/screens/auth%20ui/forget_password_screen.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/main%20screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/forgot_password_controller.dart';
import 'sign_up_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppConstant.appSecondaryColor,
              title: Text('Forget Password',style: TextStyle(color: AppConstant.appTextColor),),
            ),
            body: Container(
              child: Column(
                children: [

                  Container(
                    color: AppConstant.appSecondaryColor,
                    child: Column(
                        children:[
                          isKeyboardVisible?  SizedBox.shrink():
                          Lottie.asset('assets/images/cart.json')
                        ]
                    ),
                  ),
                  SizedBox(height: Get.height/55,),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: Get.width,

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: userEmail,
                          cursorColor: AppConstant.appSecondaryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ),
                      )),
                  SizedBox(height: Get.height/55,),

                  SizedBox(
                    height: Get.height/30,
                  ),
                  Material(
                    child:Container(
                      height: Get.height/18,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        color: AppConstant.appSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(

                        onPressed: () async{
                          User? user = FirebaseAuth.instance.currentUser;
                          String email = userEmail.text.trim();
                          if (user == null) {
                            Get.snackbar('Error', 'You need to be logged in to change your password',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor);
                          }
                          if (email.isEmpty  ){
                            Get.snackbar('error', 'Please enter all details',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondaryColor,
                                colorText: AppConstant.appTextColor);
                          }
                          else {
                            String email= userEmail.text.trim();
                            forgetPasswordController.ForgetPasswordMethod(email);
                          }

                        },




                        child:Text('Forget Password',
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),


                      ),
                    ),

                  ),
                  SizedBox(
                    height: Get.height/20,
                  ),
                  GestureDetector(
                    onTap:(){
                      Get.to(()=> ForgetPasswordScreen());
                    },
                    child: Container(),
                  ),


                ],
              ),
            ),
          );

        });
  }
}
