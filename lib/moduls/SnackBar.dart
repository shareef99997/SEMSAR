import 'package:flutter/material.dart';

showInSnackBar(String value,Color backgroundColor,Color textColor,int duration,BuildContext context,GlobalKey<ScaffoldState>_scaffoldKey){
  FocusScope.of(context).requestFocus(FocusNode());//Request Keyboard to hide
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color:backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child:Padding(
          padding:EdgeInsets.all(3.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontFamily: "WorkSansSemiBold"
            ),
          ),
          )
          ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    duration: Duration(seconds: duration),
    )
    );
}
showInWaitingSnackBar(String value,Color backgroundColor,Color textColor,BuildContext context,GlobalKey<ScaffoldState>_scaffoldKey){
 FocusScope.of(context).requestFocus(FocusNode());//Request Keyboard to hide
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color:backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child:Padding(
          padding:EdgeInsets.all(3.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontFamily: "WorkSansSemiBold"
            ),
          ),
          )
          ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    )
    );
}