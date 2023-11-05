import 'package:fakebook/src/pages/tabs/menu_page.dart';
import 'package:fakebook/src/pages/tabs/friend_page.dart';
import 'package:fakebook/src/utils/drawer.dart';
import 'package:fakebook/src/pages/tabs/home_page.dart';
import 'package:fakebook/src/pages/tabs/notification_page.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Colors.blueGrey,
            automaticallyImplyLeading: false,
            title: const Text(
              "Facebook",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print("Search");
                },
              ),
              IconButton(
                icon: const Image(
                  image: AssetImage('lib/src/assets/images/message.png'),
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("Navigate to messenger");
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.notifications)),
                Tab(icon: Icon(Icons.menu)),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              HomePage(),
              FriendPage(),
              NotificationPage(),
              MenuPage()
            ],
          )),
    );
  }
}
