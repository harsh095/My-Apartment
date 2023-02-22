import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/page1.dart';
import 'package:http/http.dart' as http;

import '../Main_Login.dart';

class admin_register extends StatefulWidget {
  const admin_register({Key? key}) : super(key: key);

  @override
  State<admin_register> createState() => _admin_registerState();
}

class _admin_registerState extends State<admin_register> {
  final form_key = GlobalKey<FormState>();

  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController flatEditController = TextEditingController();
  TextEditingController vehicleEditController = TextEditingController();

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_vey1luo';
    final templateId = 'template_qiah31s';
    final user_Id = 'ca87IkDgOuNvINnIq';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': user_Id,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': email,
            'user_subject': subject,
            'user_message': message,
          }
        }),
        headers: {
          'origin': 'http://locanhost',
          'Content-Type': 'application/json',
        });
    print(response.body);
  }

  // DatabaseReference db = FirebaseDatabase.instance.ref().child("Users");
  final CollectionReference Collection =
      FirebaseFirestore.instance.collection("Secretary");

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 247, 174, 57),
            title: Text(
              "Register Secretary",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => main_login()));
              },
            )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset("assets/images/login.png", fit: BoxFit.cover),
                Text(
                  "Get On Board!",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Form(
                      key: form_key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                              controller: nameEditController,
                              decoration: const InputDecoration(
                                  label: Text("Name"),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Color(0xffF9A826),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3.0, color: Colors.blueGrey))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name cannot be empty";
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: emailEditController,
                              decoration: const InputDecoration(
                                  label: Text("Email"),
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
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: passEditController,
                              decoration: const InputDecoration(
                                  label: Text("Create Password"),
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
                            height: 20,
                          ),
                          TextFormField(
                              controller: flatEditController,
                              decoration: const InputDecoration(
                                  label: Text("Flat Number"),
                                  prefixIcon: Icon(
                                    Icons.house_rounded,
                                    color: Color(0xffF9A826),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3.0, color: Colors.blueGrey))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Flat cannot be empty";
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: vehicleEditController,
                              decoration: const InputDecoration(
                                  label: Text("Enter A number of Vehicle"),
                                  prefixIcon: Icon(
                                    Icons.car_crash_outlined,
                                    color: Color(0xffF9A826),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3.0, color: Colors.blueGrey))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Vehicle cannot be empty";
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 241, 175, 68),
                                ),
                                onPressed: () {
                                  if (form_key.currentState!.validate()) {
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailEditController.text,
                                            password: passEditController.text)
                                        .then((value) {
                                      FirebaseAuth.instance.signOut();

                                      FirebaseFirestore.instance
                                          .collection("Secretary")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection("Total")
                                          .doc()
                                          .set({
                                        'total_income': 0,
                                        'total_expense': 0,
                                        'userUid': FirebaseAuth
                                            .instance.currentUser!.uid,
                                      });
                                      Collection.doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .set({
                                        'Name': nameEditController.text,
                                        'Email': emailEditController.text,
                                        'Password': passEditController.text,
                                        'Flat Number': flatEditController.text,
                                        'Number of vehicles':
                                            vehicleEditController.text,
                                        "groups": [],
                                        "Profile_Image": "",
                                        "Amount_of_Maintenance": 0,
                                        'userUid': FirebaseAuth
                                            .instance.currentUser!.uid
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Registration Successful");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  main_login()));
                                      sendEmail(
                                          name: nameEditController.text,
                                          email: emailEditController.text,
                                          subject: 'To Notify',
                                          message:
                                              'Registration Successful, Thank you');
                                    }).catchError((e) {
                                      Fluttertoast.showToast(
                                          msg: "Registration Failed");
                                    });
                                  }
                                }),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
