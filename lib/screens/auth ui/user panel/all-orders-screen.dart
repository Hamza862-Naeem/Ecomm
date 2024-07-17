
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/cart-price-controller.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/order-model.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/add-review-screen.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/checkout-screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../../models/product-model.dart';
import '../sign_in_screen.dart';
import 'product-details-screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('All Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No Products Found!'),
            );
          }
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                OrderModel orderModel = OrderModel(
                  productId: productData['productId'],
                  categoryId: productData['categoryId'],
                  productName: productData['productName'],
                  categoryName: productData['categoryName'],
                  salePrice: productData['salePrice'],
                  fullPrice: productData['fullPrice'],
                  productImages: productData['productImages'],
                  deliveryTime: productData['deliveryTime'],
                  isSale: productData['isSale'],
                  productDescription: productData['productDescription'],
                  createdAt: productData['createdAt'],
                  updatedAt: productData['updatedAt'],
                  productQuantity: productData['productQuantity'],
                  productTotalPrice: productData['productTotalPrice'],
                  customerId:productData ['customerId'],
                  status: productData['status'],
                  customerName: productData['customerName'],
                  customerPhone: productData['customerPhone'],
                  customerAddress: productData['customerAddress'],
                  customerDeviceToken: productData['customerDeviceToken'],
                );
                productPriceController.fetchProductPrice();
                return  Card(
                  elevation: 5.0,
                  color: AppConstant.appTextColor,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppConstant.appMainColor,
                      backgroundImage: NetworkImage(orderModel.productImages[0]),
                    ),
                    title: Text(orderModel.productName),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(orderModel.productTotalPrice.toString()),
                         SizedBox(width: 10.0,),
                        orderModel.status != true?
                           Text('Pending...',style: TextStyle(color: Colors.green),)
                            :Text('Delivered',style: TextStyle(color: Colors.red),)
                      ],
                    ),
                    trailing:orderModel.status == true ?ElevatedButton(
                      onPressed: ()=> Get.to(()=> AddReviewScreen(
                        orderModel: orderModel
                      )),
                      child: Text('Review'),
                    )
                        :SizedBox.shrink()
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),

    );
  }
}
