import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Sacretary/admin_home.dart';
import '../constants/colors.dart';


class maintenance_admin extends StatefulWidget {
  const maintenance_admin({Key? key}) : super(key: key);

  @override
  State<maintenance_admin> createState() => _maintenance_adminState();
}

class _maintenance_adminState extends State<maintenance_admin> {
  final form_key = GlobalKey<FormState>();


  final CollectionReference CollectionIncome =
  FirebaseFirestore.instance.collection("Secretary");

  String name = "";
  int amount = 0;
  String dummy = "";
  String flat = "";
  String userid = "";
  String id = "";
  int income = 0;

  var date;

  int flag = 0;
  String res = "";

  late int a;
  final CollectionReference CollectionTotal = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Total");
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

    FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        name = value.get("Name");
        flat = value.get("Flat Number");
        amount = value.get("Amount_of_Maintenance");
      });
    });
    CollectionTotal.get().then((value) =>
        value.docs.forEach((snapshot)
        {
          CollectionTotal.doc(snapshot.id).get().then((value) {
            userid = value.get("userUid");
            if(userid == FirebaseAuth.instance.currentUser!.uid)
            {
              id = snapshot.id;
              CollectionTotal.doc(snapshot.id).get().then((value) {
                income = value.get("total_income");
              });
            }
          });
        }));
    super.initState();
  }

  String update_amount = "";

  displayAmountTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Amount of Maintanance'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_amount = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Amount"),
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('Cancle',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  amount_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => maintenance_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Request for Use',
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
                    MaterialPageRoute(builder: (context) => admin_home()));
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

                Text("$amount",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black)),
                IconButton(onPressed: (){displayAmountTextDialog(context);}, icon: Icon(Icons.edit),),
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
                        color:  prime,
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
                  //int ans = income+amount.
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
                            CollectionTotal.doc(id).update({
                              'total_income':income+amount
                            });
                            FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("Maintenance").doc(s2).collection(s2).doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "Name":name,
                              "Date":s1[0],
                              "Time":s1[1],
                              "Flat_No":flat,
                              "userUid":FirebaseAuth.instance.currentUser!.uid,
                              "Paid_Amount":amount.toString()
                            }).then((value) {
                              Fluttertoast.showToast(msg: "Payment Successful");
                              Navigator.pop(context);
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

  Future amount_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Amount_of_Maintenance': int.parse(update_amount) ,
    });

  }

}