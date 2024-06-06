import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/controller/crud_service.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "add Contact".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 33.h),
                SizedBox(
                  width: 0.9.sw,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter any name" : null,
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 228, 223, 223),
                      filled: true,
                      border: OutlineInputBorder(),
                      label: Text("name".tr),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 0.9.sw,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter phone number" : null,
                    controller: _phoneController,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 228, 223, 223),
                      filled: true,
                      border: OutlineInputBorder(),
                      label: Text("phone".tr),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 0.9.sw,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Enter  your email" : null,
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 228, 223, 223),
                      filled: true,
                      border: OutlineInputBorder(),
                      label: Text("email".tr),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  height: 58.h,
                  width: 0.8.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CRUDService().addNewContacts(
                          _nameController.text,
                          _phoneController.text,
                          _emailController.text,
                        );
                        Navigator.pushNamed(context, 'contacts');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 28, 41, 72),
                    ),
                    child: Text(
                      "create".tr,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
