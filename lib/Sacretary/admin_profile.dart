import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_apart/Sacretary/admin_home.dart';

import '../constants/colors.dart';



class profile_admin extends StatefulWidget {
  const profile_admin({super.key});

  @override
  State<profile_admin> createState() => _profile_adminState();
}

class _profile_adminState extends State<profile_admin> {
  String name = "";
  String email = "";
  String flat_no = "";
  String vehicles = "";
  String id = "";
  String imageUrl = "";
  String update_name = "";
  String update_flat = "";
  String update_vehicle = "";


  void pickImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseAuth.instance.currentUser!.uid);
    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
        FirebaseFirestore.instance
            .collection("Secretary")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'Profile_Image': imageUrl});
      });
    });
  }

  Future get() async {
    FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      if (snapshot.get("userUid") == FirebaseAuth.instance.currentUser!.uid) {
        setState(() {
          name = snapshot.data()!["Name"];
          email = snapshot.data()!["Email"];
          flat_no = snapshot.data()!["Flat Number"];
          vehicles = snapshot.data()!["Number of vehicles"];
          imageUrl = snapshot.data()!["Profile_Image"];
          id = FirebaseAuth.instance.currentUser!.uid;
        });
      }
    });
  }

  void initState() {
    get();
    super.initState();
  }

  Future name_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Name':update_name,
    });

  }

  Future flat_no_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Flat Number':update_flat,
    });
  }
  Future vehicel_no_update() async
  {
    await FirebaseFirestore.instance
        .collection('Secretary')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Number of vehicles':update_vehicle,
    });
  }

  displayNameTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Name'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_name = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Name"),
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
                    primary:prime
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  name_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profile_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: prime
                ),
              )
            ],
          );
        }
    );
  }




  displayFlatTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Flat Number'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_flat = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Flat Number"),
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
                    primary:prime
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  flat_no_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profile_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: prime
                ),
              )
            ],
          );
        }
    );
  }
  displayVehicleTextDialog(BuildContext context) async
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text('Update Number of Vehicles'),
            content: TextFormField(
              onChanged: (value){
                setState(() {
                  update_vehicle = value;
                });
              },
              decoration: InputDecoration(hintText: "Enter Number of Vehicles"),
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
                    primary: prime
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  vehicel_no_update();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => profile_admin()));
                },
                child: Text('Save',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                    primary: prime
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => admin_home()));
            })),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [

          CustomPaint(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
            painter: HeaderCurvedContaine(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 270, left: 184),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Container(
                    height: 410,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 25,right: 25,bottom: 30,),

                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),

                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Name : ' + name,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {displayNameTextDialog(context);},
                                ),
                              ),
                            ],
                          ),


                          SizedBox(height: 10,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Email : ' + email,
                                  style: TextStyle(fontSize: 20),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(

                              children: [

                                Text(
                                  'Flat NO : ' + flat_no,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {displayFlatTextDialog(context);},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'No of Vehicles : ' + vehicles,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {displayVehicleTextDialog(context);},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: GestureDetector(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: Text('ID : $id',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent),
                                      ),
                                      onLongPress: (){
                                        Clipboard.setData(ClipboardData(text: id)).whenComplete(() =>
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Text Copied'),
                                              ),
                                            )
                                        );

                                        // key.currentState.s(
                                        //     new SnackBar(content: new Text("Copied to Clipboard"),));
                                      },
                                    )

                                  ],
                                ),
                              )
                          ),
                          SizedBox(height: 10,),

                        ],
                      ),
                    )
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class HeaderCurvedContaine extends CustomPainter
{
  @override
  void paint(Canvas canvas, size) {
    Paint paint = Paint()..color = Colors.blueGrey;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
