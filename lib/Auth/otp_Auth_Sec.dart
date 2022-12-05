import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OTP_SEC extends StatelessWidget {
 

  String email;

  OTP_SEC({ required this.email});

   EmailAuth emailAuth =  EmailAuth(sessionName: "My Apart");
  final OtpFieldController  _otpcontroller = OtpFieldController();
 void verifyOTP()async
{
 var res= emailAuth.validateOtp(
        recipientMail: email,
        userOtp: _otpcontroller.toString());
        if(res)
        {
            print("OTP verified");
        }
        else
        {
          print("Invalid OTP");
        }
}

  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
       padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("CO",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 80.0,color: Color(0xffF9A826))),
            Text("DE",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 80.0,color: Color(0xffF9A826))),
            Text("VERIFICATION",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,color: Colors.blueGrey,fontSize: 16.0),),
            const SizedBox(height: 40.0,),
            const Text("Enter the verification code sent at" 
            +"harshbaldha@gmail.com",textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,color: Colors.grey),),
            //const Text("",textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,color: Colors.grey)),
           const SizedBox(height: 20.0,),
           SizedBox(height: 100,width: 250,
           child: OTPTextField(
            controller: _otpcontroller,
            length: 6,
            otpFieldStyle: OtpFieldStyle(backgroundColor: Colors.grey),
            
           ),
          
           ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {} ,child :const Text("Next",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0)),
              style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 241, 175, 68),
                                  ),
            
            ),
            
          ),
          SizedBox(height: 160.0,)
          

              ],
        ),
      ),
    );
  }
}