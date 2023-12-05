import 'dart:ffi';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FriendsSuggestScreen extends StatefulWidget {
  static const String routeName = '/friends-suggest';
  static double offset = 0;
  const FriendsSuggestScreen({super.key});

  @override
  State<FriendsSuggestScreen> createState() => _FriendsSuggestState();
}

class FriendSuggest1 {
  final User user;
  final String mutualFriends;
  FriendSuggest1({
    required this.user,
    required this.mutualFriends,
  });
}

class _FriendsSuggestState extends State<FriendsSuggestScreen> {
  List<FriendSuggest1> FriendSuggest = [];

  ScrollController scrollController =
      ScrollController(initialScrollOffset: FriendsSuggestScreen.offset);
  ScrollController headerScrollController = ScrollController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> fetchFriendSuggestList(BuildContext context) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getSuggestedFriend);
        Map body = {"index": "0", "count": "5"};

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
            final List<dynamic> friendsData = responseBody['data'];
            // setState(() {
            //   totalGetrequests = responseBody['data']['total'];
            // });

            setState(() {
              FriendSuggest = friendsData.map((item) {
                return FriendSuggest1(
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
    //User? user = Provider.of<UserProvider>(context, listen: false).user;
    fetchFriendSuggestList(context);
  }

  @override
  void dispose() {
    //scrollController.dispose();
    //headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          FriendsSuggestScreen.offset);
      FriendsSuggestScreen.offset = scrollController.offset;
    });

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: 72,
          titleSpacing: 0,
          pinned: true,
          floating: true,
          primary: false,
          centerTitle: true,
          automaticallyImplyLeading: false,
          snap: true,
          forceElevated: innerBoxIsScrolled,
          //bottom: const PreferredSize(
          //preferredSize: Size.fromHeight(0), child: SizedBox()),
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
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(
                height: 1,
                color: Colors.black38,
                thickness: 3,
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: const Text(
                  "Những người bạn có thể biết",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ),
              for (int i = 0; i < FriendSuggest.length; i++)
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
                              AssetImage(FriendSuggest[i].user.avatar),
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
                                  FriendSuggest[i].user.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                //Thêm bạn bè
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
                                      'Thêm bạn bè',
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
                                //Gỡ khỏi gợi ý
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
                                      'Gỡ',
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
      ),
    );
  }
}
