import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        title: Text(
          "contact Us".tr,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromRGBO(129, 199, 220, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Email: its.tehreem2830@gmail.com",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "phone no".tr + ": 03207166412",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "name".tr,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "email".tr,
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: _messageController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: "message".tr,
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    height: 60.0,
                    minWidth: double.infinity,
                    color: Color.fromRGBO(28, 41, 72, 1),
                    onPressed: _sendEmailAndStoreData,
                    child: Text(
                      "submit".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendEmailAndStoreData() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String message = _messageController.text;

    final String subject = 'Contact Us Form Submission';
    final String body = 'Name: $name\nEmail: $email\nMessage: $message';

    // Storing data in Firebase
    try {
      await FirebaseFirestore.instance.collection('contact_us').add({
        'name': name,
        'email': email,
        'message': message,
        'timestamp': DateTime.now(),
      });
    } catch (e) {
      print('Error storing form data: $e');
    }

    // Sending email
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'its.tehreemrizwan30@gmail.com',
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      print('Could not launch $emailUri');
    }
  }
}
