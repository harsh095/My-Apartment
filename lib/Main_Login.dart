import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/Mamber/mamber_register.dart';
import 'package:my_apart/Sacretary/admin_home.dart';
import 'package:my_apart/Sacretary/admin_register.dart';
import 'package:my_apart/Sacretary/forget_password_admin.dart';

import '../constants/colors.dart';

import 'Mamber/user_home.dart';



class main_login extends StatefulWidget {
  const main_login({Key? key}) : super(key: key);

  @override
  State<main_login> createState() => _main_loginState();
}

class _main_loginState extends State<main_login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email="";
  String pass ="";
  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Container(
              // padding: EdgeInsets.all(tDefualtSize),

              child: Column(
                children: [
                  Image.asset("assets/images/Email1.png", fit: BoxFit.cover),
                  // SizedBox(height: 30,),
                  Text(
                    "Good to see you agian!",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic
                    ),
                  ),

                  SizedBox(
                    height: 25.0,
                  ),


                  Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                label: Text("Enter Email"),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xffF9A826),
                                ),
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.blueGrey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3.0, color: Colors.blueGrey))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                            }
                        ),
                        SizedBox(height: 10.0, width: 10.0),

                        TextFormField(
                            controller: passController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                label: Text("Enter Password"),
                                prefixIcon: Icon(
                                  Icons.fingerprint_outlined,
                                  color: Color(0xffF9A826),
                                ),
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.blueGrey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3.0, color: Colors.blueGrey))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              else if (value.length < 8) {
                                return "Password length must be 8 or more";
                              }
                            }
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => forgot_password_admin()));
                            }, child: Text('Forget Password')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => admin_register()));
                            }, child: Text('Sign Up For Secretary')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => member_register()));
                            }, child: Text('Sign Up For Member')),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 241, 175, 68),
                                ),
                                onPressed: () {
                                  if(form_key.currentState!.validate())
                                  {
                                    email = emailController.text;
                                    pass = passController.text;
                                    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text)
                                        .then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Secretary')
                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                          .get()
                                          .then((DocumentSnapshot documentSnapshot) {
                                        if (documentSnapshot.get("userUid") == FirebaseAuth.instance.currentUser!.uid)
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => admin_home()));
                                          Fluttertoast.showToast(msg: "Login Successful",);
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
                                                Fluttertoast.showToast(msg: "Login Successful",);
                                              }
                                            });
                                          }
                                          ));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));

                                    }).catchError((e)
                                    {
                                      Fluttertoast.showToast(msg: "Login failed");
                                    });
                                  }
                                }
                            )),
                        SizedBox(
                          height: 15.0,
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
