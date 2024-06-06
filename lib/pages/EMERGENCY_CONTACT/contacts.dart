import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:fyp/controller/crud_service.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fyp/pages/EMERGENCY_CONTACT/update_contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchfocusNode = FocusNode();

  @override
  void initState() {
    _stream = CRUDService().getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  // to call the contact using url launcher
  callUser(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url ";
    }
  }

  // search Function to perform search
  searchContacts(String search) {
    _stream = CRUDService().getContacts(searchQuery: search);
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
          "contacts".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0.9.sw, 80.h),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: SizedBox(
              width: 0.9.sw,
              child: SizedBox(
                width: 280, // Set the desired width
                height: 60, // Set the desired height
                child: TextFormField(
                  onChanged: (value) {
                    searchContacts(value);
                    setState(() {});
                  },
                  focusNode: _searchfocusNode,
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15), // Adjust padding as needed
                    fillColor: Color.fromARGB(255, 228, 223, 223),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the border radius as needed
                    ),
                    label: Text("search".tr),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _searchfocusNode.unfocus();
                              _stream = CRUDService().getContacts();
                              setState(() {});
                            },
                            icon: Icon(Icons.close),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 28, 41, 72),
        onPressed: () {
          Navigator.pushNamed(context, "add_contacts");
        },
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: 32.r,
                      child: Text(FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase()),
                    ),
                    SizedBox(height: 10.h),
                    Text(FirebaseAuth.instance.currentUser!.email.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something Went Wrong".tr);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                "loading".tr,
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            );
          }
          return snapshot.data!.docs.length == 0
              ? Center(
                  child: Text(
                    "no Contacts Found ...".tr,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                )
              : ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateContact(
                                name: data["name"],
                                phone: data["phone"],
                                email: data["email"],
                                docID: document.id,
                              ),
                            ),
                          ),
                          leading: CircleAvatar(child: Text(data["name"][0])),
                          title: Text(data["name"],
                              style: TextStyle(fontSize: 16.sp)),
                          subtitle: Text(data["phone"],
                              style: TextStyle(fontSize: 14.sp)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.call, size: 20.sp),
                                onPressed: () {
                                  callUser(data["phone"]);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.message, size: 20.sp),
                                onPressed: () async {
                                  String phone = data["phone"];
                                  String url = 'sms:$phone'; // sms URL scheme
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      })
                      .toList()
                      .cast<Widget>(),
                );
        },
      ),
    );
  }
}
