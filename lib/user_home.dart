import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/admin_home.dart';
import 'package:my_apart/chat/Member/pages/group_page_user.dart';
import 'package:my_apart/page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:my_apart/user_login.dart';
import 'package:my_apart/user_profile.dart';

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
          backgroundColor: Color(0xffF9A826),
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
        body: Container(),
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
                      MaterialPageRoute(builder: (context) => user_profile()));},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
               
                
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  onTap: () {FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => user_login()));
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