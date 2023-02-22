import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/Mamber/user_home.dart';

import '../constants/colors.dart';


class forgot_password_member extends StatefulWidget {
  const forgot_password_member({Key? key}) : super(key: key);

  @override
  State<forgot_password_member> createState() => _forgot_password_memberState();
}

class _forgot_password_memberState extends State<forgot_password_member> {
  final emailController = TextEditingController();
  final form_key = GlobalKey<FormState>();

  Future passwordReset() async
  {

      
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim()).then((value) {
        showDialog(context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text("Password reset link sent to your email, check")
              );
            }
        );
      }).catchError((e) {
        print(e);
        showDialog(context: context,
            builder: (context) {
              return AlertDialog(
                  content: Text(e.message.toString())
              );
            }
        );
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0,title: Text("Reset Password",style: TextStyle(color: prime),
        ),
          leading: IconButton(icon: Icon(Icons.arrow_back,color:prime,),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => user_home()));},),
          backgroundColor: Colors.white,),

        body: Form
          (
            key: form_key,
            child:Column(
              children: [
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Enter your email and after you will ger password reset link!",style: TextStyle(color: Colors.blueGrey,
                      fontWeight:FontWeight.bold ,fontSize: 20),),
                ),

                SizedBox(height: 30,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                  child:TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          label: Text("Enter Email"),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xffF9A826),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3.0, color: Colors.blueGrey))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                      }

                  ),
                ), SizedBox(height: 20,),
                MaterialButton(onPressed: (){
                  if(form_key.currentState!.validate())
                  {
                    passwordReset();
                  }
                },

                  child: Text("Reset Password"),
                  color:prime,
                ),

              ],

            )
        )

    );
  }
}