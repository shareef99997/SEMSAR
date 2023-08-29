
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../moduls/Animation.dart';
import '../../moduls/SnackBar.dart';
import 'OrderPage.dart';
class CheckOut extends StatefulWidget {
  const CheckOut({Key key,this.userData,this.service,this.price, this.userAddress, this.userLatLong, }) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;
  final String service;
  final String price;
  final String userAddress;
  final Position userLatLong;
  @override
  State<CheckOut> createState() => _CheckOutState();
}
  
class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  String googleMapURL ='https://www.google.com/maps/search/?api=1&query=<lat>,<lng>';
  String paymentType='Cash';
  int _selectedDay = 0;
  String _Location = "";
  double Latt  =24.732629846521423;
  double Loong = 46.77659634500742 ;

  checkLatLong(){
      if (widget.userLatLong ==null ) {
            Latt =24.732629846521423;
            Loong = 46.77659634500742; 
          print('/////////////////////////////\n LatLong dosen\'t have data ❌ ///////////////////////////////');                              
      } else {
            Latt = widget.userLatLong.latitude;
            Loong = widget.userLatLong.longitude;  
          print('/////////////////////////////\n LatLong Has Data✅ ///////////////////////////////');                                
      }

  }

  GoogleMapController mapController; //contrller for Google map
  CameraPosition cameraPosition;
  String loc ="" ;
  String selectedDate="";
  String PlPrice ="20.0";
  int _selectedWorker =0;
  String _WorkerName ="";
  final List<dynamic> _days = [
    [DateTime.now().day, DateFormat('EEEE').format(DateTime.now())],
    [DateTime.now().add(Duration(days: 1)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 1)))],
    [DateTime.now().add(Duration(days: 2)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 2)))],
    [DateTime.now().add(Duration(days: 3)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 3)))],
    [DateTime.now().add(Duration(days: 4)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 4)))],
    [DateTime.now().add(Duration(days: 5)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 5)))],
    [DateTime.now().add(Duration(days: 6)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 6)))],
    [DateTime.now().add(Duration(days: 7)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 7)))],
    [DateTime.now().add(Duration(days: 8)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 8)))],
    [DateTime.now().add(Duration(days: 9)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 9)))],
    [DateTime.now().add(Duration(days: 10)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days:10)))],
    [DateTime.now().add(Duration(days: 11)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days:11)))],
    [DateTime.now().add(Duration(days: 12)).day, DateFormat('EEEE').format(DateTime.now().add(Duration(days: 12)))],
  ];
   
   List<dynamic> _Workers = [];
   
   checkworkers(){
      if      (widget.service == "House Keeper"){
        setState(() {
          _Workers = [
      ['assets/images/maid.png',"Eman Salsedo","Philippines 🇵🇭","⭐⭐⭐",1],
      ['assets/images/maid.png',"Almasi Mobarak","Kenya 🇰🇪","⭐⭐",2],
      ['assets/images/maid.png',"Kirana Ahmad","indonesia 🇮🇩","⭐⭐⭐⭐⭐",3],
          ];
        });
      }else if(widget.service == "Plumber"){
        setState(() {
          _Workers = [
      ['assets/images/plumber.png',"Anaisha Ishita","India 🇮🇳","⭐⭐⭐⭐⭐",1],
      ['assets/images/plumber.png',"Abbas Abd al-Razzaq","Pakistan 🇵🇰","⭐⭐⭐",2],
      ['assets/images/plumber.png',"Sharmin Mashrar","Bangladesh 🇧🇩","⭐⭐⭐⭐",3],
          ];
        });
      }else if(widget.service == "Electrician"){
        setState(() {
          _Workers = [
      ['assets/images/electrician.png',"Anwar Jomaa","Egypt 🇪🇬","⭐⭐⭐",1],
      ['assets/images/electrician.png',"Mohammed Mossa","Sudan 🇸🇩","⭐⭐⭐⭐⭐",2],
      ['assets/images/electrician.png',"tariq Shah","Pakistan 🇵🇰","⭐⭐",3],
          ];
        });
      }else if(widget.service == "Mechanical"){
        setState(() {
          _Workers = [
      ['assets/images/mechanic.png',"Ali Babikr","Sudan 🇸🇩","⭐⭐⭐",1],
      ['assets/images/mechanic.png',"Waleed Ahmad","Jordan 🇯🇴","⭐⭐",2],
      ['assets/images/mechanic.png',"saeed bawazeer","Yemen 🇾🇪","⭐⭐⭐⭐",3],
          ];
  
        });
      }else if(widget.service == "Barber"){
        setState(() {
          _Workers = [
      ['assets/images/barber.png',"Hassan Piker","Turkey 🇹🇷","⭐⭐⭐⭐⭐",1],
      ['assets/images/barber.png',"Mansor aziz","Tunisia 🇹🇳","⭐⭐⭐⭐⭐",2],
      ['assets/images/barber.png',"Kirana Ahmad","India 🇮🇳","⭐",3],
          ];
        });
      };
    }
  @override
  void initState(){
    checkLatLong();
    checkworkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar:AppBar(
        toolbarHeight: 65.0,
        backgroundColor: Color.fromARGB(255, 39, 12, 75),
        elevation: 10,
        title: Text('${widget.service}',style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: ColorfulBackground(
     // Color changing animation duration
     duration: Duration(seconds: 10),
     // List colors to animate in the background
     backgroundColors: [
       Color.fromARGB(255, 214, 187, 241),
       Color.fromARGB(255, 255, 255, 255),
     ],
     child: Padding(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(0.0),
            child: ListView(
            //Check Out Page
          children: [
            SizedBox(height: 10,),
            Text('Select Date:',style:TextStyle(fontSize:18,color: Color.fromARGB(255, 39, 12, 75) )),
            SizedBox(height: 5,),
            //Select Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                //Current Year & Month
                Row(
                  children: [
                    Text('(${selectedDate})',style:TextStyle(fontSize: 15, color: Color.fromARGB(115, 63, 38, 60)) ,),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {}, 
                      icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                    )
                  ],
                ),
                //Date Selection Widget
                FadeAnimation(0.2,Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(182, 45, 8, 62),
                    border: Border.all(width: 1.5, color: Color.fromARGB(40, 238, 238, 238)),
                    boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 100, 97, 97),
                                offset: Offset(0, 1),
                                blurRadius: 4.0,
                              ),
                            ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDay = _days[index][0];
                            selectedDate = '${DateFormat('yyyy-MMMM').format(DateTime.now().add(Duration(days: index)))}-${_selectedDay}';
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _selectedDay == _days[index][0] ? Color.fromARGB(255, 189, 150, 220).withOpacity(0.5) : Color.fromARGB(255, 65, 10, 167).withOpacity(0),
                            border: Border.all(
                              color: _selectedDay == _days[index][0] ? Color.fromARGB(255, 65, 10, 167) : Colors.white.withOpacity(0),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_days[index][0].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white.withOpacity(0.8)),),
                              SizedBox(height: 10,),
                              Text(_days[index][1], style: TextStyle(fontSize: 13,color: Colors.white.withOpacity(0.8)),),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
            )],
              ),
            //Choose Worker
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                //Current Year & Month
                Row(
                  children: [
                    Text('Available Workers',style:TextStyle(fontSize: 17, color: Color.fromARGB(255, 39, 12, 75)) ,),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {}, 
                      icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                    )
                  ],
                ),
                //Workers Selection Widget
                FadeAnimation(0.4,Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(182, 45, 8, 62),
                    border: Border.all(width: 1.5, color: Color.fromARGB(40, 238, 238, 238)),
                    boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 100, 97, 97),
                                offset: Offset(0, 1),
                                blurRadius: 4.0,
                              ),
                            ],
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _Workers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedWorker = _Workers[index][4];
                            _WorkerName =_Workers[index][1];
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: _selectedWorker == _Workers[index][4] ? Color.fromARGB(255, 189, 150, 220).withOpacity(0.5) : Color.fromARGB(255, 65, 10, 167).withOpacity(0),
                            border: Border.all(
                              color: _selectedWorker == _Workers[index][4] ? Color.fromARGB(255, 65, 10, 167) : Colors.white.withOpacity(0),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset(_Workers[index][0],height: 30,width: 30,),
                                  Text(_Workers[index][1].toString(), style: TextStyle(fontSize: 17,color:Colors.white.withOpacity(0.8)),),
                                  SizedBox(height: 6,),
                                  Text(_Workers[index][2], style: TextStyle(fontSize: 12,color:Colors.white.withOpacity(0.8)),),
                                  SizedBox(height: 3,),
                                  Text(_Workers[index][3], style: TextStyle(fontSize: 15,color:Colors.white.withOpacity(0.8)),),
                              ],
                              
                              )
                              
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
            )],
              ),
            SizedBox(height: 20,),
            //Your Location
            Text("Your Location:",style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 39, 12, 75)),),
            SizedBox(height: 20,),
            //Location Text
            FadeAnimation(0.5,Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(182, 45, 8, 62),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child:Padding(
                            padding: EdgeInsets.all(8.0),
                            child:Text('${_Location}',style: TextStyle(color: Colors.white),),)
                            )
                            ),
            SizedBox(height: 10),
            //Location
            FadeAnimation(0.4,Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(182, 45, 8, 62),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.map,
                                          color: Color.fromARGB(255, 209, 203, 254)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Select your location',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromARGB(255, 209, 203, 254)
                                              .withOpacity(0.6),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    if (Latt ==null) {
                                      showInSnackBar("Can't access your location ",Colors.red, Colors.white, 2, context, _scaffoldkey);
                                           
                                    } else {
                                      Map();
                                    }
                                    
                                  },
                                ),
                              ],
                            )),
            )
            ),
            SizedBox(height: 20,),
            Text("PaymentType:",style: TextStyle(fontSize:18 ,color :Color.fromARGB(255, 39, 12, 75)),),
            SizedBox(height: 20,),
            //Cash
            FadeAnimation(0.4,Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(182, 45, 8, 62),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Text("💸",style: TextStyle(fontSize: 25),),
                    SizedBox(width: 20,),
                    Text("Cash",style: TextStyle(fontSize: 20,color: Colors.white),),
                  ],
                ),
                leading: Radio<String>(
                  value: 'Cash',
                  groupValue: paymentType,
                  activeColor: Color.fromARGB(255, 65, 10, 167),
                  onChanged: (value) {
                    setState(() {
                      paymentType = value;
                    });
                  },
                ),
              ),
            ),
            ),
            SizedBox(height: 5,),
            //Credit
            FadeAnimation(0.4,Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(182, 45, 8, 62),
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(
                title: Row(
                  children: [
                    Text("💳",style: TextStyle(fontSize: 25),),
                    SizedBox(width: 20,),
                    Text("Credit Card",style: TextStyle(fontSize: 20,color: Colors.white,)),
                  ],
                ),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: paymentType,
                  activeColor: Color.fromARGB(255, 65, 10, 167),
                  onChanged: (value) {
                    setState(() {
                      paymentType = value;
                    });
                  },
                ),
              ),
            ),
            ),
            SizedBox(height: 80,) ,
            //CheckOut
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
                      Text('Check Out',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                onTap: () {
                  if(selectedDate.length>3&&_WorkerName.length>2){Navigator.of(context).push(CupertinoPageRoute(builder:( BuildContext context)=> OrderInfo(
                    userData:widget.userData,
                    userLat:Latt,
                    userLong:Loong,
                    paymentType:paymentType,
                    Fees:widget.price,
                    Service:widget.service,
                    address: _Location,
                    SelectedDate:selectedDate,
                    Worker:_WorkerName,
                    userAddress:widget.userAddress,
                    userLatLong:widget.userLatLong,
                  ) ));}else{
                    showInSnackBar("You Have to Select a date and a worker", Colors.red, Colors.white, 2, context, _scaffoldkey);
                  }
                },
              ),
            SizedBox(height: 20,)
            ]
          ),
          ),
        )
      )
    );
  }
    Future Map() => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Stack(
            children:[
              GoogleMap( //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition( //innital position in map
                    target: LatLng(Latt,Loong), //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) { //method called when map is created
                      setState(() {   
                        mapController = controller; 
                      });
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                      cameraPosition = cameraPositiona;//when map is dragging 
                  },
                  onCameraIdle: () async { //when map drag stops
                     List<Address> placemarks = await Geocoder.local.findAddressesFromCoordinates(Coordinates(cameraPosition.target.latitude, cameraPosition.target.longitude));
                     setState(() { 
                     var first = placemarks.first;
                     loc = '${first.addressLine}';      
                     });
                  },
             ),
              Center( //picker image on google map
                  child: Image.asset("assets/images/location.png", width: 40,),
              ),       
              //floatbottun
              Positioned(
                right: 50,
                bottom: 80,
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 45, 8, 62),
                onPressed:(){
                  Navigator.of(context).pop();
                  setState(() {
                    _Location=loc;
                    Latt=cameraPosition.target.latitude;
                    Loong=cameraPosition.target.longitude;
                  });
                },
                child: Icon(Icons.check,size: 30),
              )
              )
              
            ]
          )
       );
        }
        );
}