

import 'package:ecomm/controllers/sign_up_controller.dart';
import 'package:ecomm/screens/auth%20ui/sign_in_screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
 TextEditingController username= TextEditingController();
  TextEditingController userEmail= TextEditingController();
  TextEditingController userPhone= TextEditingController();
  TextEditingController userCity= TextEditingController();
  TextEditingController userPassword= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppConstant.appSecondaryColor,
              title: Text(
                'Sign Up',
                style: TextStyle(color: AppConstant.appTextColor),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: Get.height / 9,
                      color: AppConstant.appSecondaryColor,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold// Adjust font size as needed
                            ),
                            children: [
                              TextSpan(text: 'Create\n'),
                              TextSpan(text: 'Account Here'),
                            ],
                          ),
                        ),
                      ),
                    ),
              
                        SizedBox(height: Get.height/40,),
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
                    SizedBox(height: Get.height/40,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: Get.width,
              
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: username,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                prefixIcon: Icon(Icons.person),
              
                                contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),
                        )),
                    SizedBox(height: Get.height/40,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: Get.width,
              
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: userPhone,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Phone No',
                                prefixIcon: Icon(Icons.phone_android),
              
                                contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),
                        )),
                    SizedBox(height: Get.height/40,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: Get.width,

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: userCity,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                                hintText: 'City',
                                prefixIcon: Icon(Icons.location_pin),

                                contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),
                        )),
                    SizedBox(height: Get.height/40,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: Get.width,

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Obx(() =>  TextFormField(
                            controller: userPassword,
                            obscureText: signUpController.isPasswordVisible.value,
                            cursorColor: AppConstant.appSecondaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    signUpController.isPasswordVisible.toggle();
                                  },
                              child:signUpController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility )),

                                contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            ),
                          ),)
                        )),



                    SizedBox(
                      height: Get.height/15,
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
                              String name = username.text.trim();
                              String email = userEmail.text.trim();
                              String phone = userPhone.text.trim();
                              String city = userCity.text.trim();
                              String password = userPassword.text.trim();
                              String userDeviceToken = '';

                              if( name.isEmpty
                                  || email.isEmpty
                                  || phone.isEmpty
                                  || city.isEmpty
                                  || password.isEmpty
                                  ){  Get.snackbar('Error',
                                 'Please enter all details',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appSecondaryColor,
                                  colorText: AppConstant.appTextColor,
                              );
                              } else {
                                UserCredential? userCredential =
                                    await signUpController.signUpMethod(
                                        name,
                                        email,
                                        phone,
                                        city,
                                        password,
                                        userDeviceToken
                                    );
                                if (userCredential != null){
                                  Get.snackbar('Verification Email sent',
                                      'Please check your email',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppConstant.appSecondaryColor,
                                      colorText: AppConstant.appTextColor );
                                  
                                 FirebaseAuth.instance.signOut();
                                 Get.offAll(()=> SignInScreen());
                                }
                              }
                          },
                          child:Text('SIGN UP',
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
              
              
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height/30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ",
              
                          style: TextStyle(color: AppConstant.appSecondaryColor,
                            fontSize: 18,
                          ),
              
                        ),
                        GestureDetector(
                          onTap: () => Get.offAll(SignInScreen()),
                          child: Text('Sign In',style: TextStyle(
                              color: AppConstant.appSecondaryColor,
                              fontSize: 20,
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
