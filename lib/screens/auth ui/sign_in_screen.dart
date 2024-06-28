
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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword =TextEditingController();

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
            body: SingleChildScrollView(
              child: Container(
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
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: Get.width,
              
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Obx(() => TextFormField(
                            controller: userPassword,
                            obscureText: signInController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    signInController.isPasswordVisible.toggle();
                                  },
                                  child:signInController.isPasswordVisible.value?
                                  Icon(Icons.visibility_off) :
                                  Icon(Icons.visibility),
                                ),
                                contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),)
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
              
                          onPressed: () async{
                           String email = userEmail.text.trim();
                           String password = userPassword.text.trim();
                           
                           if (email.isEmpty  || password.isEmpty){
                             Get.snackbar('error', 'Please enter all details',
                             snackPosition: SnackPosition.BOTTOM,
                             backgroundColor: AppConstant.appSecondaryColor,
                             colorText: AppConstant.appTextColor);
                           }else{
                             UserCredential? userCredential=
                                 await signInController.signInMethod(email, password);
                           if(userCredential != null ){
                             if(userCredential.user!.emailVerified){
                              Get.snackbar('Success',
                                  'Login Successfully!',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appSecondaryColor,
                                  colorText: AppConstant.appTextColor);
                              Get.offAll(()=> MainScreen());
                             }else{
                               Get.snackbar('Error',
                                   'Please verify your email , before login',
                                   snackPosition: SnackPosition.BOTTOM,
                                   backgroundColor: AppConstant.appSecondaryColor,
                                   colorText: AppConstant.appTextColor);
                             }
                           }
                           else{
                             Get.snackbar('error', 'please try again',
                                 snackPosition: SnackPosition.BOTTOM,
                                 backgroundColor: AppConstant.appSecondaryColor,
                                 colorText: AppConstant.appTextColor);
                           }
              
                           }
              
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
                    GestureDetector(
                      onTap:(){
                        Get.to(()=> ForgetPasswordScreen());
                      },
                      child: Container(
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=> ForgetPasswordScreen());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppConstant.appSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
            ),
          );

    });
  }
}
