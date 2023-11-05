import 'package:fakebook/src/messenger/messenger_page.dart';
import 'package:fakebook/src/pages/otherPages/search_page.dart';
import 'package:fakebook/src/pages/tabs/menu_page.dart';
import 'package:fakebook/src/pages/tabs/friend_page.dart';
import 'package:fakebook/src/pages/tabs/watch_page.dart';
import 'package:fakebook/src/utils/drawer.dart';
import 'package:fakebook/src/pages/tabs/home_page.dart';
import 'package:fakebook/src/pages/tabs/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Colors.blueGrey,
            automaticallyImplyLeading: false,
            title: const Text(
              "Facebook",
              style: TextStyle(
                  fontFamily: 'Nunito', color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              appBarAction(
                Icons.search,
                    () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
              ),
              appBarAction(
                FontAwesome5Brands.facebook_messenger,
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessengerPage()));
                },
              )
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                    icon: Icon(
                  Ionicons.md_home,
                )),
                Tab(icon: Icon(Ionicons.logo_youtube)),
                Tab(icon: Icon(Ionicons.md_people)),
                Tab(icon: Icon(Ionicons.md_notifications_outline)),
                Tab(icon: Icon(Icons.menu)),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              HomePage(),
              WatchPage(),
              FriendPage(),
              NotificationPage(),
              MenuPage()
            ],
          )),
    );
  }

  Widget appBarAction(IconData icons, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed, // Sử dụng onPressed để xử lý khi được click
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.23),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icons,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
