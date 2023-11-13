import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:fakebook/src/pages/otherPages/personal_page_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomePage.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomePage());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case PersonalPageScreen.routeName:
      final User user = routeSettings.arguments as User;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PersonalPageScreen(user: user),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('404: Not Found'),
          ),
        ),
        settings: routeSettings,
      );
  }
}
