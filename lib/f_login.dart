import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/Sacretary/admin_login.dart';
import 'package:my_apart/Mamber/user_login.dart';

class f_login extends StatelessWidget {
  get container => null;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Center(
      child: Scaffold(
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
                Text(
                  "A New Perspective of Care!",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
               
                SizedBox(
                  height: 120,
                ),
                Text(
                  "As Login Per!!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.amber,
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
                                builder: (context) => admin_login()));
                      },
                      child: Text('Secertory'.toUpperCase(),
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
                                      builder: (context) => user_login()));
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
                              'Mamber'.toUpperCase(),
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
