
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/order-model.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/main%20screen.dart';
import 'package:ecomm/services/generate-order-id-service.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void placeOrder({
  required BuildContext context,
  required String customerDeviceToken,
  required String customerAddress,
  required String customerPhone,
  required String customerName})async
{
   final user = FirebaseAuth.instance.currentUser;
   if(user!= null){
     try{
       QuerySnapshot querySnapshot =
       await FirebaseFirestore
           .instance.collection('cart')
           .doc(user!.uid)
           .collection('cartOrders')
           .get();

       List<QueryDocumentSnapshot> documents = querySnapshot.docs;

       for(var doc in documents ){
         Map<String,dynamic>? data = doc.data() as Map<String,dynamic>;

       String orderId = generateOrderId();

       OrderModel cartModel = OrderModel(
         productId:data['productId'],
         categoryId: data['categoryId'],
         productName: data['productName'],
         categoryName: data['categoryName'],
         salePrice: data['salePrice'],
         fullPrice: data['fullPrice'],
         productImages: data['productImages'],
         deliveryTime: data['deliveryTime'],
         isSale: data['isSale'],
         productDescription: data['productDescription'],
         createdAt: DateTime.now(),
         updatedAt: data['updatedAt'],
         productQuantity: data['productQuantity'],
         productTotalPrice: double.parse(data['productTotalPrice'].toString()),
         customerId:user.uid,
         status: false,
         customerName: customerName,
         customerPhone: customerPhone,
         customerAddress: customerAddress,
         customerDeviceToken: customerDeviceToken,
       );
       for(var x=0; x< documents.length; x++){
         await FirebaseFirestore.instance
             .collection('orders')
             .doc(user.uid).set({
           'uId': user.uid,
           'customerName': customerName,
           'customerPhone': customerPhone,
           'customerAddress': customerAddress,
           'customerDeviceToken': customerDeviceToken,
           'orderStatus': false,
           'cretedAt': DateTime.now()
         });
         //upload orders
         await FirebaseFirestore.instance
             .collection('orders')
             .doc(user.uid).collection('confirmOrders')
             .doc(orderId).set(cartModel.toMap());

         //delete cart products
         await FirebaseFirestore.instance
             .collection('cart').doc(user.uid)
             .collection('cartOrders')
             .doc(cartModel.productId.toString())
             .delete().then((value){
               print('Delete cart Products $cartModel.productId.toString()');
         });
       }
     }
       print('Order Confirmed');
       Get.snackbar(
         'Order confirmed',
         'Thank u for shopping here!!!',
         backgroundColor: AppConstant.appMainColor,
         colorText: Colors.white,
         duration: Duration(seconds: 4),
       );
       EasyLoading.dismiss();
       Get.offAll(()=> MainScreen());
     }
     catch(e){
       print('Error $e');
     }
   }
}