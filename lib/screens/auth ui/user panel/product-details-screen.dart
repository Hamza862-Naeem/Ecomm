

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sign_in_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
   ProductDetailsScreen({super.key, required  this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Prodcts Details'),
      ),
      body: Container(
        child:Column(
          children: [
            SizedBox(
              height: Get.height/60,
            ),
            CarouselSlider(
              items: widget.productModel.productImages
                  .map((imageurl)=> ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage
                  (imageUrl:imageurl,fit: BoxFit.cover,
                  width: Get.width -10,
                  placeholder: (context,url) =>
                      ColoredBox(color: Colors.white, child: Center(
                        child: CupertinoActivityIndicator(),
                      ),),
                  errorWidget: (context, url,error)=> Icon(Icons.error),
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
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                               widget.productModel.isSale ==true && widget.productModel.salePrice != 'not availabe'?
                               Text(
                                  'PKR:'+ widget.productModel.salePrice):
                                   Text(
                                     'PKR :' + widget.productModel.fullPrice
                                   )
                             ],
                           )),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                           alignment: Alignment.topLeft,
                           child: Text(
                             'Category:'+  widget.productModel.categoryName)),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                           alignment: Alignment.topLeft,
                           child: Text(
                             'Description:'+ widget.productModel.productDescription)),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Material(
                             child:Container(
                               height: Get.height/16,
                               width: Get.width/2.8,
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
                                      style: TextStyle(color: AppConstant.appTextColor),
                                    ),
                                  ],
                                ),

                                 onPressed: () {
                               //    Get.to(()=> SignInScreen());
                                 },



                               ),
                             ),
                           ),
                           SizedBox(
                             width: 8.0,
                           ),
                           Material(
                             child:Container(
                               height: Get.height/16,
                               width: Get.width/2.9,
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
                                       style: TextStyle(color: AppConstant.appTextColor),
                                     ),
                                   ],
                                 ),

                                 onPressed: () {
                                   //    Get.to(()=> SignInScreen());
                                 },



                               ),

                             ),
                           ),
                         ],
                       ),
                     ),
                
                 ]  ),
                ),),
              ),
            ),
          ],
        )
      ),
    );
  }
}
