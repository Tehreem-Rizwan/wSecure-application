import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/pages/profile/settings/Notificationservices.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final NotificationServices _notificationServices;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    _notificationServices = NotificationServices(context);
    _notificationServices.requestNotificationPermission();
    _notificationServices.firebaseInit();
    _notificationServices.setupInteractMessage(context);
    _notificationServices.isTokenRefresh();
  }

  Future<void> _sendFCMMessage() async {
    await _notificationServices.sendFCMMessage();
  }

  Future<void> _scheduleNotification(DateTime scheduledTime) async {
    print('Scheduled Time: $scheduledTime');
    await _notificationServices.scheduleNotification(
        scheduledTime, 'Payload for scheduled notification');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 129, 199, 220),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 129, 199, 220),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _sendFCMMessage,
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 28, 41, 72),
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 24.h),
              ),
              child: const Text(
                'send Notification',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 14),
            TextButton(
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  var now = DateTime.now();
                  var scheduledDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  await _scheduleNotification(scheduledDateTime);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 28, 41, 72),
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 12.h),
              ),
              child: const Text(
                'Set Notification Time',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
