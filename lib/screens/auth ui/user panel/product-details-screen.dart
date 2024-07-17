import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/rating_controller.dart';
import 'package:ecomm/models/cart-model.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/models/review-model.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cart-screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;

  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CalculateProductRatingController calculateProductRatingController =Get.put(CalculateProductRatingController(widget.productModel.productId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Products Details'),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
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
                  .map(
                    (imageurl) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: imageurl,
                    fit: BoxFit.cover,
                    width: Get.width - 10,
                    placeholder: (context, url) => ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )
                  .toList(),
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                aspectRatio: 2.5,
                viewportFraction: 1,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.productModel.productName),
                                Icon(Icons.favorite_outline),
                              ],
                            ),
                          ),
                        ),
                        //reviews
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: RatingBar.builder(
                                glow: false,
                                ignoreGestures: true,
                                initialRating: double.parse(
                                    calculateProductRatingController.averageRating.toString()),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context,_) =>Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value){},

                              ),
                            ),
                            Text(calculateProductRatingController.averageRating.toString()),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                widget.productModel.isSale &&
                                    widget.productModel.salePrice !=
                                        'not available'
                                    ? Text('PKR: ${widget.productModel.salePrice}')
                                    : Text('PKR: ${widget.productModel.fullPrice}')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text('Category: ${widget.productModel.categoryName}'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                'Description: ${widget.productModel.productDescription}'),
                          ),
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
                                        Icon(
                                          Icons.shopping_cart,
                                          color: AppConstant.appTextColor,
                                        ),
                                        SizedBox(
                                          width: 3.6,
                                        ),
                                        Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              color: AppConstant.appTextColor),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
                                      await checkProductExistence(uId: user!.uid);
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
                                              color: AppConstant.appTextColor),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      sendMessageOnWhatsApp(
                                        productModel: widget.productModel,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.productModel.productId)
                  .collection('reviews')
                  .get(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Get.height / 5,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No Reviews Found!'),
                  );
                }
                if (snapshot.data != null) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      ReviewModel reviewModel = ReviewModel(
                        customerName: data['customerName'],
                        customerPhone: data['customerPhone'],
                        customerDeviceToken: data['customerDeviceToken'],
                        customerId: data['customerId'],
                        feedback: data['feedback'],
                        rating: data['rating'],
                        createdAt: data['createdAt'],
                      );
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(reviewModel.customerName),
                          leading: CircleAvatar(
                            child: Text(reviewModel.customerName[0]),
                          ),
                          subtitle: Text(reviewModel.feedback),
                          trailing: Text(reviewModel.rating),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp({
    required ProductModel productModel,
  }) async {
    final number = '03316431862';
    final message =
        'Hi Ecomm\nI want to know about this product\n${productModel.productName}\n${productModel.productId}';
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> checkProductExistence({required String uId, int quantityIncrement = 1}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());
    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(
          widget.productModel.isSale ? widget.productModel.salePrice : widget.productModel.fullPrice) *
          updatedQuantity;
      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice,
      });
      print('Product Exists');
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
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
