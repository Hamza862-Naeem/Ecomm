
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/models/order-model.dart';
import 'package:ecomm/models/review-model.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewScreen({super.key, required this.orderModel});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
 TextEditingController feedbackController =TextEditingController();
 double productRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reviews'),
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Add Your Rating please'),
            SizedBox(height: 10.0,),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _)=> Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating){
                productRating = rating;
                print(productRating);
                setState(() {

                });
              },
            ),SizedBox(height: 20.0,),
            Text('Feedback'),
            SizedBox(height: 20.0,),
            TextFormField(
              controller: feedbackController,
              decoration: InputDecoration(
                label: Text('Share your Feedback'),
              ),
            ),SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed:()async {
                  EasyLoading.show(status: 'Please wait');
              String feedback= feedbackController.text.trim();

             ReviewModel reviewModel= ReviewModel(
                  customerName: widget.orderModel.customerName ,
                  customerPhone: widget.orderModel.customerPhone,
                  customerDeviceToken: widget.orderModel.customerDeviceToken,
                  customerId: widget.orderModel.customerId,
                  feedback: feedback,
                  rating: productRating.toString(),
                  createdAt: DateTime.now());
            await FirebaseFirestore.instance.collection('products').doc(widget.orderModel.productId).collection('reviews').doc(widget.orderModel.customerId).set(reviewModel.toMap());
            EasyLoading.dismiss();
            },
                child:Text('Save'))
          ],
        )
      ),
    );
  }
}
