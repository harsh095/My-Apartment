import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_apart/Auth/otp_Auth_Sec.dart';


class email_a extends StatefulWidget {
  const email_a({super.key});

  @override
  State<email_a> createState() => _email_aState();
}

class _email_aState extends State<email_a> {
   

 
  final TextEditingController _emailcontroller = TextEditingController();
 
  
    


   
  Future<void> sendOtp() async {
   //print(_emailcontroller.text);
    EmailAuth emailAuth =  EmailAuth(sessionName: "My Apart");
  bool result = await emailAuth.sendOtp(
      recipientMail: _emailcontroller.value.text, otpLength: 6
      );

      if(result)
        {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => OTP_SEC(email: _emailcontroller.text) )));
        }
        else
        {
           Fluttertoast.showToast(msg: "Plese Resend OTP",);
        } 

  
  }


      @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
   
        child: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(tDefualtSize),

            child: Column(
              children: [
                Image.asset("assets/images/Email1.png", fit: BoxFit.cover),
                SizedBox(height: 30,),
                Text(
                  "Good to see you agian!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                /*   Text(
                "Secertory Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffF9A826),
                ),
              ), */Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          TextFormField(
                              controller: _emailcontroller,
                              decoration: const InputDecoration(
                                  label: Text("Enter Email"),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Color(0xffF9A826),
                                  ),
                                  
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
                        //  SizedBox(height: 10.0, width: 10.0),
                       
                        /*  TextFormField(
                              controller: _otpcontroller,
                             // obscureText: true,
                              decoration: const InputDecoration(
                                  label: Text("Enter OTP"),
                                  prefixIcon: Icon(
                                    Icons.fingerprint_outlined,
                                    color: Color(0xffF9A826),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(color: Colors.blueGrey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3.0, color: Colors.blueGrey))),
                            
                          ),
                          */
                          SizedBox(
                            height: 30.0,
                          ),
                      
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: Text(
                                    'Send OTP',
                                    style: TextStyle(color: Colors.blueGrey,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 241, 175, 68),
                                  ),
                                  onPressed: () => sendOtp()
                              )),
                          SizedBox(
                            height: 30.0,
                          ),
                          //TextButton(onPressed: (){}, child: Text('Forget Password')),
                      
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      )
    );
  }
}
