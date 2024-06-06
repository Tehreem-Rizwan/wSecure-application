import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/pages/homepage/custom_appbar.dart';
import 'package:fyp/pages/homepage/customcarousel.dart';
import 'package:fyp/utils/quotes.dart';
import 'package:fyp/widgets/emergency.dart';
import 'package:fyp/widgets/livesafe/livesave.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int qIndex = 2;
  final List<Map<String, String>> nearbyContacts = [
    {'phone': '03236390557', 'latitude': '31.5204', 'longitude': '74.3587'},
    {'phone': '03364045209', 'latitude': '31.5204', 'longitude': '74.3587'},
    {'phone': '15', 'latitude': '31.5204', 'longitude': '74.3587'},
    {'phone': '1122', 'latitude': '31.5204', 'longitude': '74.3587'}
  ];

  getRandomquote() {
    Random random = Random();

    setState(() {
      qIndex = random.nextInt(goodSayings.length);
    });
  }

  @override
  void initState() {
    getRandomquote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.01,
                  vertical: constraints.maxHeight * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomerAppBar(
                      quoteIndex: qIndex,
                      onTap: getRandomquote,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    CustomCarousel(),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    Emergency(),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    LiveSafe(),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          print('Panic alert pressed');
                          await sendAlert(context);
                        },
                        child: Container(
                          width: 90.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 140, 11, 1),
                          ),
                          child: Center(
                            child: Text(
                              "alert".tr,
                              style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> sendAlert(BuildContext context) async {
    // Get emergency message
    String emergencyMessage = 'Emergency! Help needed!';

    // Get current location
    Position position = await getCurrentLocation();
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();
    String locationMessage =
        'My current location: Latitude $latitude, Longitude $longitude\n'
        'Location on Google Maps: https://www.google.com/maps?q=$latitude,$longitude';

    // Combine emergency message and location message
    String fullMessage = '$emergencyMessage\n\n$locationMessage';

    // Send the alert to all nearby contacts
    bool allMessagesSent = true;
    for (var contact in nearbyContacts) {
      String? recipient = contact['phone'];
      if (recipient != null && recipient.isNotEmpty) {
        bool result = await sendLocationToContact(fullMessage, recipient);
        if (!result) {
          allMessagesSent = false;
        }
      }
    }

    // Save alert to Firestore
    await FirebaseFirestore.instance.collection('alerts').add({
      'userId': '123456',
      'message': emergencyMessage,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': Timestamp.now(),
    });

    // Show a message based on whether all messages were sent successfully
    if (allMessagesSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All alert messages sent successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Some alert messages failed to send.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("Error getting location: $e");
      throw 'Could not get current location';
    }
  }

  Future<bool> sendLocationToContact(String message, String recipient) async {
    String url = 'sms:$recipient?body=$message';

    if (await canLaunch(url)) {
      await launch(url);
      return true;
    } else {
      print('Could not send SMS to $recipient');
      return false;
    }
  }
}
