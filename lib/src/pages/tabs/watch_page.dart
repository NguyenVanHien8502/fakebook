import 'package:fakebook/src/pages/app.dart';
import 'package:flutter/material.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  WatchPageState createState() => WatchPageState();
}

class WatchPageState extends State<WatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Thân xem video
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "Video",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.person, size: 30),
                            onPressed: () {
                              print("go to settings");
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          const Icon(Icons.search, size: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
