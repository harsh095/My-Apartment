import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_apart/chat/Member/pages/group_info_user.dart';
import 'package:my_apart/chat/Member/service/database_service_user.dart';
import 'package:my_apart/chat/Member/widgets/message_tile_user.dart';
import 'package:my_apart/chat/Member/widgets/widgets_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPageUser extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPageUser(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatPageUser> createState() => _ChatPageUserState();
}

class _ChatPageUserState extends State<ChatPageUser> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  String userid = "";
  String id = "";

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
          userid = value.get("userUid");
          if(userid == FirebaseAuth.instance.currentUser!.uid)
          {
            id = snapshot.id;
            getChatand();
          }
        });
      }
    }
    ));

    super.initState();
  }

  getChatand() {
    DatabaseServiceUser(auid: id).getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseServiceUser(auid: id).getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor:Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    GroupInfoUser(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.blueGrey,
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: messageController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTileUser(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseServiceUser(auid: id).sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
