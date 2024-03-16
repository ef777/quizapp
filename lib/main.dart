import 'package:acik_soru/page/auth/login/login_page.dart';
import 'package:acik_soru/page/splash/splash_page.dart';
import 'package:acik_soru/service/notifi_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AwesomeNotifications().initialize(
      "resource://drawable/notifi", //

      [
        NotificationChannel(
            icon: "resource://drawable/notifi", //
            channelKey: 'basic_channel',
            channelName: 'basic_channel',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.green,
            ledColor: Colors.green)
      ],
      debug: true);

  FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.5),
                borderRadius: context.border.lowBorderRadius),
          ),
          colorScheme: const ColorScheme(
              background: Color.fromRGBO(255, 255, 255, 1),
              brightness: Brightness.light,
              error: Color.fromRGBO(255, 0, 0, 1),
              onBackground: Color.fromRGBO(1, 1, 1, 1),
              onError: Color.fromARGB(255, 196, 148, 5),
              onPrimary: Color.fromARGB(255, 61, 140, 230),
              onSecondary: Color.fromARGB(255, 20, 57, 222),
              onSurface: Color.fromARGB(255, 0, 0, 0),
              primary: Color.fromRGBO(78, 116, 249, 1),
              secondary: Colors.deepOrangeAccent,
              surface: Colors.white),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
