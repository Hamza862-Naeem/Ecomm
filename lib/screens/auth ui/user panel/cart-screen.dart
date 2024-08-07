import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/cart-price-controller.dart';
import 'package:ecomm/models/cart-model.dart';
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

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
 final ProductPriceController productPriceController =Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Cart Screen'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
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
                CartModel cartModel = CartModel(
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
                );
                productPriceController.fetchProductPrice();
                return SwipeActionCell(
                  key: ObjectKey(cartModel.productId),
                   trailingActions: [
                     SwipeAction(
                       title: 'Delete',
                         forceAlignmentToBoundary: true,
                         performsFirstActionWithFullSwipe: true,
                         onTap: (CompletionHandler handler) async{
                       await FirebaseFirestore.instance
                           .collection('cart').doc(user!.uid)
                           .collection('cartOrders')
                           .doc(cartModel.productId).delete();
                         },)
                   ],
                  child: Card(
                    elevation: 5.0,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appMainColor,
                        backgroundImage: NetworkImage(cartModel.productImages[0]),
                      ),
                      title: Text(cartModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(cartModel.productTotalPrice.toString()),
                          GestureDetector(
                            onTap:()async{
                              if(cartModel.productQuantity > 0){
                                await FirebaseFirestore.instance.collection('cart')
                                    .doc(user!.uid)
                                    .collection('cartOrders')
                                    .doc(cartModel.productId)
                                    .update({
                                  'productQuantity' : cartModel.productQuantity +1,
                                  'productTotalPrice':double.parse(cartModel.fullPrice)
                                      //+double.parse(cartModel.fullPrice)
                                          * (cartModel.productQuantity)
                                });
                              }
                            } ,
                            child: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              radius: 14.0,
                              child: Text('+'),
                            ),
                          ),
                          SizedBox(
                            width: Get.width / 20.0,
                          ),
                          GestureDetector(
                            onTap:() async{
                              if(cartModel.productQuantity>1){
                             await FirebaseFirestore.instance.collection('cart').doc(user!.uid).collection('cartOrders')
                                 .doc(cartModel.productId).update({
                               'productQuantity': cartModel.productQuantity -1,
                               'productTotalPrice': (double.parse
                                 (cartModel.fullPrice) * (cartModel.productQuantity -1) )
                             });
                              }
                            } ,
                            child: CircleAvatar(
                              backgroundColor: AppConstant.appMainColor,
                              radius: 14.0,
                              child: Text('-'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(
              width: Get.width / 40,
            ),Obx(()=>
            Text(" Total ${productPriceController.totalPrice.value.toStringAsFixed(1)}: PKR"),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                child: Container(
                  height: Get.height / 18,
                  width: Get.width / 2.0,
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    child: Text('Checkout'),
                    onPressed: () {
                      Get.to(()=> CheckOutScreen());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
