import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageScreen extends StatefulWidget {
  final String id;
  const MessageScreen({
    Key? key,
    required this.id,
    required userId,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final String message = "Emergency help needed!";
  String latitude = '';
  String longitude = '';
  final List<String> contacts = ['03236390557', '03364045209', '15'];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alert Screen".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("Button pressed");
            _launchSMS(context);
          },
          child: Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 140, 11, 1),
            ),
            child: Center(
              child: Text(
                "alert".tr,
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(30),
          ),
        ),
      ),
    );
  }

  // Function to launch SMS with pre-filled message and contacts
  void _launchSMS(BuildContext context) async {
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // Extract latitude and longitude
      String currentLatitude = position.latitude.toString();
      String currentLongitude = position.longitude.toString();

      // Compose SMS with pre-filled message and current location
      String smsBody =
          "$message\nCurrent Location: $currentLatitude, $currentLongitude\nLocation on Google Maps: https://maps.google.com/?q=$currentLatitude,$currentLongitude";
      // Join contacts with a comma
      String recipients = contacts.join(',');

      // Construct the URI
      String uri = "sms:$recipients?body=${Uri.encodeQueryComponent(smsBody)}";

      print('Attempting to launch SMS: $uri'); // Debug statement

      // Launch SMS app with pre-filled message
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }

      // Save alert to Firestore
      await FirebaseFirestore.instance.collection('alerts').add({
        'userId': widget.id,
        'message': message,
        'latitude': currentLatitude,
        'longitude': currentLongitude,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      // Show error if unable to launch SMS app
      print('Error: $e'); // Debug statement
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Could not launch messaging app.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
