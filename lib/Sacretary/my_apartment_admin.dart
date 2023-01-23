import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'admin_home.dart';

class my_apartment_admin extends StatefulWidget {
  const my_apartment_admin({Key? key}) : super(key: key);

  @override
  State<my_apartment_admin> createState() => _my_apartment_adminState();
}

class _my_apartment_adminState extends State<my_apartment_admin> {


  String nameApartment = "";
  String nameSecretary = "";
  String address = "";
  String id = FirebaseAuth.instance.currentUser!.uid;

  String update_nameApartment = "";
  String update_nameSecretary = "";
  String update_Address = "";
  String imageid = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = " ";

  void pickImage() async
  {
    final image  = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75
    );

    Reference ref = FirebaseStorage.instance.ref().child(imageid+nameSecretary);
    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
        FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("My Apartment")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'Image_Apartment':imageUrl
        });
      });

    });
  }

  Future get() async
  {
    FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(()
      {
        nameSecretary = value.get("Name");
      }
      );
    });
    FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Apartment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.get("s_id") == FirebaseAuth.instance.currentUser!.uid)
      {
        setState(()
        {
          nameApartment = snapshot.data()!["Name of Apartment"];
          //nameSecretary = snapshot.data()!["Name of Secretary"];
          address = snapshot.data()!["Address of Apartment"];
        }
        );
      }
    });

  }
  void initState()
  {
    get();
    setState(() {
      FirebaseFirestore.instance.collection("Secretary").doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("My Apartment")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        imageUrl = value.get("Image_Apartment");
      });
    });
    super.initState();
  }

  Future nameApartment_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Apartment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Name of Apartment':update_nameApartment,
    });

  }
  Future nameSecretary_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Apartment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Name of Secretary':update_nameSecretary,
    });
  }
  Future address_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("My Apartment")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Address of Apartment':update_Address,
    });
  }

  displayApartmentNameTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Name of Apartment'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_nameApartment = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Apartment Name"),
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('Cancle',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  nameApartment_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => my_apartment_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              )
            ],
          );
        }
    );
  }

  displayAddressTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Address of Apartment'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_Address = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Address of Apartment"),
            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text('Cancle',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  address_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => my_apartment_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red
                ),
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(elevation: 0,title: Text("My Apartment",style: TextStyle(color: Colors.white),),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,)
            ,onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => admin_home()));},),
        ),
        body:SingleChildScrollView(
          child: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    pickImage();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).primaryColor
                    ),
                    child: imageUrl == " " ? Icon(
                      Icons.person,size: 80,color: Colors.white,
                    ) : Image.network(imageUrl),
                  ),
                ),
                SizedBox(height: 20,),

                //SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Name of Apartment : '+ nameApartment,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                    ),
                    IconButton(onPressed: (){displayApartmentNameTextDialog(context);}, icon: Icon(Icons.edit),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name of Secretary : '+ nameSecretary,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                    ),
                    //IconButton(onPressed: (){displaySecretaryNameTextDialog(context);}, icon: Icon(Icons.edit),),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Address of Apartment : '+ address ,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                    ),
                    IconButton(onPressed: (){displayAddressTextDialog(context);}, icon: Icon(Icons.edit),),

                  ],
                ),
              ],
            ),
          ),
        )

    );
  }
}