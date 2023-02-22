import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/Mamber/user_home.dart';

import '../Mamber/main_paid_list.dart';
import '../constants/colors.dart';

class maintenance_member extends StatefulWidget {
  const maintenance_member({Key? key}) : super(key: key);

  @override
  State<maintenance_member> createState() => _maintenance_memberState();
}

class _maintenance_memberState extends State<maintenance_member> {
  final form_key = GlobalKey<FormState>();


  TextEditingController discriptionEditController = TextEditingController();
  TextEditingController timeEditController = TextEditingController();
  TextEditingController dateEditController = TextEditingController();

  final CollectionReference CollectionIncome =
  FirebaseFirestore.instance.collection("Secretary");

  String userid = "";
  String id = "";
  String name = "";
  int amount = 0;

  String flat = "";

  String tid = "";
  String userid2 = "";
  int income = 0;
  var date;

  int flag = 0;
  String res = "";

  late int a;

  DateTime selectedDate = DateTime.now();
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  Future<void> _selectSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100, 01));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {

    FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
    // ignore: avoid_function_literals_in_foreach_calls
    value.docs.forEach((snapshot)
    {
      // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
      if(FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid) != null)
      {

        FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value)
        {
          setState(() {
            userid = value.get("userUid");
            name = value.get("Name");
            res = value.get("Event_request_answer");
            flat = value.get("Flat Number");

            if(userid == FirebaseAuth.instance.currentUser!.uid)
            {
              id = snapshot.id;

              FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Total").get().then((value) =>
                  value.docs.forEach((snapshot)
                  {
                    FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Total").doc(snapshot.id).get().then((value) {
                      userid2 = value.get("userUid");
                      if(userid2 == id)
                      {
                        tid = snapshot.id;
                        FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Total").doc(snapshot.id).get().then((value) {
                          income = value.get("total_income");
                        });
                      }
                    });
                  }));
              FirebaseFirestore.instance.collection("Secretary").doc(id).get().then((value) {
                setState(() {
                  amount = value.get("Amount_of_Maintenance");
                });
              });
            }
          });

        });
      }
    }
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Pay Maintenance!',
            style: TextStyle(
                color: prime, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color:  prime,
              ),
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => user_home()));
              })),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: form_key,
          child: ListView(padding: EdgeInsets.all(12.0), children: [
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Make Payment for Maintainance!',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Amount : ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blueGrey),),

                SizedBox(width: 10,),

                Text("$amount \u20B9",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black)),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectSelectDate(context);
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: prime,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.date_range,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]} , ${selectedDate.year}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),
            SizedBox(height: 20.0),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => member_list_maintainance()));
                }, child: Text('History of Maintenance')),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                child: const Text(
                  "PAY",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 241, 175, 68),
                ),
                onPressed: ()   {
                  List s1 = selectedDate.toString().split(" ");
                  String s2 = s1[0];

                  if(form_key.currentState!.validate())
                  {
                    showDialog(context: context, builder: (context){
                      return AlertDialog(title:  Text("Make Payment"),
                        actions: [
                          Flat3dButton(onPressed:(){
                            Navigator.pop(context);
                          } ,child: Text("Cancel"),
                          ),
                          Flat3dButton(onPressed:(){

                            FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Total").doc(tid).update({
                              'total_income': income+amount
                            });

                            FirebaseFirestore.instance.collection("Secretary").doc(id)
                                .collection("Maintenance").doc(s2).collection(s2).doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "Name":name,
                              "Date":s1[0],
                              "Time":s1[1],
                              "Flat_No":flat,
                              "userUid":userid,
                              "Paid_Amount":amount.toString()
                            }).then((value) {
                              Fluttertoast.showToast(msg: "Payment Successful");
                              Navigator.pop(context);
                              FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Members")
                                  .doc(FirebaseAuth.instance.currentUser!.uid).collection("Member_Maintenance")
                                  .doc().set({
                                "Name":name,
                                "Date":s1[0],
                                "Time":s1[1],
                                "Flat_No":flat,
                                "userUid":userid,
                                "Paid_Amount":amount.toString()
                              });
                            }).catchError((e){
                              Fluttertoast.showToast(msg: "Payment Failed");
                            });
                          } ,child: Text("Pay"),
                          ),
                        ],
                      );
                    });
                    /**/
                  }

                },
              ),
            ),
          ]),
        ));
  }
}