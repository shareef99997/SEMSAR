
import 'package:SEMSAR/Pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SEMSAR/Authentecation/AuthenticationPage.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart'as geo;
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userAddress;
  Position userLatLong;
  @override
  void initState() {   
    getLocation();
    navigateafterDuration();
    super.initState();
  }
  
  getLocation()async{
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = Coordinates(position.latitude ,position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
       userAddress = '${first.addressLine}';
       userLatLong = position;
       print('//////////////////////////// \n ${first.addressLine} \n / /////////////////////////');
    });
    print('https://www.google.com/maps/search/?api=1&query=' + position.latitude.toString()+',' + position.longitude.toString());
  }

  void navigateafterDuration()async{
    getLocation();
    User user=FirebaseAuth.instance.currentUser;
    if(user!=null&&user.uid!=null){
      Future.delayed(Duration(seconds: 4),()async{
        await FirebaseFirestore.instance.collection('UsersAccount').doc(user.uid).get().then((userDoc) async {
          if(userDoc.id!=null&&userDoc.data().isNotEmpty==true){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => HomePage(userData: userDoc,userAddress: userAddress,userLatLong: userLatLong,)));
          }else{
            await FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => AuthenticationPage()));
              
            });
          }
        });
      });
    }else{
      Future.delayed(Duration(seconds: 4),()async{
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => AuthenticationPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(children:<Widget> [
            Padding(padding: EdgeInsets.only(top: 300)),
            Image(image:AssetImage('assets/images/LOGO.png'),
            height: 150,
            width: 150,
             ),
             SizedBox(height: 50,),
             LoadingAnimationWidget.dotsTriangle(color: Color.fromARGB(255, 88, 19, 128), size: 50),
             Padding(padding: EdgeInsets.only(top: 150)),
             
          ],
          ) 
        ),
      ),
    );
  }
}
