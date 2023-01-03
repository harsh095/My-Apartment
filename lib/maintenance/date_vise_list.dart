import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'maintenance_admin.dart';
import 'maintenance_paid_list.dart';

class date_vise_list extends StatefulWidget {
  final String s2;
  const date_vise_list({Key? key, required this.s2}) : super(key: key);

  @override
  State<date_vise_list> createState() => _date_vise_listState();
}

String t1 = "";
String t2 = "";

class _date_vise_listState extends State<date_vise_list> {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference Collection = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Maintenance");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title: Text("Paid List of Maintenance",style: TextStyle(color:prime),),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: prime,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => maintenance_paid_list()));
          },
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Secretary").doc(user!.uid).collection("Maintenance").doc(widget.s2).collection(widget.s2).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError)
          {
            return Center(
              child: Text("No data found"),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                shape: StadiumBorder(),
                child: ListTile(
                  title: Text("Name : "+document['Name']+"\nFLat No :"+document["Flat_No"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                  subtitle: Text("Date : "+document['Date'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey)),
                  trailing: Text("Amount : "+document['Paid_Amount'], style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),textScaleFactor: 1.5,

                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
/*Future deleteUser(String email, String password) async {
    try {
      FirebaseUser user = await _auth.currentUser as FirebaseUser;
      AuthCredential credentials = EmailAuthProvider.credential(email: email, password: password);
      //print(user);
     // Auth result = (await user) as Auth;
      Auth result = await user.reauthenticateWithCredential(credentials) as Auth;
      await result.user?.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/
}