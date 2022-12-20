import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_apart/add_members.dart';
import 'package:my_apart/admin_login.dart';
import 'package:my_apart/chat/Admin/pages/group_page_admin.dart';
import 'package:my_apart/maintenance/admin_maintenance.dart';
import 'package:my_apart/maintenance/ex_admin_show.dart';

import 'package:my_apart/member_list.dart';
import 'package:my_apart/admin_profile.dart';

import 'package:sidebarx/sidebarx.dart';

import 'constants/colors.dart';
import 'maintenance/ad_income_show.dart';
import 'maintenance/select_maint.dart';



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
                                    context, MaterialPageRoute(builder: (context) => GroupPageAdmin()));},
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
                                            'assets/images/img_10.png',
                                            width: 120,
                                            height: 120,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Add Member',
                                            style: TextStyle(color: Colors.lightGreenAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap:(){Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => SignUpScreen()));},
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
                                            style: TextStyle(color: prime, fontSize: 18,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color: Colors.green, fontSize: 18,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color: Colors.redAccent, fontSize: 18,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18,fontWeight: FontWeight.bold),
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
                                            style: TextStyle(color: Colors.yellowAccent, fontSize: 18,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap:() {},
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
                  ),
                  child: Image.asset(
                    'assets/images/profile.png',
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
                  onTap: () { {Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));}},
                  leading: Icon(Icons.add_circle_outline_outlined),
                  title: Text('Add Member'),
                ),
                  ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => member_list()));
                  },
                  leading: Icon(Icons.list_outlined),
                  title: Text('Members List'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                 ListTile(
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => admin_maint()));},
                  leading: Icon(Icons.attach_money_outlined),
                  title: Text('Money'),
                ),

                ListTile(
                  onTap: () {FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => admin_login()));
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

