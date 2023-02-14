import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:my_apart/f_login.dart';
import 'package:my_apart/Sacretary/request_sec_fun.dart';
import 'package:my_apart/chat/Admin/pages/group_page_admin.dart';
import 'package:my_apart/assets/admin_maintenance.dart';
import 'package:my_apart/assets/ex_admin_show.dart';
import 'package:my_apart/Sacretary/member_list.dart';
import 'package:my_apart/Sacretary/admin_profile.dart';
import '../constants/colors.dart';
import '../assets/ad_income_show.dart';
import '../assets/select_maint.dart';
import '../maintenance/maintenance_admin.dart';
import '../maintenance/maintenance_paid_list.dart';
import 'complain_sec.dart';
import 'forget_password_admin.dart';
import 'my_apartment_admin.dart';

class admin_home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
     // body:


      
    );
    
    }

  }
  class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name ="",email="",imageUrl="";

  late TextEditingController t1;
  fetch() async
  {
    FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value){
      setState(() {
        name = value.get("Name");
        email = value.get("Email");
        imageUrl = value.get("Profile_Image");
      });
    });
  }
  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }
  final _advancedDrawerController = AdvancedDrawerController();

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
          elevation: 0,
          backgroundColor: Colors.orangeAccent.withOpacity(0.9),
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
         
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                height: 150,

                child: Stack(
                  children: [

                    Container(
                      padding: EdgeInsets.only(left: 20,),
                      height: 127,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.9),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36)
                        )
                      ),
                      child: Row(
                        children: [

                          Text('Welcome '+name+'!',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic) ,),
                          Spacer(),
                          IconButton(
                            icon: Image.asset('assets/images/chat.png'),
                            iconSize: 120,
                            onPressed: () {Navigator.push(
                                context, MaterialPageRoute(builder: (context) => GroupPageAdmin()));},
                          )
                        ],
                      ),
                    ),


                  ],
                ),
              ),
              Column(
                children: [

                  Stack(
                    children: [

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

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
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:(){Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => profile_admin()));},
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
                                                'pending  Events',
                                                style: TextStyle(color:blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => request_admin()));},
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                                'assets/images/main.png',
                                                width: 120,
                                                height: 120,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Pay Maintenance',
                                                style: TextStyle(color: blg, fontSize: 15,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:(){Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => maintenance_admin()));},
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
                                                'assets/images/img_17.png',
                                                width: 120,
                                                height: 120,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Paid Maint List',
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => maintenance_paid_list()));},
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                                'assets/images/img_11.png',
                                                width: 120,
                                                height: 120,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Member List',
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => member_list()));} ,
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
                                              SizedBox(height: 5,),
                                              Image.asset(
                                                'assets/images/img_12.png',
                                                width: 120,
                                                height: 120,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  'Add Transection',
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => select_maint()));},
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 20),
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
                                              SizedBox(height: 13,),
                                              Image.asset(
                                                'assets/images/img_13.png',
                                                width: 100,
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Income List',
                                                style: TextStyle(color:blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => income_admin()));},
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
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/images/img_14.png',
                                                width: 100,
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Expance List',
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => expance_admin()));},
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
                                                'Asset Manage',
                                                style: TextStyle(color: blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap:() {Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => admin_maint()));},
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
                                                style: TextStyle(color:blg, fontSize: 18,fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),


                                          onTap:() {Navigator.push(context,
      MaterialPageRoute(builder: (context) => Complain_Admin()));},
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
                      MaterialPageRoute(builder: (context) => admin_home()));},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => profile_admin()));},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),

                  ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => member_list()));
                  },
                  leading: Icon(Icons.list_outlined),
                  title: Text('Members List'),
                ),

                 ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => admin_maint()));},
                  leading: Icon(Icons.assessment_outlined),
                  title: Text('Assets'),
                ),
                ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => maintenance_admin()));},
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text(' Pay Maintenance '),
                ),
                ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => forgot_password_admin()));},
                  leading: Icon(Icons.checklist_rounded),
                  title: Text('Forget Password '),
                ),
                ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => my_apartment_admin()));},
                  leading: Icon(Icons.account_balance_outlined),
                  title: Text('About Us'),
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

