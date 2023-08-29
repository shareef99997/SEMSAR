import 'package:SEMSAR/Pages/Order/CheckOut.dart';
import 'package:SEMSAR/Pages/DrawerPages/ProfilePage.dart';
import 'package:SEMSAR/Pages/DrawerPages/ReservationsPage.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import '../moduls/Animation.dart';
import '../moduls/SendNotification.dart';
import 'DrawerPages/NewsPage.dart';
import 'DrawerPages/SupportPage.dart';



class HomePage extends StatefulWidget { 

  //take user data from log in
  final DocumentSnapshot <Map<String, dynamic>> userData;
  @override

  _HomePageState createState() => _HomePageState();
  const HomePage({Key key, this.userData, this.userAddress, this.userLatLong}) : super(key: key);
  final String userAddress;
  final Position userLatLong;
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  final _advancedDrawerController = AdvancedDrawerController();
  String sun ="";
  String good="";
  var price="";
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();  
  String Service ="";
  String fullName;
  String firstName;

  @override
  void initState() {
    super.initState();
     
        fullName=widget.userData.data()['UserName'];
        List<String> nameParts = fullName.split(' ');
        firstName = nameParts[0];
      
    initiateFirebaseNotification();
    getservice();
  }

    Future getservice()async{
      final DocumentReference HouseKeeperref = FirebaseFirestore.instance.collection('Services').doc('House Keeping');
      final DocumentReference Plumberref = FirebaseFirestore.instance.collection('Services').doc('Plumber');
      final DocumentReference Electricianref = FirebaseFirestore.instance.collection('Services').doc('Electrician');
      final DocumentReference Mechanicref = FirebaseFirestore.instance.collection('Services').doc('Mechanic');
      final DocumentReference Barberref = FirebaseFirestore.instance.collection('Services').doc('Barber');
      final DocumentSnapshot HouseKeeper = await HouseKeeperref.get();
      final DocumentSnapshot Plumber = await Plumberref.get();
      final DocumentSnapshot Electrician = await Electricianref.get();
      final DocumentSnapshot Mechanic = await Mechanicref.get();
      final DocumentSnapshot Barber = await Barberref.get();
      
      }


  Future <bool> initiateFirebaseNotification()async{
    bool insureInit;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      insureInit =true;
      messaging.getToken().then((token) async{
        await updateUserNotificationToken(token);
      });
      print('User granted permission ✅');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      insureInit =true;
      messaging.getToken().then((token) async{
        await updateUserNotificationToken(token);
      });
      print('User granted provisional permission ✅');
    } else {
      insureInit =false;
      print('User declined or has not accepted permission ❌');
    }
    return insureInit;
  }

  updateUserNotificationToken(String token)async{
    await FirebaseFirestore.instance.collection('UsersAccount').doc(widget.userData.id).update({
      'FBNotificationToken':token,
    });
  }

  void _handleMenuButtonPressd(){
    _advancedDrawerController.showDrawer();
  }
 
  String getsun(){
    var Hour = DateTime.now().hour;
    if(Hour<12){
      sun ='assets/images/sunset.png';
    }else if(Hour < 17){
      sun ='assets/images/afternoon.png';
    }
    else{
      sun='assets/images/night.png';
    }
    return sun;
  }

  String textget(){
    var Hour = DateTime.now().hour;
    if(Hour<12){
      good ="Good Morning";
    }else if(Hour < 16){
      good = "Good Afternoon";
    }else{
      good="Good Evening";
    }
    return good;
  }



