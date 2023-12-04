import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/friends/friend_suggest.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/features/friends/friend_page.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends-screen';
  static double offset = 0;
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class FriendRequest {
  final User user;
  //final String time;
  final String mutualFriends;
  //final User? f1;
  //final User? f2;
  FriendRequest({
    required this.user,
    //required this.time,
    required this.mutualFriends,
    //this.f1,
    //this.f2,
  });
}

class _FriendsScreenState extends State<FriendsScreen> {
  //final today = DateTime.now();
  List<FriendRequest> friendRequests = [];
  String totalGetrequests = "";

  ScrollController scrollController =
      ScrollController(initialScrollOffset: FriendsScreen.offset);
  ScrollController headerScrollController = ScrollController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> fetchFriendList(BuildContext context, User user1) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.get_requested_friend);
        Map body = {"index": "0", "count": "10"};

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
            final List<dynamic> friendsData = responseBody['data']['requests'];
            setState(() {
              totalGetrequests = responseBody['data']['total'];
            });

            setState(() {
              friendRequests = friendsData.map((item) {
                return FriendRequest(
                  user: User(
                    id: item['id'].toString(),
                    name: item['username'],
                    avatar:
                        //item['avatar'] ??
                        'lib/src/assets/images/avatarfb.jpg',
                  ),
                  mutualFriends: item['same_friends'],
                );
              }).toList();
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
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    fetchFriendList(context, user!);
  }

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          FriendsScreen.offset);
      FriendsScreen.offset = scrollController.offset;
    });
    return NestedScrollView(
      controller: headerScrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: 45,
          titleSpacing: 0,
          pinned: true,
          floating: true,
          primary: false,
          centerTitle: true,
          automaticallyImplyLeading: false,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0), child: SizedBox()),
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Bạn bè',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          child: IconButton(
                            splashRadius: 18,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          child: IconButton(
                            splashRadius: 18,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Gợi ý bạn bè
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FriendsSuggestScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Gợi ý',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FriendPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Bạn bè',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              thickness: 0.5,
              height: 40,
              indent: 10,
              endIndent: 10,
            ),
            //Lời mời kết bạn
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Lời mời kết bạn',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${totalGetrequests}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Danh sách kết bạn

            for (int i = 0; i < friendRequests.length; i++)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage(friendRequests[i].user.avatar),
                        radius: 42,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                friendRequests[i].user.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Text(
                              //   friends[i].time,
                              //   style: const TextStyle(
                              //     color: Colors.black54,
                              //     fontSize: 14,
                              //   ),
                              // ),
                            ],
                          ),
                          // if (friends[i].mutualFriends != null &&
                          //     friends[i].mutualFriends! > 0)
                          //   Padding(
                          //     padding: const EdgeInsets.only(
                          //       top: 2,
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Stack(
                          //           children: [
                          //             friends[i].f2 != null
                          //                 ? const SizedBox(
                          //                     width: 46,
                          //                     height: 28,
                          //                   )
                          //                 : const SizedBox(
                          //                     width: 28,
                          //                     height: 28,
                          //                   ),
                          //             if (friends[i].f2 != null)
                          //               Positioned(
                          //                 left: 22,
                          //                 top: 2,
                          //                 child: CircleAvatar(
                          //                   backgroundImage: AssetImage(
                          //                       friends[i].f2!.avatar),
                          //                   radius: 12,
                          //                 ),
                          //               ),
                          //             Positioned(
                          //               left: 0,
                          //               top: 0,
                          //               child: Container(
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   border: Border.all(
                          //                     color: Colors.white,
                          //                     width: 2,
                          //                   ),
                          //                 ),
                          //                 child: CircleAvatar(
                          //                   backgroundImage: AssetImage(
                          //                       friends[i].f1!.avatar),
                          //                   radius: 12,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //         const SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           '${friends[i].mutualFriends} bạn chung',
                          //           style: const TextStyle(
                          //             color: Colors.black54,
                          //             fontSize: 14,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              //Chấp nhận kết bạn
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.blue[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Chấp nhận',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              //Không chấp nhận kết bạn
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Xóa',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
