import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/constants/colors.dart';
import 'package:my_apart/maintenance/ex_admin_show.dart';
import 'package:my_apart/maintenance/select_maint.dart';

import 'admin_maintenance.dart';

class add_trans_ex extends StatefulWidget {
  const add_trans_ex({Key? key}) : super(key: key);
  @override
  _add_trans_exState createState() => _add_trans_exState();
}

class _add_trans_exState extends State<add_trans_ex> {
   final form_key = GlobalKey<FormState>();

TextEditingController moneyEditController = TextEditingController();
  TextEditingController discriptionEditController = TextEditingController();
 
  final CollectionReference CollectionIncome = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Income");
  final CollectionReference CollectionExpense = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Expanse");
  final CollectionReference CollectionTotal = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Total");

  var previous_income;
  var previous_expence;
  String userid = "";
  String id = "";
  @override
  void initState() {
    if(FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Total") == null)
      {
        CollectionTotal.doc().set({
        'total_income':0,
          'total_expense':0,
        'userUid':FirebaseAuth.instance.currentUser!.uid,
        });
      }
      CollectionTotal.get().then((value) =>
          value.docs.forEach((snapshot)
          {
            CollectionTotal.doc(snapshot.id).get().then((value) {
              userid = value.get("userUid");
              if(userid == FirebaseAuth.instance.currentUser!.uid)
              {
                setState(() {
                  id = value.get("userUid");
                  previous_income = value.get("total_income");
                  previous_expence = value.get("total_expense");
                });
              }
            });
          }));
    // TODO: implement initState
    super.initState();
  }


  DateTime selectedDate =DateTime.now();
  List<String> months =[
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
  Future<void> _selectSelectDate(BuildContext context) async
  {
    final DateTime? picked =await showDatePicker(context: context
    , initialDate: selectedDate,
     firstDate: DateTime(2020,12), 
     lastDate: DateTime(2100,01));
     if(picked != null && picked != selectedDate)
     {
      setState(() {
        selectedDate = picked;
      });
     }

  } @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: prime,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (() { Navigator.push(context,
              MaterialPageRoute(builder: (context) => admin_home())); }) ),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: form_key,
          child: ListView(padding: EdgeInsets.all(12.0), children: [
            Center(
                child: Text(
                  "Add  Expanse Transaction!!",
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: prime,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.attach_money,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextFormField(
                      controller: moneyEditController,
                      decoration:
                      InputDecoration(hintText: "0.0", border: InputBorder.none),
                      style: TextStyle(fontSize: 24.0),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Amount cannot be empty";
                        }
                      }
                  ),

                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(

                  decoration: BoxDecoration(
                    color: prime,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.description,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextFormField(
                      controller: discriptionEditController,
                      decoration: InputDecoration(
                          hintText: "Note on Transaction", border: InputBorder.none),
                      style: TextStyle(fontSize: 24.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Amount cannot be empty";
                        }
                      }
                  ),

                ),
              ],
            ),
            SizedBox(height: 20.0),
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
                    Text("${selectedDate.day} ${months[selectedDate.month - 1]} , ${selectedDate.year}",style: TextStyle(fontSize: 20.0),),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => expance_admin()));
                  }, child: Text('Show Expance Transaction!!')),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  int now = int.parse(moneyEditController.text);
                  num total = now+previous_expence;
                  if(form_key.currentState!.validate())
                  {
                    CollectionExpense.doc().set(
                        {
                          'expense':moneyEditController.text,
                          'description':discriptionEditController.text,
                          'date':selectedDate,
                          'userUid':FirebaseAuth.instance.currentUser!.uid
                        }
                    ) .then((value) {
                      CollectionTotal.get().then((value) =>
                          value.docs.forEach((snapshot)
                          {
                            CollectionTotal.doc(snapshot.id).get().then((value) {

                              if(userid == FirebaseAuth.instance.currentUser!.uid)
                              {
                                CollectionTotal.doc(snapshot.id).update({
                                  "total_expense": total
                                });
                              }
                            });
                          }));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => admin_maint()));
                      Fluttertoast.showToast(msg: "Details added Successfully");

                    }).catchError((e)
                    {
                      Fluttertoast.showToast(msg: "Failed to add details");
                    }
                    );

                  }

                      },
                child: const Text(
                  "Add Expanse",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 241, 175, 68),
                ),
              ),
            ),
            SizedBox(height: 20.0),

          ]),
        )

    );
  }
}