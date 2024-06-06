import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp/auth/forgotpassword.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier userCredential = ValueNotifier('');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(23.w, 80.h, 19.w, 30.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/wsecure-logo__2_-removebg-preview__1_-removebg-preview.png',
                    width: 220.w,
                    height: 220.h,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35.w),
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 228, 223, 223),
                          filled: true,
                          hintText: "email".tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: passwordController,
                        style: TextStyle(),
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 228, 223, 223),
                          filled: true,
                          hintText: "password".tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                      buildLoginButton(context),
                      SizedBox(height: 17.h),
                      buildForgotPasswordText(context),
                      SizedBox(height: 35.h),
                      buildOrDivider(),
                      SizedBox(height: 40.h),
                      buildAuthImage(),
                      SizedBox(height: 40.h),
                      buildRegisterText(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            signInWithEmailAndPassword(
                emailController.text, passwordController.text, context);
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Container(
          width: double.infinity,
          height: 57.h,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 28, 41, 72),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              'login'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForgotPasswordText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPassword(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(80.w, 0, 20.w, 20.h),
        child: Text(
          'forgot Password?'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            height: 1.325,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }

  Widget buildOrDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Text(
                'oR'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.1725,
                  color: Color.fromARGB(255, 163, 155, 155),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAuthImage() {
    return (userCredential.value == '' || userCredential.value == null)
        ? Center(
            child: SizedBox(
              height: 65.h,
              width: MediaQuery.of(context).size.width * .9,
              child: OutlinedButton(
                onPressed: () async {
                  continueWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/auth.png",
                      height: 30.h,
                      width: 30.w,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "continue with Google".tr,
                      style: TextStyle(fontSize: 16.sp),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget buildRegisterText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'register');
        },
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              height: 1.1725,
              color: Color(0xffffffff),
            ),
            children: [
              TextSpan(
                text: 'new Here?'.tr,
              ),
              TextSpan(
                text: 'register'.tr,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.1725,
                  color: Color.fromARGB(255, 16, 16, 206),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userSnapshot = await firestore
          .collection('login')
          .doc(userCredential.user!.uid)
          .get();

      if (!userSnapshot.exists) {
        await firestore.collection('login').doc(userCredential.user!.uid).set({
          'email': email,
        });
      }

      Navigator.pushNamed(context, 'bottom_screen');
    } catch (e) {
      print('Failed to sign in: $e');

      String errorMessage = "An error occurred during sign-in.";

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "User not found. Please check your email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password. Please try again.";
            break;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

Future<void> continueWithGoogle(BuildContext context) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamed(context, "bottom_screen");
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Some error occurred: $e"),
      ),
    );
  }
}
