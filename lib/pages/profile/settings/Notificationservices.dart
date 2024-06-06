import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'package:fyp/main.dart';
import 'package:fyp/pages/profile/settings/messageScreen.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class NotificationServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationServices(BuildContext context) {
    _initializeLocalNotifications();
    requestNotificationPermission();
    firebaseInit();
    setupInteractMessage(context);
    _displayDeviceToken();
  }

  Future<String> getAccessToken() async {
    // Your service account credentials
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "wfyp-62cff",
      "private_key_id": "",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCqnKan7oKvVVDM\nwnY4P4oUa+jXC0gzgbWUmWRMyTwHDLyC/X2BmmVaBoXPWd8smohUidc+Baj1xcIN\ngNIWXzn9uSjnzbHSN5LQSjfQhf9uQWCk7A3Xsi0byFbhDR5PFiL44d4g1SzEBnE9\nsEe2/uqsM4pvA5/G8z9Qshmpx6w+TJUeriWf+2VQVK6DziZGVO+XAJR+4AULRjbu\nT+z7Ao7MwmGBOkQqf9xC/OhIIOHGl2OUM+bfin5N2C2/xKyKAP5IImB02Kz4HVzH\nVlMkXjL4T0UWt/06ln7p0DOzPiM6VXmA8nMi3y9qNGWuqU6yBCnUjWMTHFO3weKt\n2EgNb/EnAgMBAAECggEACBWjOgrty2QmD4XZd0Hfh6czYdlJgxNO6Os52v+gJg9e\n8XAUnesUiWcMuS4fiqwJ8MOVXP2Eq5zC3MPxcJjzlQfMnetb1UPH47HYojtvRqi3\nbSk4YLOzOoFMSJ7IBGRepN+DGJgxZlqNzCgJxeyfbyiEE02fKRzGr8q4t5hcG5mO\na+69DcmFcypalJtbzs+vOxMoREvj4Qk+T6Z8NLTGId/ozklLzu7Wg7VaMTlPD+QP\num6ac4vjyn8D3JB7Gexk2C+ToSCqjKzRuGz/U2uDp0BYJKghKyiuNYDrK/65io69\npkVU2f71LCo1E96dEjflqNYp+36+V2IZuizrAVoc3QKBgQDvdCbAtQsdw6/Bsw5p\nchHM/mw1YzQfx3Sq7TGuzhPIIOTJNKyz2bTF4Br/UxiLpvjMMMBIhMf5D7huAww6\nwLtNEnu0fAONyIkfmtpdO+T19LOuM4Mpl37e1mQk7eG14ff14stexLFMvnSSq8pK\neOkd4uAGWw57Kqwrj6xRsTAQhQKBgQC2ZrahVwuLtQ2jPvgBkL/FwOYzYWXk8PY+\nJ2JtjzzFtgr1zgH+mAu4aEBt4FdonRMPs7ckVtt4ZG5HipJ4Q+TPSqMZ4aTiEucY\nGWyGTHrMbZPO3EJmzMZ6wlZc7QU/8RfMfSOmAKHGOI6h1S/OnQTMqAlftva8jd9s\nU7363zpguwKBgQDqpinrof44trCe4jZ3Ql8LQS8MyiAkHDLJ5RJQuIVOEl3ghgvP\nWsH5Pnl2RxnAkGkyv3tOFUBZYvxaYgYz9PYWuswau4RIBoHJRNhDkRP3qkoBpV0c\n/uZGvFT6k1oiAEQa4ppkTd9o0yItMMdVX1MiBFeAIu7354M8VNiKXVY6eQKBgQCa\ndUZIP9bWGp6O077eTH4o7t3BOsQ3Z9mN7noKPtZ+slZ7qlTEDGs4YIfWw7ghLYo7\nrLr0udymCZ3dVToNP6kd5J1TSGIA03MAVF8zJsaCIHSfIqPUO6oDwFez3z6n0/iM\nQJgUdcqIedJGtqoCM7Mhv1YYyG4OY7GEITHqpGfiCwKBgQCuS3gR1CD4rYP7+qaK\nD8hVMYVHLQcLS9+1oq8spthK+1nWUtepu7amPT40tJKEbhXEJdMeV8Kus1+6wXoR\n0z/psqG2DDPs62fsmeQH17541lSJ4jsIdEFQF4/gMbSvu6RBgR1vD1yjO+e88Zxz\nILuXz6umwkIkFRVfAZdY3qROIw==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-s9jzy@wfyp-62cff.iam.gserviceaccount.com",
      "client_id": "102192548185465018496",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-s9jzy%40wfyp-62cff.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    var client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    var credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage() async {
    final String accessToken = await getAccessToken();
    const String fcmEndPoint =
        'https://fcm.googleapis.com/v1/projects/wfyp-62cff/messages:send';
    final String? currentFCMToken = await FirebaseMessaging.instance.getToken();

    if (currentFCMToken != null) {
      final Map<String, dynamic> message = {
        "message": {
          "token": currentFCMToken,
          "notification": {
            "title": "Notification from wSecure",
            "body": "By tapping user will navigate to the alert screen"
          },
          "data": {
            "userId": "123456",
            "messageType": "alert",
            "extraInfo": "Additional information relevant to the message"
          }
        }
      };

      final http.Response response = await http.post(
        Uri.parse(fcmEndPoint),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print("FCM message sent successfully");
      } else {
        print("Failed to send FCM message: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } else {
      print("Failed to get FCM token");
    }
  }

  Future<void> _initializeLocalNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _showNotification(
    RemoteMessage message,
  ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  void setupInteractMessage(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message, context);
    });
  }

  Future<void> _onSelectNotification(
      NotificationResponse notificationResponse) async {
    Map<String, dynamic> data =
        jsonDecode(notificationResponse.payload ?? '{}');
    if (data['userId'] != null) {
      _navigateToMessageScreen(data['userId']);
    }
  }

  void _handleMessage(RemoteMessage message, [BuildContext? context]) {
    Map<String, dynamic> data = message.data;
    if (data['userId'] != null && context != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageScreen(
            userId: data['userId'],
            id: '123456',
          ),
        ),
      );
    }
  }

  void _navigateToMessageScreen(String userId) {
    NavigatorKey.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => MessageScreen(
          userId: userId,
          id: '123456', // Assuming you also need to pass an 'id'
        ),
      ),
    );
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((newToken) {
      print('Token refreshed: $newToken');
    });
  }

  void foregroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in the foreground!');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showNotification(message);
      }
    });
  }

  // Display device token in the terminal
  void _displayDeviceToken() async {
    final String? deviceToken = await messaging.getToken();
    if (deviceToken != null) {
      print('Device Token: $deviceToken');
    } else {
      print('Failed to get device token');
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> scheduleNotification(
      DateTime scheduledTime, String payload) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Scheduled Notification',
      'This is the body of the scheduled notification',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> storeNotificationDetails(
      String title, String body, DateTime sentTime) async {
    await _firestore.collection('notifications').add({
      'title': title,
      'body': body,
      'sentTime': sentTime,
      'day': DateTime(sentTime.year, sentTime.month, sentTime.day),
    });
  }
}
