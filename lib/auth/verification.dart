import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show AuthCredential, FirebaseAuth, FirebaseAuthException, PhoneAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  String _verificationId = "";

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacementNamed(context, "best-define");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String verificationId, [int? resendToken]) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _sendOTP(String phoneNumber) {
    _verifyPhoneNumber(phoneNumber);
  }

  Future<void> _signInWithOTP() async {
    String enteredOTP =
        _otpControllers.map((controller) => controller.text).join();

    await _firestore.collection('otp_codes').add({
      'phoneNumber': _phoneNumberController.text.trim(),
      'otp': enteredOTP,
      'timestamp': FieldValue.serverTimestamp(),
    });

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: enteredOTP,
    );

    await _auth.signInWithCredential(credential);

    Navigator.pushReplacementNamed(context, "best-define");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'verification'.tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'enter Phone Number'.tr,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 60.h),
              ElevatedButton(
                onPressed: () {
                  _sendOTP(_phoneNumberController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 41, 72),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
                ),
                child: Text(
                  'send OTP'.tr,
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 50.w,
                    height: 60.h,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _otpControllers[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.sp, color: Colors.white),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              ElevatedButton(
                onPressed: () {
                  _signInWithOTP();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 41, 72),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
                ),
                child: Text(
                  'verify OTP and Continue'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
