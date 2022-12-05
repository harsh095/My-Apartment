import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/admin_home.dart';

class member_list extends StatefulWidget {
  const member_list({Key? key}) : super(key: key);

  @override
  State<member_list> createState() => _member_listState();
}

class _member_listState extends State<member_list> {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference Collection = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Members");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 247, 174, 57),title: Text("Members  List",style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold),),
    leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));
        },
    )),
    body: StreamBuilder(
      
      stream: FirebaseFirestore.instance.collection("Secretary").doc(user!.uid).collection("Members").snapshots(),
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
            return Card(
              shape: StadiumBorder(),
              child: ListTile(
                title: Text("Name : "+document['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey),),
                subtitle: Text("Vehicles : "+document['Number of vehicles'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blueGrey)),
                trailing: Text("Flat No : "+document['Flat Number'], style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,),textScaleFactor: 1.5,
                ),
                onTap: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(title:  Text("Remove Member",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffF9A826),),),
                          content: Text("Are you sure you want to remove member !? "),
                          actions: [
                            Flat3dButton(onPressed:(){
                            Navigator.pop(context);
                          } ,child: Text("Cancel",style: TextStyle(color: Colors.white), ),
                          color: Colors.blueGrey,
                            ),
                            Flat3dButton(onPressed:() async {
                              Collection.doc(document['userUid']).delete().whenComplete(
                                      () => Navigator.pop(context)
                              );
                            } ,child: Text("Remove",style: TextStyle(color: Colors.white),),
                            color: Colors.blueGrey,
                            )
                          ],
                        );
                      });
                },
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