

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import '../screens/authentication/otp_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;




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

    final PhoneCodeSent codeSent = (String verId, int? resendToken)async{

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