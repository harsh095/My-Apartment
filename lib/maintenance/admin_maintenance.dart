import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/maintenance/add_trans_income.dart';
import 'package:my_apart/maintenance/select_maint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../admin_home.dart';
import '../constants/colors.dart';
import 'ad_income_show.dart';
import 'ex_admin_show.dart';

class admin_maint extends StatefulWidget
{
  const admin_maint({Key ? key}) :super(key: key);
  @override

  _admin_maintState createState() => _admin_maintState();

}

class _admin_maintState extends State<admin_maint> with TickerProviderStateMixin
{

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference CollectionTotal = FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).collection("Total");
  String income = "";
  String expanse = "";
  String userid ="";
  var tot;
  @override
  void initState() {
    CollectionTotal.get().then((value) =>
        value.docs.forEach((snapshot)
        {
          CollectionTotal.doc(snapshot.id).get().then((value) {
            userid = value.get("userUid");
            if(userid == FirebaseAuth.instance.currentUser!.uid)
            {
              setState(() {
                income = value.get("total_income").toString();
                expanse = value.get("total_expense").toString();
                tot=int.parse(income)-int.parse(expanse);
              });
            }
          });
        }));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TabController tabController=TabController(length: 2, vsync: this);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffF9A826),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (() { Navigator.push(context,
            MaterialPageRoute(builder: (context) => admin_home())); }) ),
        title: Text('Asset Management',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => select_maint()));
      },
        child: Icon(Icons.add,size: 32.0,),
        backgroundColor: Color(0xffF9A826),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.8),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    24.0,
                  ),
                ),
                // color: Static.PrimaryColor,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 18.0,
                horizontal: 8.0,
              ),
              child: Column(
                children: [
                  Text(
                    'Total Balance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      // fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '$tot\$' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        cardIncome(income.toString()),

                        cardExpense(expanse.toString()),

                      ],
                    ),
                  ),



                ],

              ),

            ),
            SizedBox(height: 40,),




          ],

        ),

      ),


    );


  }


}
Widget cardIncome(String value) {

  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_downward,
          size: 28.0,
          color: Colors.lightGreenAccent,
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Income",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Text(
            '$value\$',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget cardExpense(String value) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        padding: EdgeInsets.all(
          6.0,
        ),
        child: Icon(
          Icons.arrow_upward,
          size: 28.0,
          color: Colors.redAccent,
        ),
        margin: EdgeInsets.only(
          right: 8.0,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expense",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Text(
            '$value\$',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    ],
  );
}