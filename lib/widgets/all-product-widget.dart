


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/categories-models.dart';
import 'package:ecomm/models/product-model.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/product-details-screen.dart';
import 'package:ecomm/utils/app-constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class AllProductWidget extends StatelessWidget {
  const AllProductWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('products')
            .where('isSale', isEqualTo: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height /5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          };
          if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text(' No Products Found!'),
            );
          }
          if(snapshot.data != null){
            return Container(
              height: Get.height/4.5,
              child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.80,
                  ),

                  itemBuilder: (context, index){
                    final productData = snapshot.data!.docs[index];
                    ProductModel productModel =  ProductModel(
                        productId:  productData['productId'],
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
                        updatedAt: productData['updatedAt']
                    );

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: ()=> Get.to(()=> ProductDetailsScreen(productModel: productModel)),
                          child: Padding(padding: EdgeInsets.all(8.0),
                            child: Container(
                              child:FillImageCard(
                                borderRadius: 20.0,
                                width: Get.width/2.4,
                                heightImage: Get.height/6,
                                imageProvider: CachedNetworkImageProvider(productModel.productImages[0]),

                                title: Center(
                                    child: Text(productModel.productName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 12.0,),)
                                ),
                              footer:     Center(
                                child: Text('PKR:'+productModel.fullPrice,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 12.0,),),
                              )
                              ),
                            ),),
                        ),

                      ],
                    );
                  }
              ),
            );
          }
          return Container();
        }
    );
  }

}
