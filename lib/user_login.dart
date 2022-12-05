import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/admin_register.dart';
import 'package:my_apart/forget_password_admin.dart';
import 'package:my_apart/forget_password_user.dart';
import 'package:my_apart/user_home.dart';

class user_login extends StatefulWidget {
  const user_login({Key? key}) : super(key: key);

  @override
  State<user_login> createState() => _user_loginState();
}

class _user_loginState extends State<user_login> {
  final form_key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email = "";
  String pass = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Container(
              // padding: EdgeInsets.all(tDefualtSize),

              child: Column(
                children: [
                  Image.asset("assets/images/login.png", fit: BoxFit.cover),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Good to see you agian!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /*   Text(
                "Secertory Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffF9A826),
                ),
              ), */
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40.0, horizontal: 20),
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
                            }),
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
                              } else if (value.length < 8) {
                                return "Password length must be 8 or more";
                              }
                            }),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          forgot_password_member()));
                            },
                            child: Text('Forget Password?')),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 241, 175, 68),
                              ),
                              onPressed: () {
                                if (form_key.currentState!.validate()) {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passController.text)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => user_home()));
                                    Fluttertoast.showToast(
                                      msg: "Login Successful",
                                    );
                                  }).catchError((e) {
                                    Fluttertoast.showToast(msg: "Login failed");
                                  });
                                }
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
