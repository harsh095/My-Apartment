import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Sacretary/admin_home.dart';
import '../constants/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  TextEditingController moneyEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0,
            title: Text("Payment", style: TextStyle(color: Colors.white),),
            backgroundColor: prime,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => admin_home()));
              },
            )),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 300,
              ),

              TextFormField(
                controller: moneyEditController,
                decoration:
                InputDecoration(hintText: "0.0 \$", border: InputBorder.none),
                style: TextStyle(fontSize: 24.0),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,

              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Pay",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 241, 175, 68),
                  ),
                ),
              ),
            ],
          ),

        )

    );
  }
}

