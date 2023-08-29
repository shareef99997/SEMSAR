
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import '../../moduls/SnackBar.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({Key key,this.userData}) : super(key: key);
  final DocumentSnapshot<Map<String,dynamic>>userData;
  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  
  @override
  void initState() { 
    getuser();
    super.initState();

  }  
  QuerySnapshot<Map<String, dynamic>> order;
  var user;


  Future getuser()async{

    await FirebaseFirestore.instance.collection('UsersAccount')
    .doc(widget.userData.data()['UserID'])
    .get().then((value) async{
      setState(() {
        user = value ;
        print('==============USER==================');
        print(widget.userData.data()['UserID']);
      });
    },).then((value) async{
          await FirebaseFirestore.instance.collection('Orders')
            .where('UserID',isEqualTo:widget.userData.data()['UserID'])
            .orderBy('OrderTime',descending: true)
            .get().then((value) {
              if (value.docs.isNotEmpty){
                setState(() {
                order = value;
                print('===============ORDER=================');
                print(order.docs);
              });
              }else{
                print('NO DOCUMENTS FOUND FOR THIS USER');
              }
      
    },);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Color.fromARGB(255, 233, 217, 252),
      //AppBar
      appBar:AppBar(
        toolbarHeight: 65.0,
        backgroundColor: Color.fromARGB(255, 39, 12, 75),
        elevation: 10,
        title: Text("Reservations",style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
     //Body
      body:ColorfulBackground(
          // Color changing animation duration
          duration: Duration(seconds: 10),
          // List colors to animate in the background
          backgroundColors: [
            Color.fromARGB(255, 214, 187, 241),
            Color.fromARGB(255, 255, 255, 255),
          ],
          child:Order(context)
         )
    );
  }




   Widget Order(BuildContext context){
     return DelayedDisplay(
    delay: Duration(milliseconds:50 ),
    child: Padding(
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(2.0),
            child: order!=null ? ListView.builder(
              itemCount: order.docs.length,              
              itemBuilder: (BuildContext context,int Index){
                //Orders
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(182, 45, 8, 62),
                    borderRadius: BorderRadius.circular(15),                 
                  ),         
                  child: ListTile(
                  onTap:() {
                        OrderDialog(Index);
                      }, 
                  title:    Padding(padding: EdgeInsets.only(top: 10),child:Text('#${order.docs[Index].data()['OrderNo']}',style: TextStyle(color: Color.fromARGB(187, 255, 153, 0),fontSize: 20))),
                  subtitle: Padding(padding: EdgeInsets.only(top: 26),child:Text('${order.docs[Index].data()['ServiceDate']}',style: TextStyle(color: Colors.white,fontSize: 15))),
                  trailing: Padding(padding: EdgeInsets.only(top: 20),child:Text(order.docs[Index].data()['Service'],style: TextStyle(color: Color.fromARGB(255, 217, 173, 249),fontSize: 15))),
                )
                  ,
                );},
              
            ):NoOrder(context)
            )
     ));
   }



  Future OrderDialog(Index) => showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: 
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50,right: 15,left: 15),
                      decoration:BoxDecoration(
                        color:Color.fromARGB(226, 45, 8, 62),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding:EdgeInsets.all(8.0),
                        child: Padding(
                    padding:EdgeInsets.all(8.0),   
                    child: GestureDetector(
                      onTap:(){
                        print('/////////////////////////////order\n${Index}\n///////////////////////////////////');
                      },
                    child:Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //OrderNo
                      Text('                    #${order.docs[Index].data()['OrderNo']}',style: TextStyle(fontSize: 20,color: Color.fromARGB(187, 255, 153, 0)),),
                        Divider(color: Color.fromARGB(255, 0, 0, 0),thickness: 2),
                      //Service
                      Text("Service:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['Service']}   ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      //Service Date
                      Text("Scheduled Date:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['ServiceDate']}   ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      //Worker
                      Text("Worker",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['WorkerName']}    ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      //Location
                      Text("Location:",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['UserAddress']}  ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      //PaymentType
                      Text("PaymentType",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['PaymentType']}  ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      //Fees
                      Text("PaymentType",style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 160, 119, 236)),),
                      SizedBox(height: 10,),
                      Text('       ${order.docs[Index].data()['ServiceFees']}  SAR',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,color: Colors.white ), ), 
                      SizedBox(height: 5,),
                      Divider(color: Colors.black,thickness: 2),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          OrdercheckDialog(Index);
                          
                            },
                        child: Container(
                        height: 50,
                        width: 230,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 167, 10, 10)),
                        child: Center(
                          child: Text(
                            "Cancel Order",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )),
                ),]
                      ),
                      ],
                  ),),
                     
                    )
                    ), ),
                    )])
      
                  
                );
                }
    );
 
  Future OrdercheckDialog(Index) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color.fromARGB(255, 25, 26, 29),
            elevation: 40,
            title: Text(
              'Are sure you want to cancel the order ?',
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
                  //cancel order
                GestureDetector(
                  onTap: (){
                      setState(() {
                          FirebaseFirestore.instance.collection('Orders').doc(order.docs[Index].id).delete();
                          showInSnackBar("Order Canceld !", Color.fromARGB(255, 229, 159, 28),Colors.white, 2, context, _scaffoldkey);
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => super.widget));
                            });
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


   Widget NoOrder(BuildContext context){
    return DelayedDisplay(
    delay: Duration(milliseconds:700 ),
    child: Column( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
        Icon(Icons.hourglass_empty_rounded,size: 100,color:Color.fromARGB(255, 65, 10, 167)),
        Container( alignment: Alignment.center,child:Text('you don\'t have any reservations',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color:Colors.white ), ), )
      ],
    ));
    
   }
}
  