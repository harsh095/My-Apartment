import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/admin_login.dart';
import 'package:my_apart/member_list.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final form_key = GlobalKey<FormState>();

  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  TextEditingController nameEditController = TextEditingController();
  TextEditingController flatEditController = TextEditingController();
  TextEditingController vehicleEditController = TextEditingController();

  // DatabaseReference db = FirebaseDatabase.instance.ref().child("Users");
  final CollectionReference Collection = FirebaseFirestore.instance.collection(
      "Secretary");
  final user = FirebaseAuth.instance.currentUser;
  //final email = FirebaseAuth.instance.currentUser!.email;
  late String email;
  late String pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      email = value.get("Email");
      pass = value.get("Password");
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(backgroundColor: Color.fromARGB(255, 247, 174, 57),title: Text("Add New Mamber",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
    leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));
        },
    )),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Image.asset("assets/images/login.png", fit: BoxFit.cover),
                Text("Get On Board!",style: TextStyle(color: Colors.blueGrey,fontSize: 30,fontWeight: FontWeight.bold),),
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
                          }
                      ),
                      SizedBox(height: 20,),
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
                          }
                      ),
                          SizedBox(height: 20,),
                      TextFormField(
                        controller:passEditController,
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
                            }
                            else if (value.length < 8) {
                              return "Password length must be 8 or more";
                            }
                          }
                      ),
                          SizedBox(height:20,),
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
                          }
                      ),
                          SizedBox(height: 20,),
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
                          }
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()  {
                            if (form_key.currentState!.validate()) {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword
                                (email: emailEditController.text,
                                  password: passEditController.text
                              ).then((value) {

                                Collection.doc(user!.uid).collection(
                                    "Members").doc(
                                    FirebaseAuth.instance.currentUser!.uid).
                                set(
                                    {
                                      'Name':nameEditController.text,
                                      'Email':emailEditController.text,
                                      'Password':passEditController.text,
                                      'Flat Number':flatEditController.text,
                                      'Number of vehicles':vehicleEditController.text,
                                      "groups": [],
                                      'userUid':FirebaseAuth.instance.currentUser!.uid,
                                      'AdminUid':user!.uid
                                    }

                                ).then((value) {
                                  Fluttertoast.showToast(
                                      msg: "Member added Successfully");
                                  FirebaseAuth.instance.signOut();
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>admin_home()));
                                  //FirebaseAuth.instance.signInWithEmailAndPassword(email: , password:);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => member_list()));
                                  //FirebaseAuth.instance.tenantId(user.uid);
                                });
                                FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                              }).catchError((e) {
                                Fluttertoast.showToast(
                                    msg: "Registration Failed");
                              });
                            }
                            // FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                          },


                         child: const Text("Add Member",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 241, 175, 68),
                                  ),
                         ),
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
