import 'dart:io';

import 'package:SEMSAR/Authentecation/AuthenticationPage.dart';
import 'package:SEMSAR/Authentecation/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../moduls/SnackBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.userData}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> userData;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  var newPassword;
  final currentUser = FirebaseAuth.instance.currentUser;

  // @override
  // void dispose(){
  //   PasswordController.dispose();
  //   super.dispose();
  // }

  // changePassowrd()async{
  //   try {
  //     await currentUser.updatePassword(newPassword);
  //     FirebaseAuth.instance.signOut();Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticationPage()));
  //     showInSnackBar("Your Password Have Been Changed.. Login Again !", Color.fromARGB(255, 229, 159, 28),Colors.white, 2, context, _scaffoldkey);                    
  //   } catch (e) { 
  //   }
  // }
   sendRecoveryPass()async{
    if(EmailController.text==null||EmailController.text.contains('@')==false||EmailController.text.contains('.com')==false){
                    showInSnackBar("invalid email", Colors.red, Colors.white, 2, context, _scaffoldkey);
                  }else{
                    await FirebaseFirestore.instance.collection('UsersAccount')
                    .where('UserEmail',isEqualTo: EmailController.text)
                    .get().then((whereResult) async {
                      if(whereResult==null&& whereResult.docs.isEmpty){
                        showInSnackBar("there is no Account attached with the Email", Colors.red, Colors.white, 2, context, _scaffoldkey);
                      }else{
                            try {
                               await FirebaseAuth.instance.sendPasswordResetEmail(email: EmailController.text).then((MetaData){
                               showInSnackBar("reset password email has been sent ", Color.fromARGB(255, 65, 10, 167), Colors.white, 2, context, _scaffoldkey);
                               EmailController.clear();
                              });
                              } catch (e) {
                                showInSnackBar("there is no Account attached with this Email", Colors.red, Colors.white, 4, context, _scaffoldkey);
                              }
                              }
                              });
                }
  }
  //view overflow
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,   
        //Body
        body:ColorfulBackground(
          // Color changing animation duration
          duration: Duration(seconds: 10),
          // List colors to animate in the background
          backgroundColors: [
            Color.fromARGB(255, 214, 187, 241),
            Color.fromARGB(255, 255, 255, 255),
          ], 
          child:Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10,top: 30),
            child: Padding(
                padding: EdgeInsets.all(0.0),
                child: 
                ListView(                   
                  children: [Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      SizedBox(height: 10,),
                      Container(
                        width: 150,
                        height: 150,
                        margin: EdgeInsets.only(
                          top: 14.0,
                          bottom: 10.0,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/man.png'),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Personal Info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 39, 12, 75))),
                      SizedBox(
                        height: 20,
                      ),
                      //User Name
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(118, 45, 8, 62),
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
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(child: Text(
                                          '${widget.userData.data()['UserName']}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),overflow: TextOverflow.fade,
                                        ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 20, 
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    //Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => Name(userData: widget.userData)));
                                    NameDialog();
                                  },
                                ),
                              ],
                            )),
                      ),
                      SizedBox(  height: 10,),
                      //Phone Number
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(118, 45, 8, 62),
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
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone_android_outlined,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.userData.data()['UserPhone']}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    PhoneDialog();
                                  },
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 10,),                  
                      //Email
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(118, 45, 8, 62),
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
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.userData.data()['UserEmail']}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                  },
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 10,),
                      //Password
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(118, 45, 8, 62),
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
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(12))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lock_outline_rounded,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Change Password',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color.fromARGB(255, 39, 12, 75)
                                              .withOpacity(0.6),
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    PasswordDialog();
                                  },
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 10,),
                      //SignOut
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30.0),  
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(300, 45),
                            elevation: 50,
                            primary: Color.fromARGB(255, 88, 19, 128),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            
                          ),
                          onPressed:() { 
                            SignOutDialog();
                            // FirebaseAuth.instance.signOut();Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticationPage()));
                            // showInSnackBar("Signed Out !", Color.fromARGB(255, 229, 159, 28),Colors.white, 2, context, _scaffoldkey);
                          }, 
                          child: Text("Sign Out",style: TextStyle(fontSize:18,fontWeight:FontWeight.w800 ),) ,
                          
                      )
                  )
                    ]
                  )],
                )
                )
                )
                )
          );

 }

  Future NameDialog() => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              'Change Your Name',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            //Controller
            content: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 128, 126, 126)))),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                controller: NameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.person,
                      color: Color.fromARGB(255, 65, 10, 167).withOpacity(0.5)),
                  hintText: widget.userData.data()['UserName'],
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
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
                  child: Text('Cancel'),),
                  Spacer(),
                  //change name
                GestureDetector(
                  onTap: () {
                    var UserId =widget.userData.data()['UserID'];
                    if (NameController.text ==
                        widget.userData.data()['UserName']) {
                      showInSnackBar("You Have Choosen the Same Name",
                          Colors.red, Colors.white, 2, context, _scaffoldkey);
                    } else if (NameController.text.isEmpty) {
                      showInSnackBar("You Have To Enter a Value", Colors.red,
                          Colors.white, 2, context, _scaffoldkey);
                    } else {
                      setState(() {
                        FirebaseFirestore.instance.collection('UsersAccount').doc(UserId).update({'UserName':NameController.text});
                        Navigator.of(context).pop();
                        clearConrollers();
                        showInSnackBar("Your Name Have Been Changed Sucsessfully ✅", Colors.green,
                          Colors.white, 2, context, _scaffoldkey);  
                      });
                      // if (widget.userData.data()['UserName'] == NameController) {
                      //   Navigator.of(context).pop();
                      //   showInSnackBar("Your Name Have Been Changed Sucsessfully ✅", Colors.green,
                      //     Colors.white, 2, context, _scaffoldkey);           
                      // } else {
                      //   Navigator.of(context).pop();
                      //   showInSnackBar("Your Name Have\'nt Been Changed Due to an Erorr ", Colors.red,
                      //     Colors.white, 2, context, _scaffoldkey);
                      // }
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 65, 10, 167)),
                      child: Center(
                        child: Text(
                          "Change Name",
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
          ),
        );
      }
    );
  Future PhoneDialog() => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              'Change Your Phone Number',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            //Controller
            content: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 128, 126, 126)))),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 20),
                controller: PhoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.phone_android_outlined,
                      color: Color.fromARGB(255, 65, 10, 167).withOpacity(0.5)),
                  hintText: widget.userData.data()['UserPhone'],
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
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
                  child: Text('Cancel'),),
                  Spacer(),
                GestureDetector(
                  onTap: () {
                    var UserId =widget.userData.data()['UserID'];
                    if (PhoneController.text ==
                        widget.userData.data()['UserPhone']) {
                      showInSnackBar("You Have Choosen the Same Phone Number",
                          Colors.red, Colors.white, 2, context, _scaffoldkey);
                    } else if (PhoneController.text==null||PhoneController.text.contains('05')==false||PhoneController.text.length<10) {
                      showInSnackBar("You Have To Enter a Value", Colors.red,
                          Colors.white, 2, context, _scaffoldkey);
                    } else {
                      setState(() {
                        FirebaseFirestore.instance.collection('UsersAccount').doc(UserId).update({'UserPhone':PhoneController.text});
                        Navigator.of(context).pop();
                        clearConrollers();
                        showInSnackBar("Your Phone Number Have Been Changed Sucsessfully ✅", Colors.green,
                          Colors.white, 2, context, _scaffoldkey);  
                      });
                      // if (widget.userData.data()['UserName'] == NameController) {
                      //   Navigator.of(context).pop();
                      //   showInSnackBar("Your Name Have Been Changed Sucsessfully ✅", Colors.green,
                      //     Colors.white, 2, context, _scaffoldkey);           
                      // } else {
                      //   Navigator.of(context).pop();
                      //   showInSnackBar("Your Name Have\'nt Been Changed Due to an Erorr ", Colors.red,
                      //     Colors.white, 2, context, _scaffoldkey);
                      // }
                    }
                  },
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 65, 10, 167)),
                      child: Center(
                        child: Text(
                          "Change Number",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                
              ]),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      }
    );
  Future PasswordDialog() => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              '  Change Your Password',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            //Controller
            content: SingleChildScrollView(
              child: 
                Column(
              children: [
                SizedBox(height: 25),
                Text('Enter Your Email Address To Send Reset Password Email',style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5)),),
                SizedBox(height: 25),
                Image.asset('assets/images/lock.png',height: 70,width: 70,),
                SizedBox(height: 20,),
                //Email
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 128, 126, 126)))),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.email,
                        color: Color.fromARGB(255, 65, 10, 167).withOpacity(0.5)),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
            ),
                SizedBox(height: 20),
            ],
             
            ),
              
            ),
            //Button
            actions: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 5,),
                TextButton(
                  onPressed: (){Navigator.of(context).pop();} ,
                  child: Text('Cancel'),),
                  Spacer(),
                GestureDetector(
                  onTap: () {
                    sendRecoveryPass();
                  },
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 65, 10, 167)),
                      child: Center(
                        child: Text(
                          "Send",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                ),
                SizedBox(
                  width: 5,
                )
              ]),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      }
    );
  Future SignOutDialog() => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              'Sign Out',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            //Controller
            content: Container(
              child: Text(
              '\nare you sure you want to sign out ?',
              style: TextStyle(fontSize: 15, color: Color.fromARGB(184, 255, 255, 255)),
            ),
            ),
            //Button
            actions: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                SizedBox(width: 5,),
                TextButton(
                  onPressed: (){Navigator.of(context).pop();} ,
                  child: Text('No'),),
                  Spacer(),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                    
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AuthenticationPage()),(Route<dynamic> route) => false);
                    showInSnackBar("Signed Out !", Color.fromARGB(255, 229, 159, 28),Colors.white, 2, context, _scaffoldkey);
                  },
                  child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 65, 10, 167)),
                      child: Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                
              ]),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      }
    );
      
      
      clearConrollers(){
    NameController.clear();
    PhoneController.clear(); 
    PasswordController.clear();
 }

}
