import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyLocationsCard extends StatelessWidget {
  const NearbyLocationsCard({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';

    if (Platform.isAndroid) {
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not launch $googleUrl';
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Opening maps is not supported on this platform.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.6;
    double buttonHeight = 50.0;
    double fontSize = 16.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nearest Emergency Live Safe",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF81C7DC),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFF81C7DC),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: buttonWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () => openMap('Police Stations near me'),
                icon: Icon(Icons.local_police),
                label: Text(
                  'Police',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => openMap('Hospitals near me'),
                icon: Icon(Icons.local_hospital),
                label: Text(
                  'Hospital',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => openMap('Pharmacy near me'),
                icon: Icon(Icons.local_pharmacy),
                label: Text(
                  'Pharmacy',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => openMap('Bus Station near me'),
                icon: Icon(Icons.directions_bus),
                label: Text(
                  'Bus Station',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
