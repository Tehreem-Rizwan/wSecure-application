import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void createAccount(BuildContext context) async {
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String email = _emailController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (firstName == "" ||
        lastName == "" ||
        email == "" ||
        phoneNumber == "" ||
        password == "" ||
        confirmPassword == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all the details")));
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
    } else {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User created")));
        Navigator.pushNamed(context, 'verification');
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ex.message ?? "An error occurred")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        title: Text(
          'create an Account'.tr,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            23.w,
            25.h,
            19.w,
            30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildEditableContainer('first Name'.tr,
                  widthFactor: 0.6,
                  controller: _firstNameController,
                  inputType: TextInputType.text),
              buildEditableContainer('last Name'.tr,
                  widthFactor: 0.8,
                  controller: _lastNameController,
                  inputType: TextInputType.text),
              buildEditableContainer('email Address'.tr,
                  controller: _emailController,
                  inputType: TextInputType.emailAddress),
              buildEditableContainer('phone Number'.tr,
                  widthFactor: 0.8,
                  controller: _phoneNumberController,
                  inputType: TextInputType.phone),
              buildEditableContainer('password'.tr,
                  isPassword: true,
                  widthFactor: 0.8,
                  controller: _passwordController,
                  inputType: TextInputType.visiblePassword),
              buildEditableContainer('confirm Password'.tr,
                  isPassword: true,
                  widthFactor: 0.8,
                  controller: _confirmPasswordController,
                  inputType: TextInputType.visiblePassword),
              buildGenderCheckboxes(),
              buildNextButton(context),
              SizedBox(height: 10.h),
              buildAlreadyMemberText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableContainer(String label,
      {bool isPassword = false,
      double widthFactor = 1.0,
      TextEditingController? controller,
      TextInputType? inputType}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity * widthFactor,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 228, 223, 223),
          filled: true,
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildGenderCheckboxes() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'gender'.tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isMaleChecked,
                      onChanged: (value) {
                        setState(() {
                          isMaleChecked = value ?? false;
                          if (isMaleChecked) {
                            isFemaleChecked = false;
                          }
                        });
                      },
                    ),
                    Text(
                      'male'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    Checkbox(
                      value: isFemaleChecked,
                      onChanged: (value) {
                        setState(() {
                          isFemaleChecked = value ?? false;
                          if (isFemaleChecked) {
                            isMaleChecked = false;
                          }
                        });
                      },
                    ),
                    Text(
                      'female'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
      child: TextButton(
        onPressed: () {
          createAccount(context);
        },
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 28, 41, 72),
          padding: EdgeInsets.symmetric(vertical: 15.h),
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              'next'.tr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAlreadyMemberText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'login');
      },
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
          children: [
            TextSpan(text: 'already a Member?'.tr),
            TextSpan(
              text: 'login'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 16, 16, 206),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
