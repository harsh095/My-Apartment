import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/user_home.dart';

// ignore: camel_case_types
class user_profile extends StatefulWidget {
  const user_profile({super.key});

  @override
  State<user_profile> createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  

  String name = "";
  String email = "";
  String flat_no = "";
  String vehicles = "";
    Future get() async
  {
    FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
        value.docs.forEach((snapshot)
        {
          FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((snapshot) {
            if (snapshot.get("userUid") == FirebaseAuth.instance.currentUser!.uid)
            {
              setState(()
                  {
                    name = snapshot.data()!["Name"];
                    email = snapshot.data()!["Email"];
                    flat_no = snapshot.data()!["Flat Number"];
                    vehicles = snapshot.data()!["Number of vehicles"];
                  }
              );
            }
            
          });
        }
        ));

  }
  void initState()
  {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (() { Navigator.push(context,
                          MaterialPageRoute(builder: (context) => user_home())); }) ),
        
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text('Name : '+name,style: TextStyle(fontSize: 25),),
                  Text('Email : '+email,style: TextStyle(fontSize: 25),),
                  Text('Flte NO : '+flat_no,style: TextStyle(fontSize:25),),
                  Text('No Of vehicles : '+vehicles,style: TextStyle(fontSize: 25),)
                     
                   
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter:  HeaderCurvedContaine(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(20),
              child: Text("Profile",style: TextStyle(
                fontSize: 35,
                letterSpacing: 1.5,
                color: Colors.white,
                fontWeight: FontWeight.w600),),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/profile.png'),

                    ),
                     )


                  ),

              
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270,left: 184),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
            )
        ],
        ),
    );
  }
}
class HeaderCurvedContaine extends CustomPainter
{
  @override
  void paint(Canvas canvas, size)
  {
    Paint paint=Paint()..color=Colors.blueGrey;
    Path path=Path()..relativeLineTo(0, 150)..quadraticBezierTo(size.width/2, 225, size.width, 150)..relativeLineTo(0,-150)..close();
    canvas.drawPath(path, paint);
  } 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}