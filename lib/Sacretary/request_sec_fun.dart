import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/constants/colors.dart';

import 'admin_home.dart';

class request_admin extends StatefulWidget {
  const request_admin({Key? key}) : super(key: key);

  @override
  State<request_admin> createState() => _request_adminState();
}

String t1 = "";
String t2 = "";


final form_key = GlobalKey<FormState>();

TextEditingController textEditController = TextEditingController();

class _request_adminState extends State<request_admin> {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference Collection = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Event_Request");
  final CollectionReference memberCollection = FirebaseFirestore.instance.collection("Secretary");
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
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title: Text("Members",style: TextStyle(color: prime),),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: prime,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));
          },
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Secretary").doc(user!.uid).collection("Event_Request").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              var date=document['date'];

              return Card(
                shape: StadiumBorder(),
                child: ListTile(
                    trailing: Text("Name  : "+document['member name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                   title: Text("Date : "+date.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey)),
                    subtitle: Text("Discription : "+document['description'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 10),textScaleFactor: 1.5,
                    ),
                    onTap: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(title:  Text("What would you like to do?",style: TextStyle(color: Colors.blueGrey),),

                          actions: [
                            Flat3dButton(onPressed:(){
                              memberCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection("Members").doc(document['userUid'])
                                  .update({
                                'Event_request_answer':"Your last request for"+document['description']+" is accepted",
                              }).then((value) {
                                Collection.doc(document['userUid']).delete().whenComplete(
                                        () => Navigator.pop(context)
                                );
                                Fluttertoast.showToast(msg: "Request Accepted",);
                              });

                            } ,child: Text("Accept"),
                              color: Colors.orange,
                            ),
                            Flat3dButton(onPressed:() {
                              memberCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection("Members").doc(document['userUid'])
                                  .update({
                                'Event_request_answer':"Your last request for"+document['description']+" is rejected",
                              }).then((value) {
                                Collection.doc(document['userUid']).delete().whenComplete(
                                        () => Navigator.pop(context)
                                );
                                Fluttertoast.showToast(msg: "Request rejected",);
                              });
                            } ,child: Text("Reject"),
                              color: Colors.orange,
                            ),
                            Flat3dButton(onPressed:(){
                              Navigator.pop(context);
                            } ,child: Text("Cancel"),
                              color: Colors.orange,
                            ),
                          ],
                        );
                      });
                    }
                ),
              );
            }).toList(),

          );
        },

      ),
    );
  }

}