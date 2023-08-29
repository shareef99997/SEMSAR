import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../moduls/SnackBar.dart';
import '../../HomePage.dart';
class willcontact extends StatefulWidget {
  const willcontact({Key key,this.userData, this.request}) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;
  final Map<String,dynamic>request;
  @override
  State<willcontact> createState() => _willcontactState();
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
//replacement
//////////////////////////////////////////////////////////////////////////////////////////////////////////

class _willcontactState extends State<willcontact> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  String loaderText = '⏳';
  bool orderFinish=false;

  @override
  void initState(){
    saveRequest();
    super.initState();
  }

  saveRequest()async{
    try {
      Future.delayed(Duration(seconds: 3),()async{
        await FirebaseFirestore.instance.collection('ContactRequest').add(widget.request).then((reqDoc)async{
          if (!mounted)return;
          Future.delayed(Duration(seconds:2),(){
            setState(() {
            loaderText ='All Done ✅';
            orderFinish = true;
          });});
          
          showInWaitingSnackBar("We wil contact you soon ", Color.fromARGB(255, 4, 170, 23), Colors.white, context, _scaffoldkey);
          Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => HomePage(userData : widget.userData,
         )));
        }  
        );
      });
    } catch (e) {
      Future.delayed(Duration(seconds: 3),()async{
        if (!mounted) return;
        showInSnackBar('Cannot Request Contact due to an error', Colors.red, Colors.white, 10, context, _scaffoldkey);
         Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (BuildContext context) => HomePage(userData : widget.userData,
         )));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 25, 26, 29),
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