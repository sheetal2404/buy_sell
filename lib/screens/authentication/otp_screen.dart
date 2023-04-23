import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/authentication/phoneauth_screen.dart';
import 'package:my_app/services/phoneauth_service.dart';

import '../location_screen.dart';

class OTPScreen extends StatefulWidget{
  final String number, verId;

  OTPScreen({required this.number, required this.verId});

  @override
  _OTPScreenState createState() => _OTPScreenState();

}

class _OTPScreenState extends State<OTPScreen>{

  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();


  Future<void>phoneCredential(BuildContext context, String otp,)async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verId , smsCode: otp);
      //need to see otp validated or not
      final User? user = (await _auth.signInWithCredential(credential)).user;

      if(user!=null){
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }else{
        print('login failed');
      }

    }catch(e){
      print(e.toString());

    }

  }


  @override
  Widget build(BuildContext context){

    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Login',style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              CircleAvatar(
                radius:30,
                backgroundColor: Colors.red.shade100,
                child: Icon(
                  CupertinoIcons.person_alt_circle,
                  size: 60,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10,),
              const Text('welcome Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                      text: 'We sent a 6 digit code to ',
                     style: TextStyle(color: Colors.grey, fontSize:12),
                      children: [
                        TextSpan(
                          text: widget.number,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12
                          )),
                      ],
                    ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneAuthScreen(),),);

                    },
                      child: Icon(Icons.edit)),
                ],
              ),

              SizedBox(height: 12,),
              Row(
                children: [
                 Expanded(
                   child: TextFormField(
                     textAlign: TextAlign.center,
                     controller: _text1,
                     keyboardType: TextInputType.number,
                     textInputAction: TextInputAction.next,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                     ),
                     onChanged: (value){
                       if(value.length==1){
                         node.nextFocus();
                       }
                     }
                   ),
                 ),
                 SizedBox(width:10,),
                  Expanded(
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _text2,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          if(value.length==1){
                            node.nextFocus();
                          }
                        }
                    ),
                  ),
                  SizedBox(width:10,),
                  Expanded(
                    child: TextFormField(
                        controller: _text3,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          if(value.length==1){
                            node.nextFocus();
                          }
                        }
                    ),
                  ),
                  SizedBox(width:10,),
                  Expanded(
                    child: TextFormField(
                        controller: _text4,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          if(value.length==1){
                            node.nextFocus();
                          }
                        }
                    ),
                  ),
                  SizedBox(width:10,),
                  Expanded(
                    child: TextFormField(
                        controller: _text5,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          if(value.length==1){
                            node.nextFocus();
                          }
                        }
                    ),
                  ),
                  SizedBox(width:10,),
                  Expanded(
                    child: TextFormField(
                        controller: _text6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value){
                          if(value.length==1){
                            if(_text1.text.length==1){
                              if(_text2.text.length==1){
                                if(_text3.text.length==1){
                                  if(_text4.text.length==1){
                                    if(_text5.text.length==1){
                                      String _otp = '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';


                                      phoneCredential(context, _otp);

                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
