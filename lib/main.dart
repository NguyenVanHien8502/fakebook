import 'package:fakebook/router.dart';
import 'package:fakebook/src/api/firebase_api.dart';
import 'package:fakebook/src/constants/global_variables.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.backgroundColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: GlobalVariables.iconColor),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const WelcomePage(),
    );
  }
}

// class PushNotificationService {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future<void> init() async {
//     // Cập nhật khi token thay đổi
//     _fcm.onTokenRefresh.listen((String token) {
//       // Gửi token mới đến server của bạn
//       sendTokenToServer(token);
//     });
//
//     // Lắng nghe khi nhận thông báo
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received a message: ${message.notification?.title}');
//     });
//
//     // Lắng nghe khi nhấn thông báo để mở ứng dụng
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//     });
//
//     // Lấy token thiết bị
//     String? token = await _fcm.getToken();
//     if (token != null) {
//       // Gửi token lên server của bạn khi khởi tạo ứng dụng
//       sendTokenToServer(token);
//     }
//   }
//
//   void sendTokenToServer(String token) {}
// }
