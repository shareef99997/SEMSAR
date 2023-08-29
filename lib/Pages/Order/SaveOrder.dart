import 'package:SEMSAR/Pages/HomePage.dart';
import 'package:SEMSAR/moduls/SendNotification.dart';
import 'package:SEMSAR/moduls/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class SaveOrder extends StatefulWidget {
  const SaveOrder({Key key ,this.userData,this.order, this.userAddress, this.userLatLong}) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;
  final Map<String,dynamic>order;
  final String userAddress;
  final Position userLatLong;

  @override
  State<SaveOrder> createState() => _SaveOrderState();
}

class _SaveOrderState extends State<SaveOrder> {
  final GlobalKey<ScaffoldState>_scaffoldkey = GlobalKey();
  String loaderText = 'Setting Up your order ⏳';
  bool orderFinish=false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); 

  @override
  void initState(){
    saveOrder();
    super.initState();
  }


  saveOrder()async{
    try {
      Future.delayed(Duration(seconds: 3),()async{
        await FirebaseFirestore.instance.collection('Orders').add(widget.order).then((orderDoc)async{
          if (!mounted)return;
          Future.delayed(Duration(seconds:2),(){
            setState(() {
            loaderText ='All Done ✅';
            orderFinish = true;
          });});
          
          showInWaitingSnackBar("Your Order Have Been Set Successfully ", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldkey);
          SendNotification(body:"test" ,title:"test" ,userID: widget.userData.data()['UserID'],);
         Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => HomePage(userData : widget.userData,userAddress:widget.userAddress,
                    userLatLong:widget.userLatLong,
         )),(Route<dynamic> route) => false);
        }  
        );
      });
    } catch (e) {
      Future.delayed(Duration(seconds: 3),()async{
        if (!mounted) return;
        showInSnackBar('Order Cannot be placed due to an error', Colors.red, Colors.white, 10, context, _scaffoldkey);
         Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => HomePage(userData : widget.userData,userAddress:widget.userAddress,
                    userLatLong:widget.userLatLong,
         )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: ColorfulBackground(
     // Color changing animation duration
     duration: Duration(seconds: 10),
     // List colors to animate in the background
     backgroundColors: [
       Color.fromARGB(255, 214, 187, 241),
       Color.fromARGB(255, 255, 255, 255),
     ],
     child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(loaderText,style: TextStyle(color: Color.fromARGB(255, 39, 12, 75),fontSize: 20),),
            SizedBox(height: 30,),
            Visibility(
              visible: orderFinish,
              child: Icon(LineIcons.checkCircle,color: Colors.green,size: 150,),
              replacement: LoadingAnimationWidget.discreteCircle(color: Color.fromARGB(255, 88, 19, 128), size: 150),
              ),
              SizedBox(height: 30,)
            
          ],
        ),
      ),
    
)
      );
  }
}