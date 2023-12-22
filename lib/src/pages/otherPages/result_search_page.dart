import 'dart:async';
import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/buy_coins.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:fakebook/src/pages/otherPages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
    handleSearchUser();
    handleSearchPost();
    getUserFriends();
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

  // lấy ra các kết quả user của search
  var listUsers = [];

  Future<void> handleSearchUser() async {
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

  // lấy ra các kết quả post của search
  var listPosts = [];

  Future<void> handleSearchPost() async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.search);
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
        listPosts.addAll(responseBody['data'] ?? []);
      });

      for (var i = 0; i < listPosts.length; i++) {
        int postId = int.parse(listPosts[i]['id'] ?? "");
        if (listPosts[i]['is_felt'] == '-1') {
          setState(() {
            isFeltKudo[postId] = '-1';
          });
        } else if (listPosts[i]['is_felt'] == '0') {
          setState(() {
            isFeltKudo[postId] = '0';
          });
        } else if (listPosts[i]['is_felt'] == '1') {
          setState(() {
            isFeltKudo[postId] = '1';
          });
        }
      }

      for (var i = 0; i < listPosts.length; i++) {
        int postId = int.parse(listPosts[i]['id'] ?? "");
        int feelOfPost = int.parse(listPosts[i]['feel']);
        setState(() {
          feel[postId] = feelOfPost;
        });
      }
    } catch (error) {
      print('Error fetching post search: $error');
    }
  }

  Map<int, String> isFeltKudo =
      {}; //-1, 0, 1 lần lượt là không bày tỏ cảm xúc, bày tỏ phẫn nộ và bày tỏ like
  Map<int, int> feel = {};

