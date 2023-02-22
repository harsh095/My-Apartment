import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_apart/chat/Member/pages/search_page_user.dart';
import 'package:my_apart/chat/Member/service/database_service_user.dart';
import 'package:my_apart/chat/Member/widgets/group_tile_user.dart';
import 'package:my_apart/chat/Member/widgets/widgets_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupPageUser extends StatefulWidget {
  const GroupPageUser({Key? key}) : super(key: key);

  @override
  State<GroupPageUser> createState() => _GroupPageUserState();
}

class _GroupPageUserState extends State<GroupPageUser> {
  final form_key = GlobalKey<FormState>();

  String userName = "";
  String adminId = "";
  String email = "";
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  String userid = "";
  String id = "";
  //String newId = DatabaseServiceUser().id;

  @override
  void initState() {
    super.initState();

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
          userid = value.get("userUid");
          if(userid == FirebaseAuth.instance.currentUser!.uid)
          {
            id = snapshot.id;
            gettingUserData();
          }
        });
      }
    }
    ));
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {

    FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
        value.docs.forEach((snapshot)
        {
          FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            setState(() {
              userName = value.get("Name");
             // adminId = value.get("AdminUid");

            });
          });
        }
        ));
   await DatabaseServiceUser(uid: FirebaseAuth.instance.currentUser!.uid,auid: id)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
    // getting the list of snapshots in our stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPageUser());
              },
              icon: const Icon(
                Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 241, 177, 73),
        title: const Text(
          "Groups",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27),
        ),
      ),

      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 241, 177, 73),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return Form(
              key:form_key,
              child: AlertDialog(
                title: const Text(
                  "Create a group",
                  textAlign: TextAlign.left,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isLoading == true
                        ? Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    )
                        : TextFormField(
                      onChanged: (val) {
                        setState(() {
                          groupName = val;
                        });
                      },
                    validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    },
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:  Color(0xffF9A826)),
                              borderRadius: BorderRadius.circular(20)))
                      ,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        primary:Color(0xffF9A826)),
                    child: const Text("CANCEL",style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
          if (form_key.currentState!.validate()) {
            if (groupName != "") {
              setState(() {
                _isLoading = true;
              });
              DatabaseServiceUser(
                  uid: FirebaseAuth.instance.currentUser!.uid, auid: id)
                  .createGroup(userName,
                  FirebaseAuth.instance.currentUser!.uid, groupName)
                  .whenComplete(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
              showSnackbar(
                  context, Colors.blueGrey, "Group created successfully.");
            }
          }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffF9A826)),
                    child: const Text("CREATE",style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: getId(snapshot.data['groups'][reverseIndex]),
                      groupName: getName(snapshot.data['groups'][reverseIndex]),
                      userName: snapshot.data['Name']);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        }
        else {
          return Center(
            child: CircularProgressIndicator(color: Color(0xffF9A826)),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
