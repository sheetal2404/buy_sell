
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import '../screens/authentication/otp_screen.dart';
import '../screens/location_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context) async {
    // Call the user's CollectionReference to add a new user
    //check user data existss in firebase or not

    final QuerySnapshot result = await users.where('uid', isEqualTo: user.uid).get();

    List <DocumentSnapshot> document = result.docs;

    if(document.length>0){
      
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    }else{

      return users.doc(user.uid)
          .set({
        'uid': user.uid, // John Doe
        'mobile': user.phoneNumber, // Stokes and Sons
        'email': user.email // 42
      })
          .then((value){
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      })
          .catchError((error) => print("Failed to add user: $error"));

    }


  }


  Future<void>verifyPhoneNumber(BuildContext context, number)async{
    //context is for navigation
    final PhoneVerificationCompleted verificationCompleted=
    (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential);

    };

    final PhoneVerificationFailed verificationFailed =
    (FirebaseAuthException e){
      if(e.code == 'invalid phone number'){
        print("The provider phone number is not valid.");
      }
      print('the error is ${e.code}');
    };

    final PhoneCodeSent codeSent = (String verId, int resendToken)async{

      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(number: number,verId:verId ,),),);

    };

    try{
      await auth.verifyPhoneNumber(phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId){
        print(verificationId);

          });
    }
    catch(e){
      print('error ${e.toString()}');
    }


  }
}