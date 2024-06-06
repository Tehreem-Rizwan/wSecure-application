import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp/pages/location/locationsharedwithme.dart';
import 'package:fyp/pages/location/user_current_location.dart';

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSizeMultiplier = screenWidth / 430;
    double imageMultiplier = screenWidth / 430;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CurrentLocationScreen()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 41, 72),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 153 * imageMultiplier,
                        height: 155 * imageMultiplier,
                        child: Image.asset(
                          'assets/images/auto-group-lxhz.png',
                          width: 153 * imageMultiplier,
                          height: 155 * imageMultiplier,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'share My Location'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26 * fontSizeMultiplier,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NearbyLocationsCard()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 41, 72),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 153 * imageMultiplier,
                        height: 155 * imageMultiplier,
                        child: Image.asset(
                          'assets/images/auto-group-lxhz.png',
                          width: 153 * imageMultiplier,
                          height: 155 * imageMultiplier,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'location Shared with me'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26 * fontSizeMultiplier,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
