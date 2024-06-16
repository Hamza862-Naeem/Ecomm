import 'package:ecomm/screens/auth%20ui/sign_in_screen.dart';
import 'package:ecomm/screens/auth%20ui/sign_up_screen.dart';
import 'package:ecomm/screens/auth%20ui/user%20panel/main%20screen.dart';
import 'package:ecomm/utils/app-constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'screens/auth ui/splash_screen.dart';
import 'screens/auth ui/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      home:SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
