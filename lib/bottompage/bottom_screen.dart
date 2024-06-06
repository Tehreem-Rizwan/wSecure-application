import 'package:flutter/material.dart';
import 'package:fyp/pages/EMERGENCY_CONTACT/contacts.dart';
import 'package:fyp/pages/homepage/home.dart';
import 'package:fyp/pages/location/location.dart';
import 'package:fyp/pages/profile/profilesettings.dart';
import 'package:fyp/pages/safety-measures.dart';
import 'package:fyp/pages/video/video-recording.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomScreen extends StatefulWidget {
  BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    Home(),
    Contact(),
    Location(),
    VideoRecording(),
    SafetyMeasures(),
    ProfileSettings(),
  ];

  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context,
        designSize: Size(360, 690), minTextAdapt: true, splitScreenMode: true);

    return Scaffold(
      body: Stack(
        children: [
          // Display the selected page
          pages[currentIndex],
          // Positioned widget for the red panic button (if needed)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        backgroundColor: Color.fromARGB(255, 28, 41, 72),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: 23.sp,
        selectedFontSize: 10.sp,
        unselectedFontSize: 10.sp,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Emergency Contact',
            icon: Icon(Icons.contacts),
          ),
          BottomNavigationBarItem(
            label: 'Location',
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            label: 'Video Recordings',
            icon: Icon(Icons.video_library),
          ),
          BottomNavigationBarItem(
            label: 'Safety Measures',
            icon: Icon(Icons.safety_check_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
