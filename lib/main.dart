import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:my_apartment/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_apart/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Apartment',
      theme: ThemeData(
        fontFamily : GoogleFonts.lato().fontFamily,
      ),
      home: SplashScreen(),
     
    );
  }
}