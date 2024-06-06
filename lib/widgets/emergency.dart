import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fyp/widgets/emergency_slider/ambulance.dart';
import 'package:fyp/widgets/emergency_slider/fire_brigade.dart';
import 'package:fyp/widgets/emergency_slider/police.dart';
import 'package:fyp/widgets/emergency_slider/rescue.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'emergency Contacts'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 160,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              PoliceEmergency(),
              AmbulanceEmergency(),
              FirebrigadeEmergency(),
              RescueEmergency(),
            ],
          ),
        ),
      ],
    );
  }
}
