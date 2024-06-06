import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/auth/login.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "forgot Password".tr,
          style: TextStyle(
              color: Colors.white, fontSize: 20.sp), // Increased font size
        ),
        centerTitle: true, // Centered text
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Color.fromARGB(
            255, 129, 199, 220), // Background color for the whole page
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextFormField(
                  controller: forgotPasswordController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "email".tr,
                      enabledBorder: OutlineInputBorder(),
                      prefixIconColor: Colors.grey,
                      fillColor: Colors.white),
                ),
              ),
              SizedBox(height: 40.h),
              ElevatedButton(
                onPressed: () async {
                  var forgotEmail = forgotPasswordController.text.trim();
                  if (forgotEmail.isNotEmpty) {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: forgotEmail)
                          .then((value) async {
                        print("Email Sent!!");

                        // Store email in Firestore
                        await firestore.collection('passwordResets').add({
                          'email': forgotEmail,
                          'timestamp': FieldValue.serverTimestamp(),
                        });

                        Get.off(() => Login());
                      });
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 30, 41, 90), // Background color
                ),
                child: Text(
                  "forgot Password".tr,
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 20.sp, // Increased font size
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
