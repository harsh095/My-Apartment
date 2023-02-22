import 'package:flutter/material.dart';
import 'package:my_apart/constants/colors.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About',style: TextStyle(color: Colors.black),),elevation: 2,backgroundColor: Colors.blueGrey.withOpacity(0.6),
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 220,

                child: Image.asset(
                  'assets/images/img_19.png',
                  fit: BoxFit.cover,

                ),
              ),

              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(

                  children: [
                    Text(
                      'My Apartment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text('      Welcome to our apartment management app! Our goal is to make your life as a resident of our apartment complex as easy and convenient as possible. With our app, you can manage your apartment and interact with the community from the palm of your hand. \n\n Some of the key features of our app include: \n\n        Pay rent online: No more checks or money orders. Our app allows you to pay your rent quickly and securely using your preferred payment method. '
                        '\n\n        Maintenance requests: Need something fixed in your apartment? Our app makes it easy to submit a maintenance request and track the progress of the repair. \n\n        Community events: Stay up-to-date with the latest events and activities happening in our apartment community. From holiday parties to fitness classes, you\'ll never miss out on the fun. \n\n        News and announcements: Get important updates from the apartment management team about upcoming changes or events in the community.'
                        '\n\nIn addition to these features, our app is designed to save you time and make your life more convenient. Whether you need to schedule a package delivery or reserve a community amenity, our app puts everything you need at your fingertips.\n\nWe\'re committed to providing the best possible experience for our residents, and we believe that our app is an important part of that. We hope you enjoy using our app and welcome any feedback or suggestions you may have. Thank you for choosing to live in our apartment community!\n\n\n'
                      ,style: TextStyle(fontSize: 16),
                    ),
                    Text('Thank You Regards!\n My Apartment...\n\n\n\n',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}