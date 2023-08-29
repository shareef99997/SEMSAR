import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key, this.userData}) : super(key: key);
  final DocumentSnapshot<Map<String, dynamic>> userData;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        body: ColorfulBackground(
            // Color changing animation duration
            duration: Duration(seconds: 10),
            // List colors to animate in the background
            backgroundColors: [
              Color.fromARGB(255, 214, 187, 241),
              Color.fromARGB(255, 255, 255, 255),
            ],
            child: Container(
      padding: EdgeInsets.all(2.0),
      height: 230,
      margin: EdgeInsets.only(top:40,bottom: 30,),
      child:DefaultTabController(
          length: 3,
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
                    //SEMSAR
                     Padding(
                      padding: EdgeInsets.all(10),
                      child:  Container(
                              //Decoration
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(25, 253, 253, 253),
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),                            
                              width: 300,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                     //Logo 
                                      Center(
                                        child : Image(image:AssetImage('assets/images/LOGO.png'),
                                        height: 70,
                                        width: 70,
                                        )
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Welcome To Your Home Service App',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('Just in Few Seconds',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('get you hand that Could help you\n with any home related Services',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
                                      ), 
                                      Spacer(),
                                      //Logo 
                                      Center(
                                        child : Image(image:AssetImage('assets/images/home.png'),
                                        height: 230,
                                        width: 230,
                                        )
                                      ),
                                    ],
                                  )
                                  ),
                            ),
                            
                     ),
                     //Workers
                     Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                              //Decoration
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(25, 253, 253, 253),
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),                            
                              width: 300,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                     //Logo 
                                      Center(
                                        child : Image(image:AssetImage('assets/images/LOGO.png'),
                                        height: 70,
                                        width: 70,
                                        )
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('you can choose between an ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('Elite Group of Workers',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('that are more than willing to help you\n with anything you want ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
                                      ), 
                                      Spacer(),
                                      //Logo 
                                      Center(
                                        child : Image(image:AssetImage('assets/images/human.png'),
                                        height: 230,
                                        width: 230,
                                        )
                                      ),
                                    ],
                                  )
                                  ),
                            ),
                               
                     ),
                     //new services
                     Padding(
                      padding: EdgeInsets.all(10),
                      child:  Container(
                              //Decoration
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(25, 253, 253, 253),
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(5, 5),
                                  ),
                                ],
                              ),
                              width: 300,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                     //Logo 
                                      Center(
                                        child : Image(image:AssetImage('assets/images/LOGO.png'),
                                        height: 70,
                                        width: 70,
                                        )
                                      ),
                                      //Semsar
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('New Services',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('Choose Between Diffrent Services',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
                                      ), 
                                      Spacer(),
                                      //Logos 
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Column(
                                            children: [
                                                Center(
                                                  child : Image(image:AssetImage('assets/images/maid.png'),
                                                  height: 70,
                                                  width: 70,
                                                  )
                                                ),
                                                SizedBox(height: 5,),
                                                  Center(
                                                  child : Image(image:AssetImage('assets/images/electrician.png'),
                                                  height: 70,
                                                  width: 70,
                                                  )
                                                ),
                                            ],
                                          ),
                                          Spacer(),
                                          Center(
                                                  child : Image(image:AssetImage('assets/images/plumber.png'),
                                                  height: 70,
                                                  width: 70,
                                                  )
                                                ),
                                          Spacer(),
                                          Column(
                                            children: [
                                                Center(
                                                  child : Image(image:AssetImage('assets/images/barber.png'),
                                                  height: 70,
                                                  width: 70,
                                                  )
                                                ),
                                                SizedBox(height: 5,),
                                                  Center(
                                                  child : Image(image:AssetImage('assets/images/mechanic.png'),
                                                  height: 70,
                                                  width: 70,
                                                  )
                                                ),
                                            ],
                                            ),
                                          SizedBox(width: 20,)
                                        ],
                                        ),
                                        SizedBox(height: 30,)
                                    ],
                                  )
                                  ),
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
    )
    )
    );
        //     Padding(
        //     padding: EdgeInsets.all(10),
        //     child: ListView(
        //       padding: EdgeInsets.only(top: 15),
        //       children: [
        //         Column(
        //           children: [
        //             Text(
        //               'Version 1.0  ',
        //               style: TextStyle(fontSize: 20, color: Colors.white),
        //             ),
        //             SizedBox(height: 50),
        //             //ListView H
        //             Container(
        //                 height: 500,
        //                 child: ListView(
        //                   scrollDirection: Axis.horizontal,
        //                   //List View Com
        //                   children: [
        //                     //Welcome
        //                     Container(
        //                       //Decoration
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(30.0),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Color.fromARGB(25, 253, 253, 253),
        //                             blurStyle: BlurStyle.outer,
        //                             offset: Offset(5, 5),
        //                           ),
        //                         ],
        //                       ),                            
        //                       width: 300,
        //                       child: Center(
        //                           child: Column(
        //                             children: [
        //                               SizedBox(height: 20,),
        //                              //Logo 
        //                               Center(
        //                                 child : Image(image:AssetImage('assets/images/LOGO.png'),
        //                                 height: 70,
        //                                 width: 70,
        //                                 )
        //                               ),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [
        //                                   Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
        //                                 ],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [
        //                                   Text('Welcome To Your Home Service App',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
        //                                 ],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('Just in Few Seconds',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('get you hand that Could help you\n with any home related Services',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
        //                               ), 
        //                               Spacer(),
        //                               //Logo 
        //                               Center(
        //                                 child : Image(image:AssetImage('assets/images/home.png'),
        //                                 height: 230,
        //                                 width: 230,
        //                                 )
        //                               ),
        //                             ],
        //                           )
        //                           ),
        //                     ),
        //                     SizedBox(width: 5,),
        //                     //Services
        //                     Container(
        //                       //Decoration
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(30.0),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Color.fromARGB(25, 253, 253, 253),
        //                             blurStyle: BlurStyle.outer,
        //                             offset: Offset(5, 5),
        //                           ),
        //                         ],
        //                       ),
        //                       width: 300,
        //                       child: Center(
        //                           child: Column(
        //                             children: [
        //                               SizedBox(height: 20,),
        //                              //Logo 
        //                               Center(
        //                                 child : Image(image:AssetImage('assets/images/LOGO.png'),
        //                                 height: 70,
        //                                 width: 70,
        //                                 )
        //                               ),
        //                               //Semsar
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [
        //                                   Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
        //                                 ],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('New Services',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('Choose Between Diffrent Services',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
        //                               ), 
        //                               Spacer(),
        //                               //Logos 
        //                               Row(
        //                                 children: [
        //                                   SizedBox(width: 20,),
        //                                   Column(
        //                                     children: [
        //                                         Center(
        //                                           child : Image(image:AssetImage('assets/images/maid.png'),
        //                                           height: 70,
        //                                           width: 70,
        //                                           )
        //                                         ),
        //                                         SizedBox(height: 5,),
        //                                           Center(
        //                                           child : Image(image:AssetImage('assets/images/electrician.png'),
        //                                           height: 70,
        //                                           width: 70,
        //                                           )
        //                                         ),
        //                                     ],
        //                                   ),
        //                                   Spacer(),
        //                                   Center(
        //                                           child : Image(image:AssetImage('assets/images/plumber.png'),
        //                                           height: 70,
        //                                           width: 70,
        //                                           )
        //                                         ),
        //                                   Spacer(),
        //                                   Column(
        //                                     children: [
        //                                         Center(
        //                                           child : Image(image:AssetImage('assets/images/barber.png'),
        //                                           height: 70,
        //                                           width: 70,
        //                                           )
        //                                         ),
        //                                         SizedBox(height: 5,),
        //                                           Center(
        //                                           child : Image(image:AssetImage('assets/images/mechanic.png'),
        //                                           height: 70,
        //                                           width: 70,
        //                                           )
        //                                         ),
        //                                     ],
        //                                     ),
        //                                   SizedBox(width: 20,)
        //                                 ],
        //                                 ),
        //                                 SizedBox(height: 30,)
        //                             ],
        //                           )
        //                           ),
        //                     ),
        //                     SizedBox(width: 5,),
        //                     //Workers
        //                     Container(
        //                       //Decoration
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(30.0),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Color.fromARGB(25, 253, 253, 253),
        //                             blurStyle: BlurStyle.outer,
        //                             offset: Offset(5, 5),
        //                           ),
        //                         ],
        //                       ),                            
        //                       width: 300,
        //                       child: Center(
        //                           child: Column(
        //                             children: [
        //                               SizedBox(height: 20,),
        //                              //Logo 
        //                               Center(
        //                                 child : Image(image:AssetImage('assets/images/LOGO.png'),
        //                                 height: 70,
        //                                 width: 70,
        //                                 )
        //                               ),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [
        //                                   Text('SEMSAR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
        //                                 ],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('you can choose between an ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('Elite Group of Workers',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.purple),)],
        //                               ),
        //                               SizedBox(height: 20,),
        //                               Row(mainAxisAlignment: MainAxisAlignment.center,
        //                                 children: [Text('that are more than willing to help you\n with anything you want ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)],
        //                               ), 
        //                               Spacer(),
        //                               //Logo 
        //                               Center(
        //                                 child : Image(image:AssetImage('assets/images/human.png'),
        //                                 height: 230,
        //                                 width: 230,
        //                                 )
        //                               ),
        //                             ],
        //                           )
        //                           ),
        //                     ),
        //                   ],
        //                 ))
        //           ],
        //         )
        //       ],
        //     )
        //     ), 
        // ));
  }
}
