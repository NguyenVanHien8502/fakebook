import 'package:fakebook/src/pages/tabs/info_page.dart';
import 'package:fakebook/src/pages/tabs/setting_page.dart';
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
          //drawer: const MyDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Fakebook"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.notifications)),
                Tab(icon: Icon(Icons.view_headline)),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              HomePage(),
              HomePage(),
              NotificationPage(),
              InfoPage()
            ],
          )),
    );
  }
}
