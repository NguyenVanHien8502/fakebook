import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/friends/friends_screen.dart';
import 'package:fakebook/src/features/home/home_app_bar.dart';
import 'package:fakebook/src/features/menu/menu_screen.dart';
import 'package:fakebook/src/features/newfeeds/newfeeds_screen.dart';
import 'package:fakebook/src/features/notification/notification_screen.dart';
import 'package:fakebook/src/features/watch/watch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  double toolBarHeight = 60;
  ScrollController scrollController = ScrollController();
  late final list = <Widget>[
    NewfeedsScreen(parentScrollController: scrollController),
    WatchScreen(parentScrollController: scrollController),
    FriendsScreen(),
    NotificationScreen(),
    MenuScreen()
  ];

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  String numberNoti = '0';

  Future<void> getNewNofi(BuildContext context) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.checkNewItems);
        Map body = {"last_id": "3", "category_id": "3"};

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            setState(() {
              numberNoti = responseBody['data']['new_items'];
            });
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getNewNofi(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: toolBarHeight,
              titleSpacing: 0,
              title: AnimatedContainer(
                onEnd: () {
                  setState(() {
                    if (index > 0) {
                      toolBarHeight = 0;
                    }
                  });
                },
                curve: Curves.linearToEaseOut,
                height: (index > 0) ? 0 : 60,
                duration: Duration(milliseconds: index == 0 ? 500 : 300),
                child: const HomeAppbarScreen(),
              ),
              ////
              floating: true,
              snap: index == 0,
              pinned: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(46),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  index = 0;
                                  toolBarHeight = 60;
                                  scrollController.jumpTo(
                                    0,
                                  );
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Tab(
                                      child: index != 0
                                          ? Image.asset(
                                              'lib/src/assets/images/home.png',
                                              width: 30,
                                              height: 30,
                                            )
                                          : Image.asset(
                                              'lib/src/assets/images/home-active.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                    ),
                                  ),
                                  if (index == 0)
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6 -
                                              10,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  index = 1;
                                  scrollController.jumpTo(0);
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Tab(
                                      child: index != 1
                                          ? Image.asset(
                                              'lib/src/assets/images/watch.png',
                                              width: 30,
                                              height: 30,
                                            )
                                          : Image.asset(
                                              'lib/src/assets/images/watch-active.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                    ),
                                  ),
                                  if (index == 1)
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6 -
                                              10,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  index = 2;
                                  scrollController.jumpTo(0);
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Tab(
                                      child: index != 2
                                          ? Image.asset(
                                              'lib/src/assets/images/people.png',
                                              width: 30,
                                              height: 30,
                                            )
                                          : Image.asset(
                                              'lib/src/assets/images/people-active.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                    ),
                                  ),
                                  if (index == 2)
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6 -
                                              10,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  index = 3;
                                  scrollController.jumpTo(0);
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Tab(
                                      child: index != 3
                                          ? Image.asset(
                                              'lib/src/assets/images/noti.jpg',
                                              width: 30,
                                              height: 30,
                                            )
                                          : Image.asset(
                                              'lib/src/assets/images/noti-active.jpg',
                                              width: 30,
                                              height: 30,
                                            ),
                                    ),
                                  ),
                                  if(numberNoti != '0')
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Center(
                                        child: Text(
                                          numberNoti,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (index == 3)
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6 -
                                              10,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  index = 4;
                                  scrollController.jumpTo(0);
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Tab(
                                      child: index != 4
                                          ? Image.asset(
                                              'lib/src/assets/images/menu.png',
                                              width: 24,
                                              height: 24,
                                            )
                                          : Image.asset(
                                              'lib/src/assets/images/menu-active.png',
                                              width: 24,
                                              height: 24,
                                            ),
                                    ),
                                  ),
                                  if (index == 4)
                                    Positioned(
                                      bottom: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6 -
                                              10,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///vach ngan cach
                    const Divider(
                      color: Colors.black12,
                      height: 0,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: list[index],
      ),
    );
  }
}
