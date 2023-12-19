import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class FriendsSuggestScreen extends StatefulWidget {
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

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> fetchFriendSuggestList(BuildContext context) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getSuggestedFriend);
        Map body = {"index": "0", "count": "20"};

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
                        item['avatar'] ?? 'lib/src/assets/images/avatarfb.jpg',
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

  Future<void> requestFriend(BuildContext context, String id, int index) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.setRequestFriend);
        Map body = {
          "user_id": id,
        };

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
            // setState(() {
            //   FriendSuggest[index].updateIsFriend(1);
            // });
            return print("Đã gửi lời mời kết bạn");
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Bạn bè",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.search, color: Colors.black), // Icon tìm kiếm
            onPressed: () {
              print(
                  "Tìm cái méo gì, làm cho đẹp thôi, bấm textfield ở dưới mà tìm");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              for (int i = 0; i < FriendSuggest.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherPersonalPageScreen(
                            userId: FriendSuggest[i].user.id),
                      ),
                    );
                  },
                  child: Padding(
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
                                NetworkImage(FriendSuggest[i].user.avatar),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              Text(
                                '${FriendSuggest[i].mutualFriends} bạn chung',
                                style: TextStyle(fontSize: 12),
                              ),
                              //if (FriendSuggest[i].isFriend == 0)
                              Row(
                                children: [
                                  //Chấp nhận kết bạn
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        requestFriend(context,
                                            FriendSuggest[i].user.id, i);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Colors.blue[700],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  //Không chấp nhận kết bạn
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          FriendSuggest.removeWhere((friend) =>
                                              friend.user.id ==
                                              FriendSuggest[i].user.id);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent,
                                        backgroundColor: Colors.grey[300],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                              ),
                              // if (friendRequests[i].isFriend == 1)
                              //   const Text("Các bạn đã là bạn bè"),
                              // if (friendRequests[i].isFriend == 2)
                              //   const Text("Đã gỡ lời mời"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