////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Color.fromARGB(255, 130, 114, 137),
      controller:_advancedDrawerController ,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds:100 ),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: ListView(
            children: [
              Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128,
                height: 128,
                margin: EdgeInsets.only(
                  top: 24.0,
                  bottom: 10.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:DecorationImage(
                    image: AssetImage('assets/images/man.png'),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              SizedBox(height: 10,),
              Text(
                fullName,
                style: TextStyle(color: Colors.black,fontSize: 20),
              ),
              SizedBox(height: 35),
              //profile
              ListTile(
                onTap: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => ProfilePage(userData: widget.userData,)));
                },
                leading: Icon(Icons.account_circle_rounded,color:Color.fromARGB(255, 38, 9, 51)),
                title: Text('Profile',style: TextStyle(color: Colors.black,fontSize: 17),),
              ),
              //Support
              ListTile(
                onTap: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => SupportPage(userData: widget.userData,)));
                },
                leading: Icon(Icons.contact_support,color:Color.fromARGB(255, 38, 9, 51)),
                title: Text('Support',style: TextStyle(color: Colors.black,fontSize: 17),),
              ),
              //news and offers
              ListTile(
                onTap: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => NewsPage(userData: widget.userData,)));
                },
                leading: Icon(Icons.tips_and_updates_sharp,color:Color.fromARGB(255, 38, 9, 51)),
                title: Text('Semsar ?',style: TextStyle(color: Colors.black,fontSize: 17),)
                ),        
              //Share App
              ListTile(
                onTap: (){
                  Share.share('Check Out this New Home Service App https://play.google.com/store/apps/details?id=com.shareef.Semsar  ');
                },
                leading: Icon(Icons.ios_share_outlined,color:Color.fromARGB(255, 38, 9, 51) ),
                title: Text('Share App',style: TextStyle(color: Colors.black,fontSize: 17),),
              ),
            ],
          ),
        ],
          ),
          ),
      ),
      child:Scaffold(
      key: _scaffoldkey,
      body:ColorfulBackground(
          // Color changing animation duration
          duration: Duration(seconds: 10),
          // List colors to animate in the background
          backgroundColors: [
            Color.fromARGB(255, 214, 187, 241),
            Color.fromARGB(255, 255, 255, 255),
          ],
          // A child widget
          child:  Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  padding: EdgeInsets.only(top: 35),
                  children: [
                    //header
                    FadeAnimation(0.1,headerSection(context)),
                    SizedBox(height : 25),
                    // good morning pad
                    FadeAnimation(0.4,goodMorningPad(context)),
                    SizedBox(height: 20,),
                    Text("  What\'s New ?",style:TextStyle(fontSize: 15,color: Color.fromARGB(255, 38, 9, 51),fontWeight: FontWeight.bold)),
                    SizedBox(height: 15,),
                    FadeAnimation(0.6,Offers(context)),
                    SizedBox(height: 40,),
                    Text("  How May I Help You 🤖 ?",style:TextStyle(fontSize: 15,color: Color.fromARGB(255, 38, 9, 51),fontWeight: FontWeight.bold)),
                    SizedBox(height: 20,), 
                    //Services////////////////////////////////////
                    FadeAnimation(0.8,ServicesList(context)),
                  ],
                ),
              ),
            
        )
        
      ),
    );
  }


  Widget headerSection(BuildContext context){
    return Column(
      children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Profile
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: Material(
                          color: Color.fromARGB(255, 65, 10, 167),
                          type: MaterialType.transparency,
                          child: Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 38, 9, 51),
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _handleMenuButtonPressd();
                          });
                        },
                      ),
                    ),       
                ],
                  ),
                //Logo 
                Center(
                  child : Image(image:AssetImage('assets/images/LOGO.png'),
                  height: 70,
                  width: 70,
                  )
                ),
                //Reservations
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: InkWell(
                        child: Material(
                          color: Color.fromARGB(255, 65, 10, 167),
                          type: MaterialType.transparency,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.collections_bookmark,
                              color: Color.fromARGB(255, 38, 9, 51),
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => ReservationsPage(userData: widget.userData)));
                        },
                      ),
                    ),       
                ],
                  ),
              ],
            ),
      ],
    );
  }
  
  Widget goodMorningPad(BuildContext context){
    return Column(
      children: [
            Container(
                padding: EdgeInsets.all(10.0),
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(182, 45, 8, 62),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(135, 0, 0, 0),
                      offset: Offset(2, 2),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                //good morning/Evening UserName
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [  
                    Row(
                      children:[Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Text(textget() , style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15),),
                            Spacer(),
                            Expanded(flex: 2,child:  Text(firstName, style: TextStyle(fontStyle: FontStyle.normal ,color: Colors.white.withOpacity(0.8), fontSize: 20,fontWeight: FontWeight.w500),overflow: TextOverflow.fade),)
                          ],
                    ),
                      ]                   
                    ),                
                    Spacer(),
                    //sun emoji
                     Flexible(
                          child: Image.asset(getsun(),
                          height: 200,
                          width:  200,
                          )
                          
                        ),
                  ],
                ),
            ),
      ],
    );
  }

  Widget Offers(BuildContext context){
    return Container(
      padding: EdgeInsets.all(2.0),
      height: 230,
      child:DefaultTabController(
          length: 2,
          child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            children: [
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 58.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: TabBarView(
                    children: [
                    //Ramadan
                    SingleChildScrollView(
                      child: Padding(
                      padding: EdgeInsets.all(10),
                      child:  Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:Color.fromARGB(166, 242, 103, 28),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(135, 0, 0, 0),
                              offset: Offset(0, 2),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/mosque.png',height: 70,width: 70,),
                              Spacer(),
                              Image.asset('assets/images/oil-lamp.png',height: 70,width: 70,),
                              ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text('Ramadan Kareem 🕌',style: TextStyle(color: Color.fromARGB(255, 65, 10, 167),fontSize: 20,fontWeight: FontWeight.w600),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text('Keep up with the best offers throughout the\nholy month',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 13,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                      )
                    ,
                     ),
                     
                    ),
                    //new services
                    SingleChildScrollView(
                      child: Padding(
                      padding: EdgeInsets.all(10),
                      child:Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:Color.fromARGB(167, 184, 52, 228),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(135, 0, 0, 0),
                              offset: Offset(0, 2),
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Check out our new services',style: TextStyle(color: Color.fromARGB(255, 240, 205, 153),fontSize: 18,fontWeight: FontWeight.w500),overflow: TextOverflow.fade,),
                              ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Image.asset('assets/images/maid.png',height: 50,width: 50,),
                              Spacer(),
                              Image.asset('assets/images/plumber.png',height: 50,width: 50,),
                              Spacer(),
                              Image.asset('assets/images/mechanic.png',height: 50,width: 50,),
                              ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset('assets/images/electrician.png',height: 50,width: 50,),
                              Spacer(),
                              Image.asset('assets/images/barber.png',height: 50,width: 50,),
                              ],
                          ),
                        ],
                      ),
                      )
                    ),
                     ),
                     ]
                  ),
                ),
              ),
              TabPageSelector(
                color: Color.fromARGB(152, 135, 86, 225),
                selectedColor: Color.fromARGB(188, 38, 9, 51),
              ),
            ],
          ),
        )
        )
    );
    
  }

  Widget ServicesList(BuildContext context){
    return Column(
      children: [
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                //HouseKeeper //Plumber
                Row(
                  children: [
                    //HouseKeeping
                    Spacer(),
                    SizedBox(
                      height:100 ,
                      width:100 ,
                      child:Material(      
                        color: Color.fromARGB(182, 45, 8, 62),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        
                        child:InkWell(
                          onTap: () {
                            HouseKeeperBottomSheet(context);
                            SendNotification(body:"test" ,title:"test" ,userID: widget.userData.data()['UserID'],);
                          },
                          child:Center(
                            child:
                              Ink.image(
                            image: AssetImage('assets/images/maid.png'),
                            height: 90,
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                        )      
                      )
                        ),
                    ),
                    Spacer(),
                    //Plumber
                    SizedBox(
                      height:100 ,
                      width:100 ,
                      child:Material(
                            color: Color.fromARGB(182, 45, 8, 62),
                            elevation: 8,
                            borderRadius: BorderRadius.circular(30),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child:InkWell(
                              onTap: () {
                                PlumberBottomSheet(context);
                              },
                              child:Center(
                                child: 
                                  Ink.image(
                                    image: AssetImage('assets/images/plumber.png'),
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.contain,
                                    ),
                              )      
                            )
                        ),     
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,),
                //Electrician //Mechanic
                Row(
                  children: [
                    //Electrician
                    Spacer(),
                    SizedBox(
                      height:100 ,
                      width:100 ,
                      child:Material(      
                        color: Color.fromARGB(182, 45, 8, 62),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:InkWell(
                          onTap: () {
                            ElectricainBottomSheet(context);
                          },
                          child:Center(
                            child:
                              Ink.image(
                            image: AssetImage('assets/images/electrician.png'),
                            height: 90,
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                        )      
                      )
                        ),
                    
                      ),
                    Spacer(),
                    //Mechanic
                    SizedBox(
                      height:100 ,
                      width:100 ,
                      child:Material(
                        color: Color.fromARGB(182, 45, 8, 62),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:InkWell(
                          onTap: () {
                            MechanicBottomSheet(context);
                          },
                          child:Center(
                            child: 
                              Ink.image(
                                image: AssetImage('assets/images/mechanic.png'),
                                height: 90,
                                width: 90,
                                fit: BoxFit.contain,
                                ),
                          )      
                        )
                    ),     
                    
                      ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,),
                //Barber
                Row(
                  children: [
                    Spacer(),
                    //Barber
                      SizedBox(
                      height:100 ,
                      width:100 ,
                      child:Material(      
                        color: Color.fromARGB(182, 45, 8, 62),
                        elevation: 8,
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        
                        child:InkWell(
                          onTap: () {
                            BarberBottomSheet(context);
                          },
                          child:Center(
                            child:
                              Ink.image(
                            image: AssetImage('assets/images/barber.png'),
                            height: 90,
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                        )      
                      )
                        ),
                    
                      ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,)
                ],
            )
      ],
    );
  }

  HouseKeeperBottomSheet(BuildContext context){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      elevation: 100,
      context : context,
      isDismissible: true,
      backgroundColor: Color.fromARGB(217, 28, 16, 34),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/maid.png'),height: 90,width: 90,),
            SizedBox(height: 20,),
            Text("Order a house Keeper that can help you with Cleaning, laundry, pressing and Furniture Arrangement. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30,),
            Text("The Service fees is due for the duration of four hours ",style: TextStyle(color: Color.fromARGB(181, 255, 153, 0),fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: 40,),
            Text("100 SAR ",style: TextStyle(backgroundColor: Color.fromARGB(28, 119, 0, 255),color:Colors.white,fontSize: 15,fontWeight: FontWeight.w800),),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 88, 19, 128),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                
              ),
              onPressed:() {
                Service ="House Keeper";
                price = "100";
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CheckOut(userData: widget.userData,service:Service ,price:price,userAddress:widget.userAddress,userLatLong:widget.userLatLong)));
              }, 
              child: Text('Book House Keeper',style: TextStyle(fontSize:20,fontWeight:FontWeight.w800 ),) ,
              
            )
          ],
        ),
      
          ],
        ))
    );
  }

  PlumberBottomSheet(BuildContext context){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      elevation: 100,
      context : context,
      isDismissible: true,
      backgroundColor: Color.fromARGB(217, 28, 16, 34),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/plumber.png'),height: 90,width: 90,),
            SizedBox(height: 20,),
            Text("Order a Plumber that can help you with All your water system problems. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30,),
            Text("The Service fees bellow is set for problem checking,  the hand work fees are decided by the worker",style: TextStyle(color: Color.fromARGB(187, 255, 153, 0),fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: 40,),
            Text("20 SAR ",style: TextStyle(backgroundColor: Color.fromARGB(28, 119, 0, 255),color:Colors.white,fontSize: 15,fontWeight: FontWeight.w800),),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 88, 19, 128),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                
              ),
              onPressed:() {
                Service ="Plumber";
                price = "20";
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CheckOut(userAddress:widget.userAddress,userLatLong:widget.userLatLong,userData: widget.userData,service:Service ,price:price)));
              }, 
              child: Text("Book Plumber",style: TextStyle(fontSize:20,fontWeight:FontWeight.w800 ),) ,
              
            )
          ],
        ),
      
          ],
        ))
    );
  }

  ElectricainBottomSheet(BuildContext context){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      elevation: 100,
      context : context,
      isDismissible: true,
      backgroundColor: Color.fromARGB(217, 28, 16, 34),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/electrician.png'),height: 90,width: 90,),
            SizedBox(height: 20,),
            Text("Order an Electrician that can help you with All electricity related problems. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30,),
            Text("The Service fees bellow is set for problem checking,  the hand work fees are decided by the worker",style: TextStyle(color: Color.fromARGB(183, 255, 153, 0),fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            Text("30 SAR ",style: TextStyle(backgroundColor: Color.fromARGB(28, 119, 0, 255),color:Colors.white,fontSize: 15,fontWeight: FontWeight.w800),),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 88, 19, 128),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                
              ),
              onPressed:() {
                Service ="Electrician";
                price = "30";
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CheckOut(userAddress:widget.userAddress,userLatLong:widget.userLatLong,userData: widget.userData,service:Service ,price:price)));
              }, 
              child: Text("Book Electrician",style: TextStyle(fontSize:20,fontWeight:FontWeight.w800 ),) ,
              
            )
          ],
        ),
      
          ],
        ))
    );
  }

  MechanicBottomSheet(BuildContext context){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      elevation: 100,
      context : context,
      isDismissible: true,
      backgroundColor: Color.fromARGB(217, 28, 16, 34),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/mechanic.png'),height: 90,width: 90,),
            SizedBox(height: 20,),
            Text("Order a Mechanic that can help you with all aspects of your vehicle. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30,),
            Text("The Service fees bellow is set for problem checking,  the hand work fees are decided by the worker",style: TextStyle(color: Color.fromARGB(171, 255, 153, 0),fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            Text("20 SAR ",style: TextStyle(backgroundColor: Color.fromARGB(28, 119, 0, 255),color:Colors.white,fontSize: 15,fontWeight: FontWeight.w800),),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 88, 19, 128),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                
              ),
              onPressed:() {
                Service ="Mechanical";
                price = "20";
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CheckOut(userAddress:widget.userAddress,userLatLong:widget.userLatLong,userData: widget.userData,service:Service ,price:price)));
              }, 
              child: Text("Book Mechanic",style: TextStyle(fontSize:20,fontWeight:FontWeight.w800 ),) ,
              
            )
          ],
        ),
      
          ],
        ))
    );
  }

  BarberBottomSheet(BuildContext context){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40))
      ),
      elevation: 100,
      context : context,
      isDismissible: true,
      backgroundColor: Color.fromARGB(217, 28, 16, 34),
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/barber.png'),height: 90,width: 90,),
            SizedBox(height: 20,),
            Text("Order a Barber to your home to get the best haircuts and hairstyles. ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30,),
            Text("the fees bellow is for one haircut, the barber may offer you other paid services  ",style: TextStyle(color: Color.fromARGB(173, 255, 153, 0),fontSize: 10,fontWeight: FontWeight.w500),),
            SizedBox(height: 50,),
            Text("50 SAR ",style: TextStyle(backgroundColor: Color.fromARGB(28, 119, 0, 255),color:Colors.white,fontSize: 15,fontWeight: FontWeight.w800),),
            SizedBox(height: 55,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 88, 19, 128),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                
              ),
              onPressed:() {
                Service ="Barber";
                price = "50";
                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CheckOut(userAddress:widget.userAddress,userLatLong:widget.userLatLong,userData: widget.userData,service:Service ,price:price)));
              }, 
              child: Text("Book Barber",style: TextStyle(fontSize:20,fontWeight:FontWeight.w800 ),) ,
              
            )
          ],
        ),
      
          ],
        ))
    );
  }

}
