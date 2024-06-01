
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController{
  final GoogleSignIn googleSignIn=GoogleSignIn();
  final FirebaseAuth _auth =FirebaseAuth.instance;



  Future<void> signInWithGoogle()async {
    try{
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication=
      await googleSignInAccount.authentication;

        final AuthCredential credential= GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential=
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;
      }
    }
        catch (e){
      print('error $e');
        }
  }
}