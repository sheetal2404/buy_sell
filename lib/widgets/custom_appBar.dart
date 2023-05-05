import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/firebase_services.dart';

import '../screens/location_screen.dart';

class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();

    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(_service.user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (!snapshot.hasData && !snapshot.data.exists) {
          return Text("Address not selected");
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data.data() ;

          if(data['address']==null){
              GeoPoint latlong = data['location'];
              _service.getAdress(latlong.latitude, latlong.longitude).then((adres){
                return appbar(adres, context);
              });

          }
          else{
            return appbar(data['address'], context);
          }
        }

        return Text("Fetching Location...");
      },
    );
  }

  Widget appbar(address, context){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: InkWell(
        onTap: (){
          Navigator.pushNamed(context, LocationScreen.id);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,

          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8,),
            child: Row(
              children: [
                Icon(CupertinoIcons.location_solid,color: Colors.black, size:18),

                Text(address, style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                ),
                Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black, size: 18,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


