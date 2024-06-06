import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // Define _selectedLanguage here

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "language selection".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Adjust width as needed
              height: 50, // Adjust height as needed
              child: ElevatedButton(
                onPressed: () {
                  Get.updateLocale(Locale('en', 'US'));
                },
                child: Text('English',
                    style:
                        TextStyle(fontSize: 20)), // Adjust font size as needed
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200, // Adjust width as needed
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.updateLocale(Locale('ur', 'PK'));
                },
                child: Text('اردو', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
