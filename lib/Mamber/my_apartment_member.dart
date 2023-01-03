import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_apart/Mamber/user_home.dart';

class my_apartment_member extends StatefulWidget {
  const my_apartment_member({Key? key}) : super(key: key);

  @override
  State<my_apartment_member> createState() => _my_apartment_memberState();
}

class _my_apartment_memberState extends State<my_apartment_member> {


  String nameApartment = "";
  String nameSecretary = "";
  String address = "";
  String aid ="";
  String sid = "";
  String imageUrl = "";

  Future get() async
  {
    FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
        value.docs.forEach((snapshot)
        {
          FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("Members").doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            setState(() {
              aid = value.get("AdminUid");
            });
          });

        }
        )).whenComplete(() {
      FirebaseFirestore.instance.collection("Secretary").get().then((value) =>
          value.docs.forEach((snapshot)
          {
            FirebaseFirestore.instance.collection("Secretary").doc(snapshot.id).collection("My Apartment").doc(snapshot.id)
                .get()
                .then((value) {
              setState(() {
                sid = value.get("s_id");
                if(aid == sid)
                {
                  setState(() {
                    nameSecretary = value.get("Name of Secretary");
                    nameApartment = value.get("Name of Apartment");
                    address = value.get("Address of Apartment");
                    imageUrl = value.get("Image_Apartment");
                  });
                }
              });
            });

          }
          ));
    });


  }
  void initState()
  {
    get();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(elevation: 0,title: Text("My Apartment",style: TextStyle(color: Colors.white),),
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,)
          ,onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => user_home()));},),
      ),
      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),

            Container(
              margin: EdgeInsets.only(top: 80),
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).primaryColor
              ),
              child: imageUrl == "" ? Icon(
                Icons.person,size: 80,color: Colors.white,
              ) : Image.network(imageUrl),
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('Name of Apartment : '+ nameApartment,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name of Secretary : '+ nameSecretary,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Address of Apartment : '+ address ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}