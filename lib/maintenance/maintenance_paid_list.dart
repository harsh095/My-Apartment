import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../Sacretary/admin_home.dart';
import '../constants/colors.dart';
import 'date_vise_list.dart';


class maintenance_paid_list extends StatefulWidget {
  const maintenance_paid_list({Key? key}) : super(key: key);

  @override
  State<maintenance_paid_list> createState() => _maintenance_paid_listState();
}

class _maintenance_paid_listState extends State<maintenance_paid_list> {
  final form_key = GlobalKey<FormState>();

  final CollectionReference CollectionIncome = FirebaseFirestore.instance.collection("Secretary");

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


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Paid list',
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
              'Enter the date that you want list of paid maintenance by members',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                child: const Text(
                  "Search",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => date_vise_list(s2:s2)));
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
