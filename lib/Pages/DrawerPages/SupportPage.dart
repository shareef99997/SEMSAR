
import 'package:SEMSAR/Pages/DrawerPages/SupportPages/Contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'SupportPages/FAQ.dart';


class SupportPage extends StatefulWidget {
  const SupportPage({Key key,this.userData}) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 164, 182, 238),
        //Body
        body:  ColorfulBackground(
     // Color changing animation duration
     duration: Duration(seconds: 10),
     // List colors to animate in the background
     backgroundColors: [
       Color.fromARGB(255, 214, 187, 241),
       Color.fromARGB(255, 255, 255, 255),
     ],
      child:Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10),
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    SizedBox(height: 30,),
                    //Contact Us
                    Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(158, 45, 8, 62),
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
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.support_agent_outlined,
                                      color: Color.fromARGB(255, 209, 203, 254)
                                          .withOpacity(0.6),
                                      size: 50,
                                    ),
                                    Spacer(),
                                    Text(
                                      'Contact Us',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 209, 203, 254)
                                          .withOpacity(0.6),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => Contact(userData: widget.userData))); 
                              },
                            ),
                          ],
                        )),
                  ), 
                    SizedBox(height: 50,),
                    //FAQs                  
                    Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(158, 45, 8, 62),
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
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.quiz_outlined,
                                      color: Color.fromARGB(255, 209, 203, 254)
                                          .withOpacity(0.6),
                                      size: 50,
                                    ),
                                    Spacer(),
                                    Text(
                                      'FAQs',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 209, 203, 254)
                                          .withOpacity(0.6),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => FAQ()));
                                
                              },
                            ),
                          ],
                        )),
                  ),
                    SizedBox(height: 30,),      
                    //Contact Info
                    Text('Our Contact Info :',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Color.fromARGB(255, 39, 12, 75)),),
                    SizedBox(height: 30,),
                    //Numbers
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(FontAwesomeIcons.phone,size: 18,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Contact Numbers',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          
                          contentChild: Text('📱  +966582635947\n\n☎️   0112001279',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //Email
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(Icons.email_outlined,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Email',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          contentChild: Text('📧   Shareef.Huzaifa@gmail.com',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7), )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //Twitter
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(FontAwesomeIcons.twitter,size: 20,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Twitter',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          
                          contentChild: Text('🐦   @Semsar_APK',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //Instagram
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(FontAwesomeIcons.instagram,size: 20,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Instagram',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          contentChild: Text('📷   @Semsar_APK',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //FaceBook
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(FontAwesomeIcons.facebookF,size: 20,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Facebook',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          contentChild: Text('   @Semsar_Apk',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //WhatsApp
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(FontAwesomeIcons.whatsapp,size: 20,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('WhatsApp',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          
                          contentChild: Text('📞   +966582635947',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                    //Website
                    GFAccordion(
                          titleChild: Row(children: [
                            Icon(Icons.web,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                            SizedBox(width: 30,),
                            Text('Website',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          
                          contentChild: Text('🕸️   www.semsar.com',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(20),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 10,),
                  ]
                )
            )
        )
    
     )
        );
  }
}