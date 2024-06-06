import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fyp/pages/profile/settings/notifications.dart';
import 'package:fyp/pages/safety-measures.dart';
import 'package:get/get.dart';
import 'package:fyp/auth/best-define.dart';
import 'package:fyp/auth/login.dart';
import 'package:fyp/auth/register.dart';
import 'package:fyp/auth/verification.dart';
import 'package:fyp/bottompage/bottom_screen.dart';
import 'package:fyp/pages/EMERGENCY_CONTACT/add_contacts.dart';
import 'package:fyp/pages/EMERGENCY_CONTACT/contacts.dart';
import 'package:fyp/pages/homepage/home.dart';
import 'package:fyp/pages/loading.dart';
import 'package:fyp/pages/location/location.dart';
import 'package:fyp/pages/profile/profilesettings.dart';
import 'package:fyp/pages/profile/settings/app_translation.dart';
import 'package:fyp/pages/video/video-recording.dart';
import 'package:fyp/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp/pages/profile/settings/messageScreen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932), // Adjust this to your design size
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "Poppins",
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 129, 199, 220),
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          translations: AppTranslation(),
          locale: Locale('en', 'US'),
          fallbackLocale: Locale('en', 'US'),
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ur', ''),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          navigatorKey: NavigatorKey.navigatorKey, // Set up the navigatorKey
          home: Loading(),
          routes: <String, WidgetBuilder>{
            'login': (context) => Login(),
            'register': (context) => Register(),
            'verification': (context) => Verification(),
            'best-define': (context) => Definition(),
            'bottom_screen': (context) => BottomScreen(),
            'home': (context) => Home(),
            'contacts': (context) => Contact(),
            'add_contacts': (context) => AddContact(),
            'Location': (context) => Location(),
            'video-recording': (context) => VideoRecording(),
            'safety-measures': (context) => SafetyMeasures(),
            'profilesettings': (context) => ProfileSettings(),
            'messageScreen': (context) => const MessageScreen(
                  id: '123456',
                  userId: null,
                ),
            'notifications': (context) => NotificationPage(),
          },
        );
      },
    );
  }
}

class NavigatorKey {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
