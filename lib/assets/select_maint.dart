import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:my_apart/Sacretary/admin_home.dart';
import 'package:my_apart/Sacretary/admin_login.dart';
import 'package:my_apart/constants/colors.dart';
import 'package:my_apart/assets/add_trans_ex.dart';
import 'package:my_apart/assets/add_trans_income.dart';
import 'package:my_apart/assets/admin_maintenance.dart';
import 'package:my_apart/Mamber/user_login.dart';

class select_maint extends StatelessWidget {
  get container => null;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(

          appBar: AppBar(
            backgroundColor: Color(0xffF9A826),
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (() { Navigator.push(context,
                MaterialPageRoute(builder: (context) => admin_home())); }) ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 450,
                  child:
                      Image.asset("assets/images/flog.png", fit: BoxFit.fill),
                ),
                //SizedBox(height: 00),
               
               
                SizedBox(
                  height: 40,
                ),
                Text(
                  "What would you add!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber,
                    fontStyle: FontStyle.italic
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: Colors.black87,
                        // side: BorderSide(color: Colors.black),
                        backgroundColor: Color.fromARGB(255, 247, 180, 73).withOpacity(0.9),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_trans_in()));
                      },
                      child: Text('Income'.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_trans_ex()));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              // side: BorderSide(color: tSecoundaryColor),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              'Expanse'.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
