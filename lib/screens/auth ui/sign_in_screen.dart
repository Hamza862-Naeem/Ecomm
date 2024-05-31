
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
      return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Scaffold(
           appBar: AppBar(
             centerTitle: true,
             backgroundColor: AppConstant.appSecondaryColor,
             title: Text('Sign In',style: TextStyle(color: AppConstant.appTextColor),),
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
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: Get.width,

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          cursorColor: AppConstant.appSecondaryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: Icon(Icons.visibility_off),
                              contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ),
                      )),
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

                        onPressed: () {

                        },
                        child:Text('SIGN IN',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("Don't have an account? ",
                    style: TextStyle(color: AppConstant.appSecondaryColor),
                    ),

                      GestureDetector(
                        onTap: () => Get.offAll(()=> SignUpScreen()),
                        child: Text('Sign Up',
                          style: TextStyle(
                              color: AppConstant.appSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                        ),
                      )
                  ],)

                ],
              ),
            ),
          );

    });
  }
}
