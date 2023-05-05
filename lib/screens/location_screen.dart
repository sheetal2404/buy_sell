import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/screens/login_screen.dart';

import '../main.dart';

class LocationScreen extends StatefulWidget {
  static const String id = 'location-screen';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _loading = false;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";


  Future<LocationData> getLocation()async{

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;

  }//we get current location details


  @override
  Widget build(BuildContext context) {

    showBottomScreen(context){
      showModalBottomSheet(
        isScrollControlled: true,
          enableDrag: true,
          context: context,
          builder: (context){
            return Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                AppBar(
                  automaticallyImplyLeading: false,
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                  elevation: 1,
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                           Navigator.pop(context);
                      },
                        icon: Icon(Icons.clear),
                      ),
                      SizedBox(width: 10,),
                      Text('Location', style: TextStyle(color: Colors.black))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'serach city by are or neighborhood',
                          hintStyle: TextStyle(color: Colors.grey),
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: (){},
                  horizontalTitleGap: 0.0,
                  leading: Icon(Icons.my_location,color: Colors.blue,),
                  title: Text("use current locaion",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Enable loaction', style: TextStyle(fontSize: 12),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      'CHOOSE CITY',
                      style: TextStyle(
                          color: Colors.blueGrey.shade900,fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: CSCPicker(
                    layout: Layout.vertical,
                    dropdownDecoration: BoxDecoration(shape: BoxShape.rectangle),
                    //defaultCountry: DefaultCountry.India,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged:(value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged:(value) {
                      setState(() {
                        cityValue = value;
                        address= '$cityValue, $stateValue, ${countryValue.substring(6)}';
                      });
                      print(address);
                    },
                  ),
                ),

              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Image.asset('assets/images/location.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Where do you want\nto buy or sell products',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:25,
              ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'To ejoy all that we have to offer you\nwe need to know where to look for them',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left:20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _loading ? Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ))
                      : ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                    ),

                    icon: Icon(CupertinoIcons.location_fill),
                      label: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom:15),
                        child: Text(
                          'Around me',
                        ),
                      ),
                    onPressed: (){
                      setState((){
                        _loading = true;
                      }
                      );
                      getLocation().then((value){
                        print(_locationData.latitude);
                        if(value!=null){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen(
                                    locationData: _locationData,
                                  ),
                          ),
                          );
                        }
                      });
                    },
                  ),
                ),

              ],
            ),
          ),
          InkWell(
            onTap: (){
              showBottomScreen(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide())
                ),
                child: Text(
                  'Set Location manually',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

