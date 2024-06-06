import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MapScreen.dart';

class CurrentLocationScreen extends StatefulWidget {
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  var locationMessage = '';
  String latitude = '';
  String longitude = '';

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: MediaQuery.of(context).size.width *
                    0.15, // Adjust icon size
                color: Colors.white,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.05), // Adjust spacing
              Text(
                "Get User Location",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width *
                      0.08, // Adjust font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.05), // Adjust spacing
              Text(
                locationMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02), // Adjust spacing
              // button for taking the location
              ElevatedButton(
                onPressed: getCurrentLocation,
                child: Text(
                  "Get User Location",
                  style: TextStyle(color: Color.fromARGB(255, 28, 41, 72)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0), // Adjust padding
                  minimumSize: Size(
                    MediaQuery.of(context).size.width *
                        0.5, // Adjust button width
                    MediaQuery.of(context).size.height *
                        0.06, // Adjust button height
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02), // Adjust spacing
              ElevatedButton(
                onPressed: openMapScreen,
                child: Text(
                  "Open Google Map",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0), // Adjust padding
                  minimumSize: Size(
                    MediaQuery.of(context).size.width *
                        0.5, // Adjust button width
                    MediaQuery.of(context).size.height *
                        0.06, // Adjust button height
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.02), // Adjust spacing
              // Share button
              ElevatedButton.icon(
                onPressed: shareLocation,
                icon: Icon(Icons.share, color: Colors.black),
                label: Text("Share Location",
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0), // Adjust padding
                  minimumSize: Size(
                    MediaQuery.of(context).size.width *
                        0.5, // Adjust button width
                    MediaQuery.of(context).size.height *
                        0.06, // Adjust button height
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function for getting the current location
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    var lat = position.latitude;
    var long = position.longitude;

    setState(() {
      latitude = "$lat";
      longitude = "$long";
      locationMessage = "Latitude: $lat, Longitude: $long";
    });

    // Store location in Firestore
    storeLocation(lat, long);
  }

  // function for storing location data in Firestore
  void storeLocation(double lat, double long) {
    _firestore.collection('user_locations').add({
      'latitude': lat,
      'longitude': long,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print('Location stored successfully');
    }).catchError((error) {
      print('Failed to store location: $error');
    });
  }

  // function for opening it in google maps
  void openMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );
  }

  // function for sharing location via SMS
  void shareLocation() async {
    if (latitude.isNotEmpty && longitude.isNotEmpty) {
      String message =
          'My current location:  "Latitude $latitude, Longitude $longitude,https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"';
      String url = 'sms:?body=$message';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch SMS';
      }
    }
  }
}
