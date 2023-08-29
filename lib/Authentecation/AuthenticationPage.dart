import 'dart:ffi';

import 'package:SEMSAR/Authentecation/SplashScreen.dart';
import 'package:SEMSAR/moduls/SnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Pages/HomePage.dart';
import '../moduls/Animation.dart';


class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AutenticationPage();
}

class _AutenticationPage extends State<AuthenticationPage> {
  GlobalKey<ScaffoldState>_scaffoldKey = new GlobalKey();
  TextEditingController LoginEmailController = TextEditingController();
  TextEditingController LoginPasswordController = TextEditingController();
  TextEditingController SignupEmailController = TextEditingController();
  TextEditingController SignupPasswordController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController PhoneNumController = TextEditingController();
  bool obscurePasswordText = true;
  bool isLoginActivated = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Visibility(
          visible: isLoginActivated,
          //LogIn Page
          child: SloginScreen(BuildContext),
          //Signup Page
          replacement: SignupScreenDesign(BuildContext)
          )
      ),
    );
  }
//LogIn Page
//   Widget LoginScreenDesign(BuildContext){
//     return ListView(
//           children: [
//             //Logo////////////////////////
//             Center(
//               child: Image(
//                 image: AssetImage('assets/images/LOGO.png'),
//                 height: 150,
//                 width: 150,
//               ),
//             ),
//             //Login Text
//             Center(
//               child: Text(
//                 "Login",
//                 style: TextStyle(color: Colors.white, fontSize: 32,fontWeight: FontWeight.bold),
//               ),
//             ),
//             //Email & Password////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                         color: Color.fromARGB(43, 107, 93, 135),
//                         borderRadius: BorderRadius.circular(9),
//                         boxShadow: [
//                           BoxShadow(
//                           color: Color.fromARGB(255, 60, 59, 59).withOpacity(0.5),
//                           blurRadius: 5.0,
//                           offset: Offset(0,3)
//                           ),
//                           ]
//                           ),
//                 child: Column(
//                   children: <Widget>[
//                   //Email Controller
//                   Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 128, 126, 126))),),     
//                     child: TextField(
//                       style: TextStyle(color: Colors.white),
//                       controller: LoginEmailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           icon:Icon(Icons.email_outlined) ,
//                           hintText: 'Email Address',
//                           hintStyle: TextStyle(color: Colors.grey)),
//                     ),
//                   ),
//                   //Password Controller
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border(bottom: BorderSide(color: Color.fromARGB(255, 128, 126, 126)))),
//                     child: TextField(
//                       style: TextStyle(color: Colors.white),
//                       controller: LoginPasswordController,
//                       obscureText: obscurePasswordText,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         icon:Icon(Icons.key) ,
//                         hintText: 'Password',
//                         hintStyle: TextStyle(color: Colors.grey),
//                         suffixIcon: IconButton(
//                           icon:obscurePasswordText==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined),
//                           color: Color.fromARGB(255, 40, 105, 217),
//                           onPressed: (){
//                             if(obscurePasswordText==true){
//                               setState(() {
//                                 obscurePasswordText = false;
//                               });
//                             }else{setState(() {
//                               obscurePasswordText=true;
//                             });
                             
