import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_ui.dart';
import 'location_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'login-screen';
  @override
  Widget build(BuildContext context) {


    /*FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user){
      if (user == null){
        print('user is currently signed out');
      }else{
        // if its already logged in it will not ask to login again
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }
    });*/

    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: Column(
        children: [
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                    height: 100,
                ),
                Image.asset(
                    'assets/images/book1.png',
                color: Colors.cyan.shade900,
                ),
                SizedBox(height: 10,),
                Text('Buy or Sell',style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade900
                ),)
              ],
            )
          ),),
          Expanded(child: Container(
            child: AuthUi(),
          ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'If you continue, you are acception\nTerms and conditions and Privacy policy',
            textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 10),),
          )
        ],
      ),

    );
  }
}

