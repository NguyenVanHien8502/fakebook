import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:fakebook/src/pages/otherPages/about.dart';
import 'package:fakebook/src/pages/app.dart';
import 'package:fakebook/src/pages/otherPages/secret.dart';
import 'package:fakebook/src/pages/otherPages/personal_page.dart';
import 'package:fakebook/src/pages/tabs/notification_page.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/welcome": (BuildContext context) => const WelcomePage(),
        "/about": (BuildContext context) => const About(),
        "/app": (BuildContext context) => const App(),
        "/other-page": (BuildContext context) => const SecretPage(),
        "/login": (BuildContext context) => LoginPage(),
        '/personal-page': (context) => PersonalPage(),
        '/notifications': (BuildContext context) => const NotificationPage(),
      },
      initialRoute: "/",
      // title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}
