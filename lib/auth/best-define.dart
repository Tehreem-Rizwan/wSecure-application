import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Definition extends StatefulWidget {
  @override
  _DefinitionState createState() => _DefinitionState();
}

class _DefinitionState extends State<Definition> {
  String selectedOption = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'what best defines you?'.tr,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 90.h),
            buildSelectableButton('i am a student'.tr),
            SizedBox(height: 30.h),
            buildSelectableButton('i am a working professional'.tr),
            SizedBox(height: 30.h),
            buildSelectableButton('other'.tr),
            SizedBox(height: 80.h),
            ElevatedButton(
              onPressed: () {
                createAccount(selectedOption);

                // Navigate to the home page
                Navigator.pushReplacementNamed(context, 'bottom_screen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 28, 41, 72),
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 80.w),
              ),
              child: Text(
                'register'.tr,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectableButton(String text) {
    return Container(
      width: double.infinity,
      child: CupertinoButton(
        onPressed: () {
          setState(() {
            selectedOption = text;
          });
        },
        padding: EdgeInsets.all(20.h),
        color: selectedOption == text
            ? Color.fromARGB(255, 64, 142, 181)
            : Color.fromARGB(255, 28, 41, 72),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24.sp,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  Future<void> createAccount(String selectedOption) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: 'zrizwan092@gmail.com', // Replace with user's email
        password: 'password123',
      );

      User? user = userCredential.user;
      print('User registered: ${user?.uid}');

      // Save the selected option to Firestore
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'selectedOption': selectedOption,
        });
        print('User option saved to Firestore');
      }
    } catch (e) {
      print('Failed to create account: $e');
      // Handle registration failure
    }
  }
}
