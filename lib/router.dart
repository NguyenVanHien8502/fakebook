import 'package:fakebook/src/components/widget/story_details.dart';
import 'package:fakebook/src/features/comment/screens/comment_screen.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/model/story.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomePage.routeName:
      return MaterialPageRoute(builder: (context) => const WelcomePage());

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case StoryDetails.routeName:
      final Story story = routeSettings.arguments as Story;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => StoryDetails(story: story),
      );

    case OtherPersonalPageScreen.routeName:
      final User user = routeSettings.arguments as User;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            OtherPersonalPageScreen(userId: user.id),
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

    case CommentScreen.routeName:
      final Post post = routeSettings.arguments as Post;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => CommentScreen(
          post: post,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
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
