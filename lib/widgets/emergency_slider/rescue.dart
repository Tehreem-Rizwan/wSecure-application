import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class RescueEmergency extends StatelessWidget {
  _callNumber(String number) async {
    final url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double scaleFactor = screenWidth / 430; // Base width of 430

    return Padding(
      padding: EdgeInsets.only(left: 10 * scaleFactor, bottom: 5 * scaleFactor),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20 * scaleFactor),
        ),
        child: InkWell(
          onTap: () => _callNumber('1122'),
          child: Container(
            width: screenWidth * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 * scaleFactor),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFD8080),
                  Color(0xFFFB8580),
                  Color(0xFFFBD079),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8 * scaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 27 * scaleFactor,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Image.asset(
                      'assets/images/rescue.png',
                      height: 40 *
                          scaleFactor, // Adjust the height based on scaleFactor
                      width: 40 *
                          scaleFactor, // Adjust the width based on scaleFactor
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'rescue'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18 * scaleFactor,
                          ),
                        ),
                        Text(
                          'Professional management of emergencies',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14 * scaleFactor,
                          ),
                        ),
                        Container(
                          height: 30 * scaleFactor,
                          width: 80 * scaleFactor,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20 * scaleFactor),
                          ),
                          child: Center(
                            child: Text(
                              '1 -1 -2 -2',
                              style: TextStyle(
                                color: Colors.red[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 14 * scaleFactor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
