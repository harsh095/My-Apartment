import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin_home.dart';
import '../constants/colors.dart';
import 'admin_maintenance.dart';


class expance_admin extends StatefulWidget {
  const expance_admin({Key? key}) : super(key: key);

  @override
  State<expance_admin> createState() => _expance_adminState();
}
final user = FirebaseAuth.instance.currentUser;


class _expance_adminState extends State<expance_admin> {
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(elevation: 0,title: Text("Expanses List",style: TextStyle(color: Colors.white), ),
          backgroundColor: prime,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));
          },
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Secretary").doc(user!.uid).collection("Expanse").snapshots(),
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
              var date=document['date'].toDate();
              return Card(
                shape: StadiumBorder(),
                child: ListTile(
                  title: Text("Date : "+"${date.day.toString()} ${months[date.month - 1]} , ${date.year.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  subtitle: Text("Description : "+document['description'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey)),
                  trailing: Text("Amount : "+document['expense'], style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),textScaleFactor: 1.5,
                  ),
                  /*onTap: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(title:  Text("Remove Member"),
                        content: Text("Are you sure you want to remove member "),
                        actions: [
                          Flat3dButton(onPressed:(){
                            Navigator.pop(context);
                          } ,child: Text("Cancel"),
                          ),
                          Flat3dButton(onPressed:() async {
                            Collection.doc(document['userUid']).delete().whenComplete(
                                    () => Navigator.pop(context)
                            );
                          } ,child: Text("Remove"),
                          )
                        ],
                      );
                    });
                  },*/
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}