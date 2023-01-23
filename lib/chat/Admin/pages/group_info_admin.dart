
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/chat/Admin/widgets/widgets_admin.dart';


import '../service/database_service_admin.dart';
import 'group_page_admin.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class GroupInfoAdmin extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfoAdmin(
      {Key? key,
      required this.adminName,
      required this.groupName,
      required this.groupId})
      : super(key: key);

  @override
  State<GroupInfoAdmin> createState() => _GroupInfoAdminState();
}
String s_name = "";
class _GroupInfoAdminState extends State<GroupInfoAdmin> {
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }



  getMembers() async {
    DatabaseServiceAdmin(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:Color(0xffF9A826),
        title: const Text("Group Info"),
        actions: [
          IconButton(
              onPressed: () {

                
                AwesomeDialog(
            context: context,
           // descTextStyle: c,
            animType: AnimType.scale,
            dialogType: DialogType.question,
            body: Center(child: Text(
                    'Are you sure you exit the group',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
          //  title: 'This is Ignored',
           // desc:   'This is also Ignored',
            btnCancelOnPress: () {  Navigator.pop(context);},
            btnOkOnPress: () {
              FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("groups")
                  .doc(widget.groupId).update({
                "members": FieldValue.arrayRemove(["${FirebaseAuth.instance.currentUser!.uid}_$s_name"])
              });
              DatabaseServiceAdmin(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .toggleGroupJoin(
                                      widget.groupId,
                                      getName(widget.adminName),
                                      widget.groupName)
                                  .whenComplete(() {
                                nextScreenReplace(context, const GroupPageAdmin());
                              });},
            )..show();
              },
              
              icon: const Icon(Icons.exit_to_app_outlined)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${widget.groupName}",
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Admin: ${getName(widget.adminName)}",style: TextStyle(fontWeight: FontWeight.w200))
                    ],
                  )
                ],
              ),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueGrey,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index]),style: TextStyle(fontWeight: FontWeight.bold),),
                      //subtitle: Text(getId(snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS"),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS"),
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      },
    );
  }
}
