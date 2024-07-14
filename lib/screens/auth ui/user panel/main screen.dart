
import 'package:ecomm/screens/auth%20ui/user%20panel/all-categories-screen.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/all-flash-sale-products.dart';
import 'package:ecomm/screens/auth%20ui/welcome_screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:ecomm/widgets/all-product-widget.dart';
import 'package:ecomm/widgets/banner-widget.dart';
import 'package:ecomm/widgets/category-widget.dart';
import 'package:ecomm/widgets/custom-drawer.dart';
import 'package:ecomm/widgets/flash-sale-widget.dart';
import 'package:ecomm/widgets/heading-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'all-product-screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light),
        title: Text(AppConstant.appMainName,
        style: TextStyle(color: AppConstant.appTextColor),),
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Get.height/90.0,),
              BannerWidget(),
              HeadingWidget(
                headingTitle: 'Categories',
                headingSubTitle: 'According to your budget',
                onTap: () => Get.to(()=> AllCategoriesScreen()),

                  buttonText: 'See More >',
              ),
              CategoryWidget(),
              HeadingWidget(
                headingTitle: 'Flash Sale',
                headingSubTitle: 'According to your budget',
                onTap:() => Get.to(()=> AllFlashSaleProductScreen()),
                buttonText: 'See More >',
              ),
              FlashSaleWidget(),
              HeadingWidget(
                headingTitle: 'All Products',
                headingSubTitle: 'According to your budget',
                onTap:() => Get.to(()=> AllProductScreen()),
                buttonText: 'See More >',
              ),
              AllProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
