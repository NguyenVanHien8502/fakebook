import 'dart:async';
import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ResultSearchPage extends StatefulWidget {
  final String keyword;

  const ResultSearchPage({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  @override
  ResultSearchPageState createState() => ResultSearchPageState();
}

class ResultSearchPageState extends State<ResultSearchPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    handleSearch();
    getUserFriends();
  }

  // lấy ra các kết quả của search
  var listUsers = [];

  Future<void> handleSearch() async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.searchUsers);
      Map body = {"keyword": widget.keyword, "index": "0", "count": "20"};

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
      // print(responseBody['data']);

      setState(() {
        listUsers.addAll(responseBody['data'] ?? []);
      });
      print(listUsers);
    } catch (error) {
      print('Error fetching user search: $error');
    }
  }

  // lấy ra danh sách bạn bè của chính current user
  var listFriends = [];

  Future<void> getUserFriends() async {
    String? token = await storage.read(key: 'token');
    dynamic currentUser = await storage.read(key: 'currentUser');
    dynamic userId = jsonDecode(currentUser)['id'];
    try {
      var url = Uri.parse(ListAPI.getUserFriend);
      Map body = {"index": "0", "count": "20", "user_id": "$userId"};

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
      // print(responseBody['data']);

      setState(() {
        listFriends.addAll(responseBody['data']['friends'] ?? []);
      });

      for (var i = 0; i < listUsers.length; i++) {
        int id = int.parse(listUsers[i]['id'] ?? "");
        dynamic isFriended = listFriends.firstWhere((element) {
          return int.parse(element['id']) == id;
        }, orElse: () => null);
        if (isFriended != null) {
          setState(() {
            isFriend[id] = '1';
          });
        } else {
          setState(() {
            isFriend[id] = '0';
          });
        }
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  Map<int, String> isFriend =
      {}; //1: đã là bạn bè, 0: chưa là bạn bè, -1: gửi lời mời kết bạn nhưng chưa được chấp nhận

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Kết quả tìm kiếm",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: listUsers.isNotEmpty
                ? listUsers
                    .map((user) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OtherPersonalPageScreen(
                                            userId: user['id']),
                                  ),
                                );
                              },
                              child: Container(
                                color: const Color(0xFFF7E8E8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    () {
                                      if (user['avatar'] != "") {
                                        return ClipOval(
                                          child: Image.network(
                                            '${user['avatar']}',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit
                                                .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                          ),
                                        );
                                      } else {
                                        return Image.asset(
                                          'lib/src/assets/images/avatar.jpg',
                                          width: 100,
                                          height: 100,
                                        );
                                      }
                                    }(),
                                    const SizedBox(
                                      width: 25.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['username'],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${user['same_friends']} bạn chung",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            int id = int.parse(user['id']);
                                            String? token = await storage.read(
                                                key: 'token');
                                            if (isFriend.containsKey(id) &&
                                                (isFriend[id] == '1')) {
                                            } else if (isFriend[id] == '0') {
                                              // send request friend
                                              try {
                                                var url = Uri.parse(
                                                    ListAPI.setRequestFriend);
                                                Map body = {"user_id": "$id"};

                                                http.Response response =
                                                    await http.post(
                                                  url,
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json',
                                                    'Authorization':
                                                        'Bearer $token',
                                                  },
                                                  body: jsonEncode(body),
                                                );

                                                // Chuyển chuỗi JSON thành một đối tượng Dart
                                                final responseBody =
                                                    jsonDecode(response.body);
                                                print(responseBody['data']);

                                                setState(() {
                                                  isFriend[id] = '-1';
                                                });
                                              } catch (error) {
                                                print(
                                                    'Error fetching friends: $error');
                                              }
                                            } else {
                                              // delete request friend
                                              try {
                                                var url = Uri.parse(
                                                    ListAPI.delRequestFriend);
                                                Map body = {"user_id": "$id"};

                                                http.Response response =
                                                    await http.post(
                                                  url,
                                                  headers: {
                                                    'Content-Type':
                                                        'application/json',
                                                    'Authorization':
                                                        'Bearer $token',
                                                  },
                                                  body: jsonEncode(body),
                                                );

                                                // Chuyển chuỗi JSON thành một đối tượng Dart
                                                final responseBody =
                                                    jsonDecode(response.body);
                                                print(responseBody['data']);

                                                setState(() {
                                                  isFriend[id] = '0';
                                                });
                                              } catch (error) {
                                                print(
                                                    'Error fetching friends: $error');
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shadowColor: Colors.transparent,
                                            backgroundColor: () {
                                              int id =
                                                  int.parse(user['id'] ?? "");
                                              if (isFriend.containsKey(id) &&
                                                  (isFriend[id] == '1')) {
                                                return const Color(0xFFEDC3C4);
                                              } else {
                                                return Colors.blue[700];
                                              }
                                            }(),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: () {
                                            int id = int.parse(user['id']);
                                            if (isFriend.containsKey(id) &&
                                                (isFriend[id] == '1')) {
                                              return const Text(
                                                'Đã trở thành bạn bè',
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              );
                                            } else if (isFriend[id] == '0') {
                                              return const Text(
                                                'Thêm bạn bè',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              );
                                            } else if (isFriend[id] == '-1') {
                                              return const Text(
                                                'Đã gửi lời mời kết bạn',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              );
                                            }
                                          }(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ))
                    .toList()
                : [
                    const Center(
                      child: Text("Không tìm thấy kết quả phù hợp!"),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
