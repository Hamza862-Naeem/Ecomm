
import 'package:ecomm/utils/app-constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondaryColor,
          statusBarIconBrightness: Brightness.light),
        title: Text(AppConstant.appMainName),
        backgroundColor: AppConstant.appMainColor,
        centerTitle: true,
      ),
    );
  }
}
