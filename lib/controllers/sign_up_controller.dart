

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/get-device-token-controller.dart';
import 'package:ecomm/models/user%20model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/app-constants.dart';

class SignUpController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  var isPasswordVisible = false.obs;

  Future<UserCredential?> signUpMethod(
      String username,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,)
  async{
    final GetDeviceTokenController getDeviceTokenController=
    Get.put(GetDeviceTokenController());
    try{
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential  = await _auth.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword);
     //send email verfification to login
    await  userCredential.user!.sendEmailVerification();

    UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: username,
        email: userEmail,
        phone: userPhone,
        userImg: '',
        userDeviceToken: getDeviceTokenController.deviceToken.toString(),
        country: '',
        userAddress: '',
        street: '',
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      city: 'userCity',
    );
    //add data into database
          _firestore.collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());
          EasyLoading.dismiss();
          return userCredential;
    }
    on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      Get.snackbar('Error',
          '$e',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appSecondaryColor,
      colorText: AppConstant.appTextColor,);
    }
  }
}