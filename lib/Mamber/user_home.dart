import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/Mamber/request_member.dart';
import 'package:my_apart/Mamber/user_profile.dart';

import 'package:my_apart/f_login.dart';
import 'package:my_apart/chat/Member/pages/group_page_user.dart';
import 'package:my_apart/maintenance/maintenance_member.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../constants/colors.dart';
import 'compain_member.dart';
import 'my_apartment_member.dart';


class user_home extends StatefulWidget
{
  @override
  State<user_home> createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: h1(),
      
    );
  }
}
    class h1 extends StatefulWidget {
  @override
  _h1State createState() => _h1State();
  
}
class _h1State extends State<h1> {
  final _advancedDrawerController = AdvancedDrawerController();
  final user = FirebaseAuth.instance.currentUser;
  var name="",email="",imageUrl="";
  //final CollectionReference user = FirebaseFirestore.instance.collection("Users");
  fetch() async
  {
    FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
        value.docs.forEach((snapshot)
        {
          FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            setState(() {
              name = value.get("Name");
              email = value.get("Email");
              imageUrl = value.get("Profile_Image");
            });

          });
        }
        ));

    /*FirebaseFirestore.instance.collection("Secretary").doc().collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value){
      name = value.get("Name");
      email = value.get("Email");
    });*/
  }
  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(

        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(

        appBar: AppBar(
            backgroundColor: Colors.orangeAccent,
            title: Center(child: const Text('My Apartment',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),

            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {Navigator.push(
                        context, MaterialPageRoute(builder: (context) => GroupPageUser()));},
                    child: Icon(
                      Icons.message,
                      size: 26.0,
                    ),
                  )
              ),]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Transform.rotate(
                    origin: Offset(30, -60),
                    angle: 2.4,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 75,
                        top: 40,
                      ),
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          colors: [Color(0xffF9A826), Colors.blueGrey],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Glassify Transaction',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Glassify this transaction into a \n pticular catigory ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 167,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueGrey.shade400.withOpacity(0.3),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Image.asset(
                                            'assets/images/img_9.png',
                                            width: 120,
                                            height: 120,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Profile',
                                            style: TextStyle(color: Color(0xFF47B4FF), fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap:(){Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => user_profile()));},
                                  ),

                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    child: Container(
                                      height: 167,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueGrey.shade400.withOpacity(0.3),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Image.asset(
                                            'assets/images/abc.png',
                                            width: 120,
                                            height: 120,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Event Requst',
                                            style: TextStyle(color: Colors.lightGreenAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap:() {Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => request()));},
                                  ),

                                ],
                              ),


                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 177,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueGrey.shade400.withOpacity(0.3),
                                      ),
                                      child: Column(
                                        children: [

                                          Image.asset(
                                            'assets/images/img_15.png',
                                            width: 150,
                                            height: 150,
                                          ),

                                          Text(
                                            'Asset ',
                                            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap:() {},
                                  ),

                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    child: Container(
                                      height: 177,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueGrey.shade400.withOpacity(0.3),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Image.asset(
                                            'assets/images/img_16.png',
                                            width: 100,
                                            height: 100,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            'Setting',
                                            style: TextStyle(color: Colors.yellowAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),

                                      onTap:() {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Complain_member()));},
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, //                   <--- border color
                        width: 2.0,
                      ),

                    image:  DecorationImage(
                      fit: BoxFit.cover,

                      image:NetworkImage(imageUrl),

                    ),
                  ),

                
                  
                ),
                                ListTile(
                  onTap: ()  {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_home()));},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_profile()));},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => maintenance_member()));},
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text('Pay Maintanance'),
                ),
                ListTile(
                  onTap: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => request()));},
                  leading: Icon(Icons.event),
                  title: Text('Request for Event'),
                ),
               
                
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),

                ListTile(
                  onTap: () {FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => my_apartment_member()));
                  });
                  },
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text('About us'),
                ),
                ListTile(
                  onTap: () {FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => f_login()));
                  });
                    },
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    
    _advancedDrawerController.showDrawer();
  }
}