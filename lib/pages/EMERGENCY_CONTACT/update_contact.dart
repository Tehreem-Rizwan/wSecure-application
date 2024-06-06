import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp/controller/crud_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    super.key,
    required this.docID,
    required this.name,
    required this.phone,
    required this.email,
  });

  final String docID, name, phone, email;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _nameController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        title: Text(
          "Update Contacts".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 27.h),
                SizedBox(
                  width: 0.9.sw,
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "enter any name".tr : null,
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
                  height: 65.h,
                  width: 0.9.sw,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        CRUDService().updateContact(
                          _nameController.text,
                          _phoneController.text,
                          _emailController.text,
                          widget.docID,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 28, 41, 72),
                      fixedSize: Size(150, 50),
                    ),
                    child: Text(
                      "update".tr,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 65.h,
                  width: 0.9.sw,
                  child: OutlinedButton(
                    onPressed: () {
                      CRUDService().deleteContact(widget.docID);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 28, 41, 72),
                      fixedSize: Size(150, 50),
                    ),
                    child: Text(
                      "delete".tr,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
