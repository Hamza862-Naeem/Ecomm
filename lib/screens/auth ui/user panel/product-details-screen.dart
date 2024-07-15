

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cart-screen.dart';



class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
   ProductDetailsScreen({super.key, required  this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Prodcts Details'),
        actions: [

          GestureDetector(
            onTap:() => Get.to (() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),

      body: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 60,
              ),
              CarouselSlider(
                items: widget.productModel.productImages
                    .map((imageurl) =>
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage
                        (
                        imageUrl: imageurl,
                        fit: BoxFit.cover,
                        width: Get.width - 10,
                        placeholder: (context, url) =>
                            ColoredBox(color: Colors.white, child: Center(
                              child: CupertinoActivityIndicator(),
                            ),),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )).toList(),
                options: CarouselOptions(
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  aspectRatio: 2.5,
                  viewportFraction: 1,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                          widget.productModel.productName),
                                      Icon(Icons.favorite_outline)
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      widget.productModel.isSale == true &&
                                          widget.productModel.salePrice !=
                                              'not availabe' ?
                                      Text(
                                          'PKR:' +
                                              widget.productModel.salePrice) :
                                      Text(
                                          'PKR :' +
                                              widget.productModel.fullPrice
                                      )
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      'Category:' +
                                          widget.productModel.categoryName)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      'Description:' + widget.productModel
                                          .productDescription)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    child: Container(
                                      height: Get.height / 16,
                                      width: Get.width / 2.8,
                                      decoration: BoxDecoration(
                                        color: AppConstant.appSecondaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                        child: Row(
                                          children: [
                                            Icon(Icons.shopping_cart,
                                              color: AppConstant.appTextColor,),
                                            SizedBox(
                                              width: 3.6,
                                            ),

                                            Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                  color: AppConstant
                                                      .appTextColor),
                                            ),
                                          ],
                                        ),

                                        onPressed: () async {
                                          //    Get.to(()=> SignInScreen());
                                          await checkProductExistence(
                                          uId: user!.uid
                                          );
                                        },


                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Material(
                                    child: Container(
                                      height: Get.height / 16,
                                      width: Get.width / 2.9,
                                      decoration: BoxDecoration(
                                        color: AppConstant.appSecondaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.mobile_friendly,
                                              color: AppConstant.appTextColor,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              'WhatsApp',
                                              style: TextStyle(
                                                  color: AppConstant
                                                      .appTextColor),
                                            ),
                                          ],
                                        ),

                                        onPressed: ()  {
                                          //    Get.to(()=> SignInScreen());


                                        },


                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ]),
                    ),),
                ),
              ),
            ],
          )
      ),
    );
  }

  Future<void> checkProductExistence({required String uId, int quantityIncrement =1,}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId).collection('cartOrders').doc(
        widget.productModel.productId.toString()
    );
    DocumentSnapshot snapshot =await documentReference.get();

    if (snapshot.exists){
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale ? widget.productModel.salePrice : widget.productModel.fullPrice) * updatedQuantity;
      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice

      });
      print('Product Exists');
    }else{
      await FirebaseFirestore.instance.collection('cart').doc(uId).set(
        {
          'uId' : uId,
          'createdAt': DateTime.now(),
        },
      );
       CartModel   cartModel = CartModel(
           productId: widget.productModel.productId,
           categoryId: widget.productModel.categoryId,
           productName: widget.productModel.productName,
           categoryName: widget.productModel.categoryName,
           salePrice: widget.productModel.salePrice,
           fullPrice: widget.productModel.fullPrice,
           productImages: widget.productModel.productImages,
           deliveryTime: widget.productModel.deliveryTime,
           isSale: widget.productModel.isSale,
           productDescription:widget.productModel.productDescription,
           createdAt: DateTime.now(),
           updatedAt: DateTime.now(),
           productQuantity: 1,
           productTotalPrice: double.parse (widget.productModel.isSale ? widget.productModel.salePrice : widget.productModel.fullPrice),
       );


      await documentReference.set(cartModel.toMap());

      print('product added');
    }
  }
}
