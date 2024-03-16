// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'package:acik_soru/const/const.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:kadem/page/notifi/notifi_page.dart';
// import 'package:kadem/service/token_service.dart';

import '../firebase_options.dart';

var token;

class FirebaseNotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  void settingNotification() async {
    await messaging.requestPermission(alert: true, sound: true, badge: true);
  }

  void connectNotification() async {
    settingNotification();
    await Firebase.initializeApp(
        name: 'aci-bakis', options: DefaultFirebaseOptions.currentPlatform);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AndroidNotification? androidNotification = message.notification?.android;
      if (androidNotification != null) {}

      print(message.notification?.title.toString());

      AwesomeNotifications().createNotification(
          content: NotificationContent(
              icon: 'resource://drawable/notifi', // Kanal için varsayılan ikon.

              id: -1,
              channelKey: 'basic_channel',
              title: message.notification?.title ?? '',
              body: message.notification?.body ?? ''));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AndroidNotification? androidNotification = message.notification?.android;
      if (androidNotification != null) {}
      // NotificationHelper.showNotification(
      //   message.notification!.title!,
      //   message.notification!.body!,
      // );
      print(message.notification?.title.toString());

      // Uygulama ön plandayken gelen bildirim
      // Burada gelen bildirimi işleyebilirsiniz
    });

    FirebaseMessaging.instance.getToken().then((value) async {
      token = value;
      String? savedToken = await SharedService().getToken();
      if (savedToken == null && savedToken != value) {
        await SharedService().saveToken(token);

        print(value);
      }
      // String? savedToken = await SharedService().getToken();
      // if (savedToken == null && savedToken != value) {
      //   await SharedService().saveToken(token);

      //   SharedService(value);
      //   print(value);
      // }

      print("Token bu $value");
    });
  }
}

Future<void> tokenService(String? value) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/add-device-token');
  final String? bearerToken = Config.bareerToken;
  print(Config.userId);
  if (Config.userId != null) {
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $bearerToken',
    }, body: {
      "user_id": Config.userId.toString(),
      "device_tokens": value
    });
    print(response.body);
    if (response.statusCode == 200) {
      //return GetPackageModel.fromJson(jsonDecode(response.body));
      // Başarılı yanıt işleme
    }
  }
}

// Future<void> SharedService(
//   String? token,
// ) async {
//   print(token);
//   var response = await http.post(
//     Uri.parse("https://aciksoru.com.tr/api/tokenDeviceAdd"),
//     body: {
//       "user_id": Config.userId,
//       "device_tokens": token ?? "",
//     },
//   );
//   print("token cevap");
//   print(response.body);
//   // return UserModel.fromJson(jsonDecode(response.body));
// }

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("token: ${fCMToken}");

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title ${message.notification?.title}');
  print('Body ${message.notification?.body}');
  print('Payload ${message.data}');

  AwesomeNotifications().createNotification(
      content: NotificationContent(
          icon: 'resource://drawable/notifi', // Kanal için varsayılan ikon.

          id: -1,
          channelKey: 'basic_channel',
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? ''));
}
