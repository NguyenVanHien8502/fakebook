import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => FriendPageState();
}

class FriendRequest {
  final User user;
  final String mutualFriends;
  FriendRequest({
    required this.user,
    required this.mutualFriends,
  });
}

class FriendPageState extends State<FriendPage> {
  List<FriendRequest> friendRequests = [];
  String totalfriend = "";

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> fetchFriendList(BuildContext context, User user1) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getUserFriend);
        Map body = {"index": "0", "count": "10", "user_id": user1.id};

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
            final List<dynamic> friendsData = responseBody['data']['friends'];
            setState(() {
              totalfriend = responseBody['data']['total'];
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
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Container(
              width: 400,
              height: 72,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 2.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  hintText: "Click here to search...",
                  fillColor: Colors.white10,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nội dung của trang bạn muốn hiển thị
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$totalfriend bạn bè",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            const Text(
                              "Sắp xếp",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: const Divider(
                          height: 1,
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),

                      //List banj bef
                      for (int i = 0; i < friendRequests.length; i++)
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   OtherPersonalPageScreen.routeName,
                            //   arguments: user,
                            // );
                            print("Ban be");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 16.0),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        friendRequests[i].user.avatar),
                                    radius: 25,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            friendRequests[i].user.name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          '${friendRequests[i].mutualFriends} bạn chung',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )),
                                  ],
                                ),
                                const Spacer(),
                                // dùng cái này để icon xuống phía bên phải cùng của row
                                Container(
                                  margin: const EdgeInsets.only(right: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showConfirmationBottomSheet(
                                          context, friendRequests[i]);
                                    },
                                    child: const Icon(
                                      Icons.more_horiz,
                                      size: 20.0,
                                      color: Colors.black54,
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationBottomSheet(
      BuildContext context, FriendRequest friendr) {
    final scrollController = ScrollController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          controller:
              scrollController, // Thêm controller vào SingleChildScrollView
          physics: const ClampingScrollPhysics(), // Điều chỉnh tốc độ trượt lên
          child: Container(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Bạn muốn hoàn thành bài viết của mình sau ư?",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hãy lưu làm bản nháp hoặc tiếp tục chỉnh sửa.",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        // Xử lý khi dòng 1 được click
                        Navigator.of(context).pop(); // Đóng hộp thoại
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                FontAwesome5Brands
                                    .facebook_messenger, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Nhắn tin cho ${friendr.user.name}",
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                Icons
                                    .star, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bỏ theo dõi ${friendr.user.name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w600, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                FontAwesome
                                    .user_secret, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chặn ${friendr.user.name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w600, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        handledelete(friendr.user.name, friendr.user.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.white, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                Ionicons
                                    .person_remove, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.red, // Màu biểu tượng
                                size: 26, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hủy kết bạn với ${friendr.user.name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight:
                                        FontWeight.w400, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                const Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                          color: Colors.red,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> handledelete(String name, String id) async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hủy kết bạn với ${name}'),
          content: Text('Bạn có chắc muốn hủy kết bạn với ${name} không?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Huỷ',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteFriend(context, id);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Xác nhận',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.unfriend);
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
            return print("Đã xóa");
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
}
