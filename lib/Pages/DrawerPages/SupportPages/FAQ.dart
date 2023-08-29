
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldkey,
        backgroundColor: Color.fromARGB(255, 25, 26, 29),
        //Body
        body: ColorfulBackground(
     // Color changing animation duration
     duration: Duration(seconds: 10),
     // List colors to animate in the background
     backgroundColors: [
       Color.fromARGB(255, 214, 187, 241),
       Color.fromARGB(255, 255, 255, 255),
     ],
     child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: ListView(
                  children: [
                    SizedBox(height: 30,),
                    //Contact Info
                    Text('   FAQ\'s:',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Color.fromARGB(255, 39, 12, 75)),),
                    SizedBox(height: 40,),
                    //Q1
                    GFAccordion(
                          titleChild: Row(children: [
                            Text('What Is (Semsar) ?',style :TextStyle(fontSize: 20,color:Colors.white )),
                          ],),
                          contentChild: Text('When Ever , where ever you need a service\nSEMSAR is the best choice for you\nwhere you can book a worker by your choice\nand we will deliver him/her to your own doorstep .\n\noh And semsar means broker in arabic 😉  ',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(30),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 5,),
                    //Q2
                      GFAccordion(
                          titleChild: Row(children: [
                            Text('What services do\nSemsar Present ?',style :TextStyle(fontSize: 20,color:Colors.white )),
                          ],),
                          contentChild: Text('Semsar is a broker that offers a range of useful services,\n\nwhether homeservices or not,  which are:\nHouseKeeper,Plumber,Mechanic,Electrician\nand a Barber ',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(30),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 5,),
                    //Q3
                    GFAccordion(
                          titleChild: Row(children: [
                            Text('What about Workers ?',style :TextStyle(fontSize: 20,color:Colors.white )),
                          ],),
                          contentChild: Text('Semsar has a group of reliable and highly experienced workers who are official employees of the company',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(30),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 5,),
                    //Q4
                    GFAccordion(
                          titleChild: Row(children: [
                            Text('How dose semsar\nset the fees ?',style :TextStyle(fontSize: 20,color:Colors.white )),
                          ],),
                          contentChild: Text('Some services are charged on the service itself,\nsuch as a houseKeeper and a Barber,\nAnd some other services fees are calculate for the arrival of the worker and examining the problem, such as\nPlumber,Mechanic and Electrician\nafter that hand work fees are aranged between the worker and the customer ',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(30),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 5,),
                    //Q5
                    GFAccordion(
                          titleChild: Row(children: [
                            Text('Why are there no\nhand work fees\nfor some services  ?',style :TextStyle(fontSize: 18,color:Colors.white )),
                          ],),
                          contentChild: Text('Some services require an examination of the problem before setting an amount for it so that fees are not calculated higher or lower than what the service itself cost\nso its up to the worker to set the hand work fees',style :TextStyle(fontSize: 13,color:Colors.white.withOpacity(0.7) )),
                          collapsedIcon: Icon(Icons.add,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),     
                          expandedIcon: Icon(Icons.minimize,color: Color.fromARGB(255, 209, 203, 254) .withOpacity(0.6),),
                          collapsedTitleBackgroundColor:Color.fromARGB(158, 45, 8, 62) ,
                          expandedTitleBackgroundColor: Color.fromARGB(158, 45, 8, 62),
                          contentBackgroundColor:Color.fromARGB(158, 65, 41, 77) ,
                          titleBorderRadius: BorderRadius.circular(10),
                          contentBorderRadius: BorderRadius.circular(10),
                          titlePadding: EdgeInsets.all(30),
                          contentPadding: EdgeInsets.all(20),
                      ),
                    SizedBox(height: 5,),
                  ]
                )
            )
        )
    ,
)
        );
  }
}