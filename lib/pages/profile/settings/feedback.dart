import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<bool> isTypeSelected = [false, false, false, true, true];
  late TextEditingController feedbackController;
  late TextEditingController phoneNumberController;
  File? _image;

  @override
  void initState() {
    super.initState();
    feedbackController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitFeedback() async {
    // Upload image to Firebase Storage if exists
    String? imageUrl;
    if (_image != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('feedback_images')
          .child(DateTime.now().toString());
      final uploadTask = storageRef.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() {});
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    // Store feedback data in Firestore
    await FirebaseFirestore.instance.collection('feedback').add({
      'type': isTypeSelected.indexWhere((isSelected) => isSelected),
      'feedback': feedbackController.text.trim(),
      'phoneNumber': phoneNumberController.text.trim(),
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Clear controllers and reset state
    feedbackController.clear();
    phoneNumberController.clear();
    setState(() {
      _image = null;
      isTypeSelected = [false, false, false, true, true];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "feedback".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "please select the type of the feedback".tr,
              style: TextStyle(
                color: Color.fromARGB(255, 133, 110, 110),
              ),
            ),
            SizedBox(height: 25.0),
            GestureDetector(
              child: buildCheckItem(
                  title: "login trouble".tr, isSelected: isTypeSelected[0]),
              onTap: () {
                setState(() {
                  isTypeSelected[0] = !isTypeSelected[0];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "phone number related".tr,
                  isSelected: isTypeSelected[1]),
              onTap: () {
                setState(() {
                  isTypeSelected[1] = !isTypeSelected[1];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "alert not sending".tr, isSelected: isTypeSelected[2]),
              onTap: () {
                setState(() {
                  isTypeSelected[2] = !isTypeSelected[2];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "other issues".tr, isSelected: isTypeSelected[3]),
              onTap: () {
                setState(() {
                  isTypeSelected[3] = !isTypeSelected[3];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "suggestions".tr, isSelected: isTypeSelected[4]),
              onTap: () {
                setState(() {
                  isTypeSelected[4] = !isTypeSelected[4];
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            buildFeedbackForm(),
            SizedBox(height: 20.0),
            buildNumberField(),
            Spacer(),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(28, 41, 72, 1.0),
                  ),
                  onPressed: _submitFeedback,
                  child: Text(
                    "sUBMIT".tr,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildNumberField() {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Color(0xFFC5C5C5),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "+92",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 133, 110, 110),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: Color.fromARGB(255, 133, 110, 110),
        ),
        hintText: "phone Number".tr,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildFeedbackForm() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: Color(0xFFA6A6A6),
            ),
          ),
        ),
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFFA5A5A5),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "upload screenshot (optional)".tr,
              style: TextStyle(
                color: Color.fromARGB(255, 133, 110, 110),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCheckItem({required String title, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey),
          ),
        ],
      ),
    );
  }
}
