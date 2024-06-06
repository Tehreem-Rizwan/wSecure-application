import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart" show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:fyp/auth/login.dart';
import 'package:fyp/pages/profile/settings/feedback.dart';
import 'package:fyp/pages/profile/settings/settings.dart';

class ProfileSettings extends StatefulWidget {
  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return ProfilePage();
          } else {
            Fluttertoast.showToast(msg: 'Please login first');
            return Login();
          }
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? id;
  String? profilePic;
  String? downloadUrl;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          if (data != null) {
            setState(() {
              nameController.text = data['name'] ?? '';
              emailController.text = data['email'] ?? '';
              phoneController.text = data['phone'] ?? '';
              id = docSnapshot.id;
              profilePic = data['profilePic'];
            });
          }
        } else {
          Fluttertoast.showToast(msg: 'No profile data found');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to load profile data: $e');
    }
  }

  Widget _buildProfileImage() {
    if (profilePic != null && profilePic!.isNotEmpty) {
      if (profilePic!.startsWith('http')) {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 32,
          backgroundImage: NetworkImage(profilePic!),
        );
      } else {
        return CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 32,
          backgroundImage: FileImage(File(profilePic!)),
        );
      }
    } else {
      return Icon(
        Icons.person,
        color: Colors.white,
        size: 70,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 28, 41, 72),
        child: Column(
          children: [
            DrawerHeader(
              child: _buildProfileImage(),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text("s E T T I N G S".tr,
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Settings(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback, color: Colors.white),
              title: Text("f E E D B A C K".tr,
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text("s I G N O U T".tr,
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "profile Settings".tr,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: isSaving
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            )
          : SafeArea(
              child: Container(
                color: Color.fromARGB(255, 129, 199, 220),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final XFile? pickedImage =
                                  await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                              );
                              if (pickedImage != null) {
                                setState(() {
                                  profilePic = pickedImage.path;
                                });
                              }
                            },
                            child: Container(
                              child: profilePic == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.deepPurple,
                                      radius: 80,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/add_pic.png',
                                          height: 80,
                                          width: 80,
                                        ),
                                      ),
                                    )
                                  : profilePic!.contains('http')
                                      ? CircleAvatar(
                                          backgroundColor: Colors.deepPurple,
                                          radius: 80,
                                          backgroundImage:
                                              NetworkImage(profilePic!),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.deepPurple,
                                          radius: 80,
                                          backgroundImage:
                                              FileImage(File(profilePic!)),
                                        ),
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter your name'.tr,
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name'.tr;
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter your email'.tr,
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'Enter your phone number'.tr,
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 28, 41, 72),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                if (profilePic == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Please select a profile picture');
                                } else {
                                  updateProfile();
                                }
                              }
                            },
                            child: Text(
                              "update Profile".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<String?> uploadImage(String filePath) async {
    try {
      final fileName = Uuid().v4();
      final Reference fbStorage =
          FirebaseStorage.instance.ref('profile').child(fileName);
      final UploadTask uploadTask = fbStorage.putFile(File(filePath));
      await uploadTask.then((snapshot) async {
        downloadUrl = await snapshot.ref.getDownloadURL();
      });
      return downloadUrl;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  void updateProfile() async {
    setState(() {
      isSaving = true;
    });
    try {
      final imageUrl = await uploadImage(profilePic!);
      if (imageUrl != null) {
        final Map<String, dynamic> data = {
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'profilePic': imageUrl,
        };
        final userDocRef = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid);

        final userDocSnapshot = await userDocRef.get();

        if (userDocSnapshot.exists) {
          await userDocRef.update(data);
        } else {
          await userDocRef.set(data);
        }

        Fluttertoast.showToast(msg: 'Profile updated successfully'.tr);
      } else {
        Fluttertoast.showToast(msg: 'Failed to upload image');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to update profile: $e');
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }
}
