// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyACRyxW4yP-ewPVAOrcKLU1ytHwH0Eriww',
    appId: '1:545879564928:web:4564e1f72b56dbb67f7c65',
    messagingSenderId: '545879564928',
    projectId: 'ecomm-app-3bb40',
    authDomain: 'ecomm-app-3bb40.firebaseapp.com',
    storageBucket: 'ecomm-app-3bb40.appspot.com',
    measurementId: 'G-MJNWD1CWFD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-_bqVtkH0aXYGeakX3aR40qzhp8jQxO0',
    appId: '1:545879564928:android:7eed2d90888b8fff7f7c65',
    messagingSenderId: '545879564928',
    projectId: 'ecomm-app-3bb40',
    storageBucket: 'ecomm-app-3bb40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA9VRSCO-Ay20kFeKFDm-5Pm8-jnS-nNuk',
    appId: '1:545879564928:ios:826bcfa615d31f3e7f7c65',
    messagingSenderId: '545879564928',
    projectId: 'ecomm-app-3bb40',
    storageBucket: 'ecomm-app-3bb40.appspot.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA9VRSCO-Ay20kFeKFDm-5Pm8-jnS-nNuk',
    appId: '1:545879564928:ios:826bcfa615d31f3e7f7c65',
    messagingSenderId: '545879564928',
    projectId: 'ecomm-app-3bb40',
    storageBucket: 'ecomm-app-3bb40.appspot.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyACRyxW4yP-ewPVAOrcKLU1ytHwH0Eriww',
    appId: '1:545879564928:web:2ebf4b24e2d4a6cc7f7c65',
    messagingSenderId: '545879564928',
    projectId: 'ecomm-app-3bb40',
    authDomain: 'ecomm-app-3bb40.firebaseapp.com',
    storageBucket: 'ecomm-app-3bb40.appspot.com',
    measurementId: 'G-79X0BJN8K9',
  );
}