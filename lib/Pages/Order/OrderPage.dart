// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../moduls/Animation.dart';
import 'SaveOrder.dart';

class OrderInfo extends StatefulWidget {
 const OrderInfo({Key key,this.address,this.userData,this.userLat,this.userLong,this.paymentType,this.Fees,this.Service,this.SelectedDate,this.Worker, this.userAddress, this.userLatLong}) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;
  final double userLat;
  final double userLong;
  final String paymentType;
  final String userAddress;
  final Position userLatLong;
  final String Fees;
  final String Service;
  final String SelectedDate;
  final String Worker;
  final String address;
  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  final GlobalKey<ScaffoldState>_scaffoldkey = GlobalKey();
  int OrderNum=Random.secure().nextInt(9999999);

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
     child:Padding(
        padding:EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Text("  Order Info",style: TextStyle(fontSize: 25,color:Color.fromARGB(255, 39, 12, 75) ),),
            SizedBox(height: 20,),
             //Order Info
            FadeAnimation(0.4,Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration:BoxDecoration(
                color:Color.fromARGB(193, 46, 12, 61),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding:EdgeInsets.all(8.0),   
                child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("#${OrderNum}",style: TextStyle(fontSize: 20,color: Color.fromARGB(187, 255, 153, 0)),),],),
                  SizedBox(height: 10,),
                  Divider(color: Colors.black,thickness: 2),
                  //Service Type
                  Text("Service:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.Service}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Worker
                  Text("Worker:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.Worker}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Date
                  Text("Choosen Date:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.SelectedDate}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Address
                  Text("Address:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.address}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Contact Number
                  Text("Contact Number:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.userData.data()['UserPhone']}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Fees
                  Text("Fees:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('          ${widget.Fees} SAR',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                  Divider(color: Colors.black,thickness: 2),
                  //Payment
                  Text("Payment:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                  SizedBox(height: 10,),
                  Text('         ${widget.paymentType}',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                  SizedBox(height: 5,),
                ],
              ),),
              ),
              ),
            SizedBox(height: 24,),
            GestureDetector(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 10, 167),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Set Order',style: TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                onTap: () {
                  OrderDialog();
                },
              ),
              
          ],
        ), 
        ),
)
      );
  }

  


  creatOrder(){
    Map<String,dynamic>orderDoc;
    setState(() {
      orderDoc={
        'OrderNo':OrderNum,
        'OrderTime':DateTime.now(),
        'Service':widget.Service,
        'ServiceDate':widget.SelectedDate,
        'ServiceFees':widget.Fees,
        'WorkerName':widget.Worker,
        'PaymentType':widget.paymentType,
        'OrderLocationLink':'https://www.google.com/maps/search/?api=1&query=' + widget.userLat.toString() + ',' + widget.userLong.toString(), 
        'OrderLocationLat':widget.userLat,
        'OrderLocationLong':widget.userLong,
        'UserName':widget.userData.data()['UserName'],
        'UserPhoneNumber':widget.userData.data()['UserPhone'],
        'UserID':widget.userData.id,
        'UserAddress':widget.address
      };
    });
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => SaveOrder(userData : widget.userData,
    order:orderDoc,userAddress:widget.userAddress,userLatLong:widget.userLatLong,)));
                    
  }

    Future OrderDialog() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              'Are sure you want to set order ?',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            //Button
            actions: [
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 5,),
                TextButton(
                  onPressed: (){Navigator.of(context).pop();} ,
                  child: Text('No'),),
                  Spacer(),
                  //change name
                GestureDetector(
                  onTap: (){
                    creatOrder();
                  },
                  child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 65, 10, 167)),
                      child: Center(
                        child: Text(
                          "yes",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                ),
                SizedBox(
                  width: 5,
                )
              ]),
              SizedBox(
                height: 30,
              ),
            ],
          );
      }
    );
 
}