import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/admin_register.dart';
import 'package:my_apart/forget_password_admin.dart';

import 'f_login.dart';



class admin_login extends StatefulWidget {
  const admin_login({Key? key}) : super(key: key);

  @override
  State<admin_login> createState() => _admin_loginState();
}

class _admin_loginState extends State<admin_login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String email="";
  String pass ="";
  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => f_login()));
            },
            )),
      backgroundColor: Colors.white,
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
                Text("Secertory Login",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
               
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
                            height: 30.0,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => forgot_password_admin()));
                              }, child: Text('Forget Password')),
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
                                    setState(() {
                                      email = emailController.text;
                                      pass = passController.text;
                                    });
                                    if(form_key.currentState!.validate())
                                    {
                                      FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text)
                                          .then((value) { Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home(
                                      )));
                                      Fluttertoast.showToast(msg: "Login Successful",);
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
                          Center(child: Text("OR",style: TextStyle(color: Colors.blueGrey,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic))),
                          SizedBox(
                            height: 15.0,
                          ),
                          //TextButton(onPressed: (){}, child: Text('Forget Password')),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'Sing Up Admin',
                                  style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 241, 175, 68),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => admin_register()));
                                },
                              ))
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
