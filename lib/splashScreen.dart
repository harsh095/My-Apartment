import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_apart/page1.dart';




class SplashScreen extends StatefulWidget
{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
        super.initState();
        Timer(Duration(seconds: 2), ()
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => page1() )));
        });
        
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body:  Center(
          child: Container(
            color:  Color(0xffffff),
            height: 300,
            width : 300,
            child: Image(
              image: AssetImage('assets/images/s1.png'),
            ),
          ),
        ),

     );
  }
 
}

