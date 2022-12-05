import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_login.dart';
import 'package:my_apart/page1.dart';



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

  // DatabaseReference db = FirebaseDatabase.instance.ref().child("Users");
  final CollectionReference Collection = FirebaseFirestore.instance.collection("Secretary");

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:Container(
            decoration: BoxDecoration(
                
            ),
            child: Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title: Text("Sing Up",style: TextStyle(color: Colors.deepOrangeAccent),),
                leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.deepOrangeAccent,),onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => admin_login()));
                  },),
              ),
              backgroundColor: Colors.transparent,
              body: Form(
                key: form_key,
                child: SingleChildScrollView(
                  child: Padding(padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: nameEditController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.grey.shade100
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                            }
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                            controller: emailEditController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.grey.shade100
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                            }
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: passEditController,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Create Password",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.grey.shade100
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              else if(value.length<8)
                              {
                                return "Password length must be 8 or more";
                              }
                            }
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: flatEditController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Flat Number",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.grey.shade100
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Flat cannot be empty";
                              }
                            }
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                            controller: vehicleEditController,
                            decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter number of vehicles",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.grey.shade100
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Vehicle cannot be empty";
                              }
                            }
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                          child: ElevatedButton(
                            child:Text("Register"),
                            onPressed: ()  {
                              if(form_key.currentState!.validate())
                              {
                                FirebaseAuth.instance.createUserWithEmailAndPassword
                                  (email: emailEditController.text, password: passEditController.text
                                )
                                    .then((value) { Navigator.push(context, MaterialPageRoute(builder: (context) => page1()));
                                Fluttertoast.showToast(msg: "Registration Successful");
                                FirebaseAuth.instance.signOut();

                                Collection.doc(FirebaseAuth.instance.currentUser!.uid).set(
                                    {
                                      'Name':nameEditController.text,
                                      'Email':emailEditController.text,
                                      'Password':passEditController.text,
                                      'Flat Number':flatEditController.text,
                                      'Number of vehicles':vehicleEditController.text,
                                      "groups": [],
                                      'userUid':FirebaseAuth.instance.currentUser!.uid
                                    }
                                );
                                  /*Map<String,String> user =
                                {
                                  'Name':nameEditController.text,
                                  'Email':emailEditController.text,
                                  'Password':passEditController.text,
                                  'Role':dropdownValue
                                };

                                db.push().set(user);*/

                                }).catchError((e)
                                {
                                  Fluttertoast.showToast(msg: "Registration Failed");
                                }
                                );


                              }

                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        //SingUp(),
                      ],
                    ),
                  ),
                ),
              ),
            )
        )
    );
  }
}

