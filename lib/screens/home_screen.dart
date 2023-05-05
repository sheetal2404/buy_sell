
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/widgets/custom_appBar.dart';

import 'location_screen.dart';

class HomeScreen extends StatefulWidget {

  static const String id = 'home-screen';



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String address = 'India';


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: SafeArea(child: CustomAppBar())),
      body: Center(
        child: ElevatedButton(child: Text('Sign Out',),onPressed: (){
          FirebaseAuth.instance.signOut().then((value){
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          });
        },),
      ),
    );
  }
}