//                             }
//                           },
//                         )
//                       ),
//                     ),
//                   )
//                 ]),
//               ),
//             ),
//             SizedBox(height: 50),
//             //forgot password button
//             Center(
//               child: GestureDetector(
//                 onTap:() async{
//                   showInWaitingSnackBar("Loading.....", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldKey);
//                   Future.delayed(Duration(seconds: 2));
//                   sendRecoveryPass();
//                 },
//                 child: Text("Forgot the Password ? ",
//                 style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 15),),
//               ),
//             ),
//             SizedBox(height :50),
//             //Login Button////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//             Center(
//               child: GestureDetector(
//                 onTap: (){
//                   userLogininputvalidation();
//                 },
//                 child: Container(
//                     height: 50,
//                     width: double.maxFinite,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Color.fromARGB(255, 65, 10, 167)),
//                     child: Center(
//                       child: Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white, fontSize: 25),
//                       ),
//                     )
//                     ),
//               ),
//             ),
//             SizedBox(height :50),
//             //Create new account////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//             Center(
//               child: GestureDetector(
//                 onTap: (() {setState(() {
//                   isLoginActivated = false;
//                 });
//                   clearConrollers();
//                 }),
//                 child: Text("Don\'t have an Account ?",
//                 style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 15),),
//               ),
//             )
//         ]
//         );
//   }


  //Signup Page
  Widget SignupScreenDesign(BuildContext){
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [       
            Container(
              height: 150,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: 150,
                    width: width,
                    child: FadeAnimation(0.6, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height :20),
            //Sign up Text///////////////////////////////////////////////////////////
            FadeAnimation(0.3,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child:
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Center(
              child: Text(
                "Sign up",
                style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            ],
             )
            ),
             ),
            //Full Name & Phone Number & Email & Password ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            FadeAnimation(0.5,
             Padding(
              padding: const EdgeInsets.all( 25.0),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3).withOpacity(0.5),
                          blurRadius: 20.0,
                          offset: Offset(0,10)
                          ),
                          ]
                          ),
                child: Column(
                  children: <Widget>[
                  //Full Name
                  Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3).withOpacity(0.4))),),     
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: NameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon:Icon(Icons.person_4_outlined) ,
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  //Phone Number
                  Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3).withOpacity(0.4))),),     
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: PhoneNumController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon:Icon(Icons.phone_android_outlined) ,
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  //Email Controller
                  Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3).withOpacity(0.4))),),     
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: SignupEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon:Icon(Icons.email_outlined) ,
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  //Password Controller
                  Container(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: SignupPasswordController,
                      obscureText: obscurePasswordText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon:Icon(Icons.key) ,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon:obscurePasswordText==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined),
                          color: Colors.purple,
                          onPressed: (){
                            if(obscurePasswordText==true){
                              setState(() {
                                obscurePasswordText = false;
                              });
                            }else{setState(() {
                              obscurePasswordText=true;
                            });
                              
                            }
                          },
                        )
                      ),
                    ),
                  )
                ]),
              ),
            ),
            ),
            SizedBox(height :20),
            //Already have an account?////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            FadeAnimation(0.7,
             Center(
              child: GestureDetector(
                onTap: (() {
                  setState(() {
                    isLoginActivated = true;
                  });
                  clearConrollers();
                }),
                child: Text("Already have an Account ?",
                style: TextStyle(color: Color.fromARGB(255, 88, 2, 105).withOpacity(0.8),fontSize: 15),),
              ),
            ),
            ),
            SizedBox(height :30),            
            //Sign up Button////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            FadeAnimation(1.1,
             Center(
              child: GestureDetector(
                onTap: (){
                  userSignupinputvalidation();
                },
                //Sign up button/////////////////////////////////////
                child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 88, 2, 105)),
                    child: Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    )
                    ),
              ),
            ),
            ),
            SizedBox(height :30),
            Padding(
              padding: EdgeInsets.all(10),
              child:
              Text(
                    "We are going to send a verification email to your email address " , style: TextStyle(fontSize: 12 , color: Colors.red),)),
                    SizedBox(height: 20,),
        ]
    ));
  }
  
  Widget SloginScreen(BuildContext){
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: 270,
                    width: width,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill
                        )
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(0.2, Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  SizedBox(height: 30,),
                  //email and pass
                  FadeAnimation(0.4,
                   Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    //Email and password
                    child: Column(
                      children: <Widget>[
                        //Email Controller
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey[200]
                            ))
                          ),
                          child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: LoginEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon:Icon(Icons.email_outlined) ,
                          hintText: 'Email Address',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                        ),
                        //Password Controller
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: LoginPasswordController,
                      obscureText: obscurePasswordText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon:Icon(Icons.key) ,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon:obscurePasswordText==true?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye_outlined),
                          color: Colors.purple,
                          onPressed: (){
                            if(obscurePasswordText==true){
                              setState(() {
                                obscurePasswordText = false;
                              });
                            }else{setState(() {
                              obscurePasswordText=true;
                            });
                              
                            }
                          },
                        )
                      ),
                    ),
                        )
                      ],
                    ),
                  )
                  ),
                  SizedBox(height: 20,),
                  //Forgot Password
                  FadeAnimation(0.5, 
                   Center(
                      child: GestureDetector(
                        onTap:() async{
                          showInWaitingSnackBar("Loading.....", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldKey);
                          Future.delayed(Duration(seconds: 2));
                          sendRecoveryPass();
                        },
                        child: Text("Forgot Password ? ",
                        style: TextStyle(color: Colors.purple.withOpacity(0.8),fontSize: 15),),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  //Login button
                  FadeAnimation(0.7,
                   Center(
                      child: GestureDetector(
                        onTap: (){
                          userLogininputvalidation();
                        },
                        child: Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 88, 2, 105)),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            )
                            ),
                      ),
                    ),
            ),
                  SizedBox(height: 30,),
                  //Creat Account button
                  FadeAnimation(1.1,
                   Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(  
                          primary: Color.fromARGB(147, 152, 54, 244),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),),
                      onPressed: (() {setState(() {
                        isLoginActivated = false;
                      });
                        clearConrollers();
                      }),
                      child: 
                      Text("Don\'t have an Account ?",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),fontSize: 15),),    
                    ),
                  )
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "if the verification message is nowhere to be found look up your (Junk) section or (الرسائل الغير مرغوب فيها )" , style: TextStyle(fontSize: 12 , color: Colors.red),),
                    SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      );
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  sendRecoveryPass()async{
    if(LoginEmailController.text==null||LoginEmailController.text.contains('@')==false||LoginEmailController.text.contains('.com')==false){
                    showInSnackBar("invalid email", Colors.red, Colors.white, 2, context, _scaffoldKey);
                  }else{
                    await FirebaseFirestore.instance.collection('UsersAccount')
                    .where('UserEmail',isEqualTo: LoginEmailController.text)
                    .get().then((whereResult) async {
                      if(whereResult==null&& whereResult.docs.isEmpty){
                        showInSnackBar("there is no Account attached with the Email", Colors.red, Colors.white, 2, context, _scaffoldKey);
                        LoginPasswordController.clear();
                      }else{
                            try {
                               await FirebaseAuth.instance.sendPasswordResetEmail(email: LoginEmailController.text).then((MetaData){
                               showInSnackBar("reset password email has been sent ", Color.fromARGB(255, 65, 10, 167), Colors.white, 2, context, _scaffoldKey);
                               LoginPasswordController.clear();
                              });
                              } catch (e) {
                                showInSnackBar("there is no Account attached with this Email", Colors.red, Colors.white, 4, context, _scaffoldKey);
                              }
                              }
                              });
                }
  }



  void userLogininputvalidation(){
    if(LoginEmailController.text==null||LoginEmailController.text.contains('@')==false||LoginEmailController.text.contains('.com')==false){
      showInSnackBar("invalid email", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(LoginPasswordController.text==null||LoginPasswordController.text.length<8){
      showInSnackBar("Password must be atleast 8 characters long", Colors.red, Colors.white, 3, context, _scaffoldKey);
    }else{
      showInWaitingSnackBar("Loging in.....", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldKey);
      Future.delayed(Duration(seconds:2),(){
        loginUser();
      }
      );
    }

  }
  //Login User////////////////////////////////
 Future loginUser()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: LoginEmailController.text,
        password: LoginPasswordController.text
       ).then((UserCredentials) async {
        if(UserCredentials.user.uid!=null){
          if(UserCredentials.user.emailVerified==false){
            clearConrollers();
            await UserCredentials.user.sendEmailVerification();
            await FirebaseAuth.instance.signOut().then((value) {
              showInSnackBar("Your Email is Not Verified", Color.fromARGB(255, 229, 159, 28), Colors.white, 2, context, _scaffoldKey);
            });
          }else{
            UserCredentials.user.emailVerified==true;
            await FirebaseFirestore.instance.collection('UsersAccount').doc(UserCredentials.user.uid).get().then((userDoc){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context)=>HomePage(userData:userDoc,)));
            });
          }
        }
      }
      );
    }on FirebaseAuthException catch(e){
      showInSnackBar("Login Failed due to incorrect account information", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }
  }

  void userSignupinputvalidation(){
    if(NameController.text==null||NameController.text.length<6){
       showInSnackBar("invalid Name", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(PhoneNumController.text==null||PhoneNumController.text.contains('05')==false||PhoneNumController.text.length<10){
      showInSnackBar("invalid phone Number", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(SignupEmailController.text==null||SignupEmailController.text.contains('@')==false||SignupEmailController.text.contains('.com')==false){
      showInSnackBar("invalid email", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else if(SignupPasswordController.text==null||SignupPasswordController.text.length<6){
      showInSnackBar("your Password is too weak ", Colors.red, Colors.white, 2, context, _scaffoldKey);
    }else{
      showInWaitingSnackBar("Creating Account.....", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldKey);
      Future.delayed(Duration(seconds:2),(){
        signupAndCreateUserAccount();
      }
      );
    }
  }

  Future signupAndCreateUserAccount()async{
    DocumentSnapshot<Map<String , dynamic>>UserData;
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: SignupEmailController.text, 
        password: SignupPasswordController.text
        ).then((UserCredential) async{
          //email verification
          if(UserCredential.user!=null){
            UserCredential.user.sendEmailVerification().then((MetaData) async {
              try {
              FirebaseFirestore.instance.collection('UsersAccount').doc(UserCredential.user.uid).set({
                'UserID':UserCredential.user.uid,
                'UserEmail':UserCredential.user.email,
                'UserName':NameController.text,
                'UserPhone':PhoneNumController.text,
                'AccountCreatedDuration':DateTime.now(),
                'isEmailVerified':UserCredential.user.emailVerified,
              }).then((value) async{
                FirebaseFirestore.instance.collection('UsersAccount').doc(UserCredential.user.uid).get().then((UserDBData) async {
                  setState(() {
                    UserData=UserDBData;
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  clearConrollers();
                  await FirebaseAuth.instance.signOut();
                  showInSnackBar("A Verfication Email have been sent", Color.fromARGB(255, 65, 10, 167), Colors.white, 4, context, _scaffoldKey);
                  Future.delayed(Duration(seconds:2),(){
                    setState(() {
                      isLoginActivated=true;
                    });
                  });
                });
              });
            }catch (e) {
               await FirebaseAuth.instance.currentUser.delete().then((value){
                 FirebaseAuth.instance.signOut().then((value){
                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
                 showInSnackBar("erorr occur due to account creation", Colors.red, Colors.white, 2, context, _scaffoldKey);
                 });
               });
            }
          });
            
          }
        });
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showInSnackBar(e.message.trim(), Colors.red, Colors.white, 2, context, _scaffoldKey);
    }
  }

  clearConrollers(){
    NameController.clear();
    PhoneNumController.clear();
    SignupEmailController.clear(); 
    SignupPasswordController.clear();
    LoginEmailController.clear();
    LoginPasswordController.clear();
 }
}
 
 