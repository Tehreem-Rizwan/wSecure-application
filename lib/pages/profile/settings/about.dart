import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ABout'.tr,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'wSEcure'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'description:'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              ' wSEcure the Women Safety App is designed to help women stay safe and secure in various situations. It provides features such as:\n\n'
                      '- emergency contacts\n'
                      '- location tracking\n'
                      '- video Recording in emergency \n'
                      '- safety tips and information\n'
                      '- quick access to emergency services\n'
                      '- customizable alert messages\n'
                  .tr,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'privacy Policy:'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'we take your privacy seriously. Our app does not collect or store any personal information without your consent.'
                  .tr,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
