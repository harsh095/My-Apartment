import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/Mamber/user_home.dart';

import '../constants/colors.dart';

class request extends StatefulWidget {
  const request({Key? key}) : super(key: key);

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  final form_key = GlobalKey<FormState>();


  TextEditingController discriptionEditController = TextEditingController();
  TextEditingController timeEditController = TextEditingController();
  TextEditingController dateEditController = TextEditingController();

  final CollectionReference CollectionIncome =
  FirebaseFirestore.instance.collection("Secretary");

  String userid = "";
  String id = "";
  String name = "";
  String? value;
  String flat = "";
  final Items = ["Birthday Party","Marriage","funeral","festivals"];

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
          backgroundColor: Colors.white,elevation: 0,
          title: Text(
            'Request for Use',
            style: TextStyle(
                color: prime, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: prime,
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
              'Select Date for Your Function!!',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),

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

            SizedBox(
              height: 20,
            ),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                          hint: Text(Items[0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.blueGrey),),
                          isExpanded: true,
                          value: value,
                          items: Items.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() => this.value = value,)
                      ),
                    )

                  /*TextFormField(
                      controller: discriptionEditController,
                      decoration: InputDecoration(
                          hintText: "Description About Function!",
                          border: InputBorder.none),
                      style: TextStyle(fontSize: 20.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Amount cannot be empty";
                        }
                      }),*/
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:  prime,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.timelapse,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextFormField(
                      controller: timeEditController,
                      decoration: InputDecoration(
                          hintText: " Add Time Duration ",
                          border: InputBorder.none),
                      style: TextStyle(fontSize: 20.0),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Time  cannot be empty";
                        }
                      }),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                child: const Text(
                  "Send Request",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 241, 175, 68),
                ),
                onPressed: ()   {
                  List s1 = selectedDate.toString().split(" ");

                  if(form_key.currentState!.validate())
                  {
                    if(value == null)
                    {
                      value = Items[0];
                    }

                    FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Event_Request").get().then((value) =>
                    // ignore: avoid_function_literals_in_foreach_calls
                    value.docs.forEach((snapshot)
                    {
                      // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
                      FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Event_Request").doc(snapshot.id)
                          .get()
                          .then((value)
                      {
                        setState(() {
                          date = value.get("date").toString();
                          if(date == s1[0])
                          {
                            setState(() {
                              flag++;
                            });
                          }
                        });
                      });
                    }
                    )).whenComplete(() {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(title:  Text("Send Request"),
                          actions: [
                            Flat3dButton(onPressed:(){
                              Navigator.pop(context);
                            } ,child: Text("Cancel"),
                              color: Colors.blueGrey,
                            ),
                            Flat3dButton(onPressed:() async {
                              if(flag>0)
                              {
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(title: Text("Error"),
                                    content: Text("Your request cant send because for this date another request already been sent by another member "
                                        "You can send when that request will reject"),
                                    actions: [
                                      Flat3dButton(onPressed:(){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => request()));
                                      } ,child: Text("OK"),
                                        color: Colors.blueGrey,
                                      ),

                                    ],
                                  );
                                });

                                //Fluttertoast.showToast(msg: "Event already booked = "+flag.toString());
                              }
                              else if(flag==0)
                              {
                                CollectionIncome.doc(id).collection("Event_Request").doc(FirebaseAuth.instance.currentUser!.uid).set(
                                    {
                                      'member name':name,
                                      'date':s1[0],
                                      'description':value,
                                      'time':timeEditController.text,
                                      'Answer':"",
                                      'userUid':FirebaseAuth.instance.currentUser!.uid,
                                      "Flat_No": flat
                                    }
                                ).then((value) {
                                  String request = discriptionEditController.text;
                                  // ignore: unrelated_type_equality_checks
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   user_home()));
                                  Fluttertoast.showToast(msg: "Request Send Successfully");

                                  FirebaseFirestore.instance.collection("Secretary").doc(id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
                                      .update({
                                    'Event_request_answer':"Your Request for $request is Sent to Secretary"
                                  });

                                  //flag = 0;
                                }).catchError((e)
                                {
                                  Fluttertoast.showToast(msg: "Failed to send request");
                                }
                                );
                              }
                            } ,child: Text("Send"),
                              color: Colors.blueGrey,
                            )
                          ],
                        );
                      });
                      /**/
                    });
                  }

                },
              ),
            ),
            Container(child: Center(child: Text(res)),),

          ]),
        ));
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(item,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue),
    ),
  );
}