
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Authentecation/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final MediaQueryData = MediaQuery.of(context);
        final scale = MediaQueryData.textScaleFactor.clamp(1,1.1);
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: scale), child: child);
      },
      title: "SEMSAR",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
