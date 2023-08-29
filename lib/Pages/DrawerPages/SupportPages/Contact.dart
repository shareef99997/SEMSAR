import 'package:SEMSAR/Pages/DrawerPages/SupportPages/willcontac.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../moduls/SnackBar.dart';
import '../../Order/OrderPage.dart';

class Contact extends StatefulWidget {
  const Contact({Key key, this.userData}) : super(key: key);
   final DocumentSnapshot<Map<String,dynamic>>userData;
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  TextEditingController EmailController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneNumController = TextEditingController();

  int _selectedTime =0;
  String _Time ="";

  final List<dynamic> _times = [
    ['assets/images/sunset.png',"Morning",1],
    ['assets/images/afternoon.png',"AfterNoon",2],
    ['assets/images/night.png',"Evening",3],
  ];
 
  int _selectedType =0;
  String _Type ="";
  String _numail="";
  final List<dynamic> _Types = [
    ['📞',"Phone",1],
    ['📧',"Email",2],
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 178, 191, 230),
        body:  ColorfulBackground(
     // Color changing animation duration
     duration: Duration(seconds: 10),
     // List colors to animate in the background
     backgroundColors: [
       Color.fromARGB(255, 214, 187, 241),
       Color.fromARGB(255, 255, 255, 255),
     ],
     child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40,right: 10,left: 10,bottom: 20),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    //Logo///////////////////
                    Center(
                      child: Image(
                        image: AssetImage('assets/images/customer-service.png'),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(height: 25,),
                    //Sign up Text///////////////////////////////////////////////////////////
                    Center(
                      child: Text(
                        "Give us your contact info ",
                        style: TextStyle(color: Color.fromARGB(255, 39, 12, 75), fontSize: 16),
                      ),
                    ),
                    //Full Name & Phone Number & Email////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                                color: Color.fromARGB(56, 71, 6, 104),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                  color: Color.fromARGB(48, 0, 0, 0),
                                  blurRadius: 1.0,
                                  offset: Offset(2,3)
                                  ),
                                  ]
                                  ),
                        child: Column(
                          children: <Widget>[
                          //Full Name
                          Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 128, 126, 126))),),     
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: NameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon:Icon(Icons.person_4_outlined,) ,
                                  hintText: 'Full Name',
                                  hintStyle: TextStyle(color: Color.fromARGB(124, 80, 72, 82))),
                            ),
                          ),
                          //Phone Number
                          Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 128, 126, 126))),),     
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: PhoneNumController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon:Icon(Icons.phone_android_outlined) ,
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(color: Color.fromARGB(124, 80, 72, 82))),
                            ),
                          ),
                          //Email Controller
                          Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 128, 126, 126))),),     
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: EmailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon:Icon(Icons.email_outlined) ,
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(color: Color.fromARGB(124, 80, 72, 82))),
                            ),
                          ),]),
                      ),
                    ),
                    SizedBox(height: 40,),
                    //Time Text
                    Center(
                      child: Text(
                        "When would you like us to contact you? ",
                        style: TextStyle(color: Color.fromARGB(255, 39, 12, 75), fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //select time
                    Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(79, 71, 6, 104),
                          border: Border.all(width: 1.5, color: Color.fromARGB(40, 80, 79, 79)),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _times.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                              child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTime = _times[index][2];
                                  _Time =_times[index][1];
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _selectedTime == _times[index][2] ? Color.fromARGB(255, 186, 167, 203).withOpacity(0.5) : Color.fromARGB(255, 65, 10, 167).withOpacity(0),
                                  border: Border.all(
                                    color: _selectedTime == _times[index][2] ? Color.fromARGB(111, 244, 244, 244) : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(_times[index][0],height: 80,width: 80,),
                                        SizedBox(height: 5,),
                                        Text(_times[index][1].toString(), style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],
                                    
                                    )
                                    
                                  ],
                                ),
                              ),
                            )
                         ,
                            ) ;}
                        ),
                      ),
                    SizedBox(height: 40,),
                    //Type Text
                    Center(
                      child: Text(
                        'How would you Like us to reach you?',
                        style: TextStyle(color: Color.fromARGB(255, 39, 12, 75), fontSize: 16),
                      ),
                    ),
                    SizedBox(height :20),
                    //Select Type
                    Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(79, 71, 6, 104),
                          border: Border.all(width: 1.5, color: Color.fromARGB(40, 80, 79, 79)),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _Types.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                              child:GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedType = _Types[index][2];
                                  _Type =_Types[index][1];
                                  if (_Type=='Phone') {
                                    _numail = PhoneNumController.text;
                                  } else if(_Type=='Email'){
                                    _numail = EmailController.text;
                                  }else{}
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 168.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _selectedType == _Types[index][2] ? Color.fromARGB(255, 186, 167, 203).withOpacity(0.5) : Color.fromARGB(255, 65, 10, 167).withOpacity(0),
                                  border: Border.all(
                                    color: _selectedType == _Types[index][2] ? Color.fromARGB(111, 244, 244, 244) : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(_Types[index][0].toString(), style: TextStyle(fontSize: 20,color: Colors.white),),
                                        SizedBox(height: 5,),
                                        Text(_Types[index][1].toString(), style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],                                
                                    )   
                                  ],
                                ),
                              ),
                            ));
                            }
                        ),
                      ),
                    SizedBox(height :10),
                    Center(
                      child: Text(
                        '(  ${_numail}  )',
                        style: TextStyle(color: Color.fromARGB(255, 39, 12, 75).withOpacity(0.6), fontSize: 16),
                      ),
                    ),                
                    SizedBox(height: 20,),
                    //Sign up Button////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          if(NameController.text.isEmpty||PhoneNumController.text.isEmpty||EmailController.text.isEmpty){
                               showInSnackBar("Make sure all feilds are filled", Colors.red, Colors.white, 4, context, _scaffoldkey);}
                             else if(_Type.length<2||_Time.length<2){
                              showInSnackBar("You Have to Select a time and a contact way", Colors.red, Colors.white, 4, context, _scaffoldkey);
                            }else{
                              Request();
                            }
                        },
                        //Sign up button/////////////////////////////////////
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 65, 10, 167)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            )
                            ),
                      ),
                    ),
                ],
              ),
              ),
              ]
          )
    ,
)
        
        );
  }
    Request(){
    Map<String,dynamic>reqDoc;
    setState(() {
      reqDoc={
        'RequestName':NameController.text,
        'RequestPhoneNumber':PhoneNumController.text,
        'RequestEmail':EmailController.text,
        'ContactTime':_Time,
        'ContactWay':_Type,
        'RequestTime':DateTime.now(),
        'UserName':widget.userData.data()['UserName'],
        'UserPhoneNumber':widget.userData.data()['UserPhone'],
        'UserID':widget.userData.id,
      };
    });
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => willcontact(userData : widget.userData,
    request:reqDoc)));
  }
}