import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/maintenance/ad_income_show.dart';

import '../admin_home.dart';
import '../constants/colors.dart';
import '../maintenance/select_maint.dart';
import 'admin_maintenance.dart';


class add_trans_in extends StatefulWidget {
  const add_trans_in({Key? key}) : super(key: key);
  @override
  _add_trans_inState createState() => _add_trans_inState();
}

class _add_trans_inState extends State<add_trans_in> {

  final form_key = GlobalKey<FormState>();

  TextEditingController moneyEditController = TextEditingController();
  TextEditingController discriptionEditController = TextEditingController();

  final CollectionReference CollectionIncome = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Income");
  final CollectionReference CollectionTotal = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Total");

  var previous_income;
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
              });
            }
          });
        }));
    // TODO: implement initState
    super.initState();
  }



  DateTime selectedDate =DateTime.now();
  var now;
  var total;

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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: prime,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (() { Navigator.push(context,
              MaterialPageRoute(builder: (context) => select_maint())); }) ),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: form_key,
          child: ListView(padding: EdgeInsets.all(12.0), children: [
            Center(
                child: Text(
                  "Add  Income Transaction!!",
                  style: TextStyle(
                      fontSize: 28.0,
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
                    color:  prime,
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
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => income_admin()));
                }, child: Text('Show Income Transaction')),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   now = int.parse(moneyEditController.text);
                   total = now+previous_income;
                  if(form_key.currentState!.validate())
                  {
                    CollectionIncome.doc().set(
                        {
                          'income':moneyEditController.text,
                          'description':discriptionEditController.text,
                          'date':selectedDate,
                          'userUid':FirebaseAuth.instance.currentUser!.uid
                        }
                    ) .then((value) {
                      // ignore: unrelated_type_equality_checks
                      CollectionTotal.get().then((value) =>
                          value.docs.forEach((snapshot)
                          {
                            CollectionTotal.doc(snapshot.id).get().then((value) {

                              if(userid == FirebaseAuth.instance.currentUser!.uid)
                              {
                                CollectionTotal.doc(snapshot.id).update({
                                  "total_income": total
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
                  "Add Income",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 241, 175, 68),
                ),
              ),
            ),

          ]
          ),
        )

    );
  }
}
