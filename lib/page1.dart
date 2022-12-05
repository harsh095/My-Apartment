import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/f_login.dart';
import 'package:my_apart/user_home.dart';
//import 'package:my_apartment/admin_home.dart';
//import 'package:my_apartment/chek_auth.dart';
//import 'package:my_apartment/f_login.dart';
//import 'package:my_apartment/user_home.dart';

class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot)
         {
          if(snapshot.hasData)
          {
           return Container(
             child: fun(),
           );
          }
          else
         {
           return f_login();
         }
        }
      )
    );
  }
fun()
{
  FirebaseFirestore.instance
      .collection('Secretary')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.get("userUid") == FirebaseAuth.instance.currentUser!.uid)
    {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => admin_home()));
    }
  });


  FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
      value.docs.forEach((snapshot)
      {
        FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((snapshot) {
          if (snapshot.get("userUid") == FirebaseAuth.instance.currentUser!.uid)
          {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => user_home()));
          }
        });
      }
      ));
}

}