// Hàm hiển thị menu tùy chọn
  void showReactionMenu(BuildContext context, int postId) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(-80, 315, 0, 0),
      elevation: 0,
      // Đặt độ nâng của PopupMenu để loại bỏ border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của border
      ),
      color: Colors.transparent,
      // color: Colors.blue,
      items: [
        PopupMenuItem<String>(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PopupMenuItem<String>(
                padding: const EdgeInsets.all(0),
                value: '1',
                child: Image.asset(
                  'lib/src/assets/images/reactions/like.png',
                  width: 30,
                  height: 30,
                ),
              ),
              PopupMenuItem<String>(
                padding: const EdgeInsets.all(0),
                value: '0',
                child: Image.asset(
                  'lib/src/assets/images/reactions/angry.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) async {
      if (value != null) {
        // Thực hiện các hành động tương ứng
        String? token = await storage.read(key: 'token');
        try {
          var url = Uri.parse(ListAPI.feel);
          Map body = {"id": postId, "type": value};
          http.Response response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(body),
          );

          // Chuyển chuỗi JSON thành một đối tượng Dart
          var responseBody = jsonDecode(response.body);
          print(responseBody);

          if (responseBody['code'] == '1000') {
            setState(() {
              if (isFeltKudo[postId] == '-1') {
                feel[postId] = (feel[postId]! + 1)!;
              }
              isFeltKudo[postId] = value == '1' ? '1' : '0';
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thông báo'),
                  content: Text('${responseBody['message']}'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuyCoins()));
                      },
                      child: const Text(
                        'MUA COINS',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          print('Error: $e');
        }
      }
    });
  }

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
          child: Column(children: [
            Column(
              children: listUsers.isNotEmpty
                  ? listUsers
                      .map((user) => Column(
                            children: [
                              InkWell(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                              String? token = await storage
                                                  .read(key: 'token');
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
                                                  return const Color(
                                                      0xFFEDC3C4);
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
                              const Divider(
                                height: 1,
                                color: Colors.black12,
                                thickness: 5,
                              ),
                            ],
                          ))
                      .toList()
                  : [
                      const Center(
                        child: Text("Không tìm thấy người dùng nào phù hợp!"),
                      )
                    ],
            ),
            Column(
              children: listPosts.isNotEmpty
                  ? listPosts.map((post) {
                      return Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: const Color(0xFFF7E8E8),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPostPage(
                                                      postId:
                                                          int.parse(post['id']),
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 16.0,
                                                top: 16.0,
                                                bottom: 16.0),
                                            child: () {
                                              if (post['author'] != null &&
                                                  post['author']['avatar'] !=
                                                      null &&
                                                  post['author']['avatar'] !=
                                                      '') {
                                                return ClipOval(
                                                  child: Image.network(
                                                    '${post['author']['avatar']}',
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit
                                                        .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                                  ),
                                                );
                                              } else {
                                                return Image.asset(
                                                  'lib/src/assets/images/avatar.jpg',
                                                  width: 50,
                                                  height: 50,
                                                );
                                              }
                                            }(),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 8.0),
                                                        child: () {
                                                          if (post['author'] !=
                                                                  null &&
                                                              post['author'][
                                                                      'name'] !=
                                                                  null &&
                                                              post['author'][
                                                                      'name'] !=
                                                                  '') {
                                                            return Text(
                                                              post['author']
                                                                  ['name'],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            );
                                                          } else {
                                                            return const Text(
                                                              "Lỗi hiển thị username",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            );
                                                          }
                                                        }(),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 5.0,
                                                            bottom: 6.0),
                                                        child: Image.asset(
                                                          'lib/src/assets/images/tich_xanh.png',
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 16.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        formatTimeDifference(
                                                            post['created']),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 3.0,
                                                            top: 2.0),
                                                        child: const Icon(
                                                          Icons.public,
                                                          size: 12.0,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          const Spacer(),
                                          // dùng cái này để icon xuống phía bên phải cùng của row
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  splashRadius: 20,
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                height: 4,
                                                                width: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => ReportPage(postId: int.parse(post['id']))));
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          tileColor:
                                                                              Colors.white,
                                                                          minLeadingWidth:
                                                                              10,
                                                                          titleAlignment:
                                                                              ListTileTitleAlignment.center,
                                                                          leading:
                                                                              const Icon(
                                                                            Icons.report,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          title:
                                                                              const Text(
                                                                            'Báo cáo bài viết',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          topLeft:
                                                                              Radius.circular(10),
                                                                          topRight:
                                                                              Radius.circular(10),
                                                                        ),
                                                                        child:
                                                                            const ListTile(
                                                                          titleAlignment:
                                                                              ListTileTitleAlignment.center,
                                                                          tileColor:
                                                                              Colors.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                            ),
                                                                          ),
                                                                          minLeadingWidth:
                                                                              10,
                                                                          leading:
                                                                              Icon(
                                                                            Icons.add_circle_rounded,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          title:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Hiển thị thêm',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                'Bạn sẽ nhìn thấy nhiều bài viết tương tự hơn.',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            const BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(10),
                                                                          bottomRight:
                                                                              Radius.circular(10),
                                                                        ),
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            const ListTile(
                                                                          titleAlignment:
                                                                              ListTileTitleAlignment.center,
                                                                          tileColor:
                                                                              Colors.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              bottomLeft: Radius.circular(10),
                                                                              bottomRight: Radius.circular(10),
                                                                            ),
                                                                          ),
                                                                          minLeadingWidth:
                                                                              10,
                                                                          leading:
                                                                              Icon(
                                                                            Icons.remove_circle,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          title:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Ẩn bớt',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                'Bạn sẽ nhìn thấy ít bài viết tương tự hơn.',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            ListTile(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          tileColor:
                                                                              Colors.white,
                                                                          minLeadingWidth:
                                                                              10,
                                                                          titleAlignment:
                                                                              ListTileTitleAlignment.center,
                                                                          leading:
                                                                              const Icon(
                                                                            Icons.file_copy_rounded,
                                                                            color:
                                                                                Colors.black,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                          title:
                                                                              const Text(
                                                                            'Sao chép liên kết',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            ListTile(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          tileColor:
                                                                              Colors.white,
                                                                          minLeadingWidth:
                                                                              10,
                                                                          titleAlignment:
                                                                              ListTileTitleAlignment.center,
                                                                          leading:
                                                                              const Icon(
                                                                            Icons.view_list_rounded,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          title:
                                                                              const Text(
                                                                            'Quản lý bảng feed',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.more_horiz_rounded),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    // Status
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, right: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(post['described'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16))
                                        ],
                                      ),
                                    ),

                                    //images of post
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    if (post['image'] != null &&
                                        post['image'].isNotEmpty)
                                      ..._splitImagesIntoPairs(post['image'])
                                          .map<Widget>((imagePair) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children:
                                              imagePair.map<Widget>((image) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 5.0),
                                              child: Image.network(
                                                '${image['url']}',
                                                height: 150,
                                                width: 150,
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      }),

                                    Material(
                                      color: const Color(0xFFF7E8E8),
                                      child: InkWell(
                                          onTap: () {
                                            // Navigator.pushNamed(context, CommentScreen.routeName,
                                            //     arguments: widget.post);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.0, top: 5.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 6.0,
                                                              top: 5.0),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'lib/src/assets/images/reactions/like.png',
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                          Image.asset(
                                                            'lib/src/assets/images/reactions/angry.png',
                                                            width: 20,
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                              (feel[int.parse(post[
                                                                              'id'] ??
                                                                          '0')] ??
                                                                      '0')
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16.0, top: 5.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 12.0),
                                                      child: Text(
                                                          "${post['mark_comment']} comments"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5.0),
                                      child: const Divider(
                                        color: Colors.black12,
                                        thickness: 1,
                                        height: 1,
                                        indent: 15,
                                        endIndent: 14,
                                      ),
                                    ),

                                    //options like comment share
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          child: InkWell(
                                            onTap: () async {
                                              String? token = await storage
                                                  .read(key: 'token');
                                              int postId =
                                                  int.parse(post['id'] ?? "");
                                              if (isFeltKudo
                                                      .containsKey(postId) &&
                                                  (isFeltKudo[postId] == '1' ||
                                                      isFeltKudo[postId] ==
                                                          '0')) {
                                                // xử lý delete feel
                                                try {
                                                  var url = Uri.parse(
                                                      ListAPI.deleteFeel);
                                                  Map body = {"id": '$postId'};
                                                  http.Response response =
                                                      await http.post(
                                                    url,
                                                    headers: {
                                                      'Content-Type':
                                                          'application/json',
                                                      'Authorization':
                                                          'Bearer $token'
                                                    },
                                                    body: jsonEncode(body),
                                                  );

                                                  //cập nhật lại trạng thái của isFeltKudo
                                                  setState(() {
                                                    isFeltKudo[postId] = '-1';
                                                    feel[postId] =
                                                        (feel[postId]! - 1)!;
                                                  });

                                                  // Chuyển chuỗi JSON thành một đối tượng Dart
                                                  var responseBody =
                                                      jsonDecode(response.body);
                                                  print(responseBody);
                                                } catch (e) {
                                                  print('Error: $e');
                                                }
                                              } else {
                                                // xử lý set feel kudo
                                                try {
                                                  var url =
                                                      Uri.parse(ListAPI.feel);
                                                  Map body = {
                                                    "id": '$postId',
                                                    "type": "1"
                                                  };
                                                  http.Response response =
                                                      await http.post(
                                                    url,
                                                    headers: {
                                                      'Content-Type':
                                                          'application/json',
                                                      'Authorization':
                                                          'Bearer $token'
                                                    },
                                                    body: jsonEncode(body),
                                                  );

                                                  // Chuyển chuỗi JSON thành một đối tượng Dart
                                                  var responseBody =
                                                      jsonDecode(response.body);
                                                  print(responseBody);

                                                  if (responseBody['code'] ==
                                                      '1000') {
                                                    //cập nhật lại trạng thái của isFeltKudo
                                                    setState(() {
                                                      isFeltKudo[postId] = '1';
                                                      feel[postId] =
                                                          (feel[postId]! + 1)!;
                                                    });
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Thông báo'),
                                                          content: Text(
                                                              '${responseBody['message']}'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                BuyCoins()));
                                                              },
                                                              child: const Text(
                                                                'MUA COINS',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'OK',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                } catch (e) {
                                                  print('Error: $e');
                                                }
                                              }
                                            },
                                            onLongPress: () {
                                              // Xử lý khi nhấn giữ nút like
                                              showReactionMenu(context,
                                                  int.parse(post['id']));
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: () {
                                                    int postId = int.parse(
                                                        post['id'] ?? "");
                                                    if (isFeltKudo.containsKey(
                                                            postId) &&
                                                        isFeltKudo[postId] ==
                                                            '-1') {
                                                      return Image.asset(
                                                        'lib/src/assets/images/like.png',
                                                        width: 20,
                                                        height: 20,
                                                      );
                                                    } else if (isFeltKudo
                                                            .containsKey(
                                                                postId) &&
                                                        isFeltKudo[postId] ==
                                                            '0') {
                                                      return Image.asset(
                                                        'lib/src/assets/images/reactions/angry.png',
                                                        width: 20,
                                                        height: 20,
                                                      );
                                                    } else {
                                                      return Image.asset(
                                                        'lib/src/assets/images/reactions/like.png',
                                                        width: 20,
                                                        height: 20,
                                                      );
                                                    }
                                                  }(),
                                                ),
                                                () {
                                                  int postId = int.parse(
                                                      post['id'] ?? "");
                                                  if (isFeltKudo.containsKey(
                                                          postId) &&
                                                      isFeltKudo[postId] ==
                                                          '-1') {
                                                    return const Text(
                                                      "Like",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    );
                                                  } else if (isFeltKudo
                                                          .containsKey(
                                                              postId) &&
                                                      isFeltKudo[postId] ==
                                                          '0') {
                                                    return const Text(
                                                      "Phẫn nộ",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16),
                                                    );
                                                  } else {
                                                    return const Text(
                                                      "Like",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16),
                                                    );
                                                  }
                                                }(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          child: InkWell(
                                            onTap: () {
                                              print("I commented this post");
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'lib/src/assets/images/comment.png'),
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                                const Text(
                                                  "Comment",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10.0),
                                          child: InkWell(
                                            onTap: () {
                                              print("I shared this post");
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
                                                  child: const Image(
                                                    image: AssetImage(
                                                        'lib/src/assets/images/share.png'),
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                                const Text(
                                                  "Share",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20.0),
                                      child: const Divider(
                                        height: 1,
                                        color: Colors.black12,
                                        thickness: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList()
                  : [
                      const Center(
                        child: Text("Không tìm thấy bài viết nào phù hợp!"),
                      )
                    ],
            ),
          ]),
        ),
      ),
    );
  }

  //xử lý hiển thị thời gian đăng của post
  String formatTimeDifference(String createdAt) {
    DateTime createdDateTime = DateTime.parse(createdAt);
    Duration difference = DateTime.now().difference(createdDateTime);

    if (difference.inDays > 7) {
      return DateFormat('dd/MM/yyyy').format(createdDateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  // xử lý hiển thị ảnh của post
  List<List<Map<String, dynamic>>> _splitImagesIntoPairs(List<dynamic> images) {
    List<List<Map<String, dynamic>>> imagePairs = [];
    for (int i = 0; i < images.length; i += 2) {
      int endIndex = i + 2;
      if (endIndex > images.length) {
        endIndex = images.length;
      }
      imagePairs.add(images.sublist(i, endIndex).cast<Map<String, dynamic>>());
    }
    return imagePairs;
  }
}
