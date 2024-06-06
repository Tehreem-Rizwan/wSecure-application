import 'package:flutter/material.dart';
import 'package:fyp/pages/profile/settings/notifications.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:fyp/pages/profile/settings/about.dart';
import 'package:fyp/pages/profile/settings/contactus.dart';
import 'package:fyp/pages/profile/settings/language.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ListTile(
            title: Text("Notification".tr),

            leading: Icon(LineAwesomeIcons.bell, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            trailing: Icon(LineAwesomeIcons.angle_right_solid,
                size: 18.0, color: Colors.grey), // Move trailing here
          ),
          ListTile(
            title: Text("language".tr),
            leading: Icon(LineAwesomeIcons.language_solid, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguagePage()),
              );
            },
            trailing: Icon(LineAwesomeIcons.angle_right_solid,
                size: 18.0, color: Colors.grey), // Move trailing here
          ),
          ListTile(
            title: Text("about".tr),
            leading:
                Icon(LineAwesomeIcons.info_circle_solid, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
            trailing: Icon(LineAwesomeIcons.angle_right_solid,
                size: 18.0, color: Colors.grey), // Move trailing here
          ),
          ListTile(
            title: Text("contact Us".tr),
            leading: Icon(LineAwesomeIcons.phone_solid, color: Colors.blue),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
            trailing: Icon(LineAwesomeIcons.angle_right_solid,
                size: 18.0, color: Colors.grey), // Move trailing her
          ),
        ],
      ),
    );
  }
}
