import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/comment/screens/comment_screen.dart';
import 'package:fakebook/src/features/newfeeds/post_card.dart';
import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/authPages/register_pages/save_info_login.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/edit_post_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ManagePostsPage extends StatefulWidget {
  const ManagePostsPage({Key? key}) : super(key: key);

  @override
  ManagePostsPageState createState() => ManagePostsPageState();
}

class ManagePostsPageState extends State<ManagePostsPage> {
  static const storage = FlutterSecureStorage();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getListPosts();
  }

  var listPosts = [];

  Future<void> getListPosts() async {
    String? token = await storage.read(key: 'token');
    dynamic currentUser = await storage.read(key: 'currentUser');
    dynamic userId = jsonDecode(currentUser)['id'];
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getListPosts);
      Map body = {
        "user_id": userId,
        "in_campaign": "1",
        "campaign_id": "1",
        "latitude": "1.0",
        "longitude": "1.0",
        // "last_id": "6",
        "index": "0",
        "count": "10"
      };

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      responseBody = jsonDecode(response.body);
      print(responseBody['data']['post']);
      setState(() {
        listPosts = responseBody['data']['post'] ?? [];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tất cả các bài viết của bạn",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: listPosts.map((post) {
              return Column(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPostPage(
                                        postId: int.parse(post['id']),
                                      )));
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 16.0, top: 16.0, bottom: 16.0),
                              child: ClipOval(
                                child: Image.network(
                                  '${post['author']['avatar']}',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit
                                      .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            post['author']['name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 5.0, bottom: 6.0),
                                          child: Image.asset(
                                            'lib/src/assets/images/tich_xanh.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "1 minute ago",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 3.0, top: 2.0),
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
                              margin: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                              color: Colors.grey[300],
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 4,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditPostPage(
                                                                  postId: int
                                                                      .parse(post[
                                                                          'id']),
                                                                  described: post[
                                                                      'described'],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: const ListTile(
                                                            titleAlignment:
                                                                ListTileTitleAlignment
                                                                    .center,
                                                            tileColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                            ),
                                                            minLeadingWidth: 10,
                                                            leading: Icon(
                                                              Icons.edit,
                                                              size: 30,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            title: Text(
                                                              'Chỉnh sửa bài viết',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                          onTap: () {
                                                            handleDeletePost(
                                                                context,
                                                                post['id']);
                                                          },
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: const ListTile(
                                                            titleAlignment:
                                                                ListTileTitleAlignment
                                                                    .center,
                                                            tileColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                            ),
                                                            minLeadingWidth: 10,
                                                            leading: Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              size: 30,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            title: Text(
                                                              'Xóa bài viết',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                    icon: const Icon(Icons.more_horiz_rounded),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // Status
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(post['described'],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14))
                          ],
                        ),
                      ),

                      //images of post
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (post['image'] != null && post['image'].isNotEmpty)
                        ..._splitImagesIntoPairs(post['image'])
                            .map<Widget>((imagePair) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imagePair.map<Widget>((image) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: Image.network(
                                  '${image['url']}',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                          );
                        }),

                      Material(
                        color: Colors.white,
                        child: InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, CommentScreen.routeName,
                              //     arguments: widget.post);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 16.0, top: 5.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'lib/src/assets/images/reactions/like.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'lib/src/assets/images/reactions/haha.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Image.asset(
                                        'lib/src/assets/images/reactions/love.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: const Text("99"),
                                      )
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
                                            const EdgeInsets.only(right: 6.0),
                                        child: const Text("123 comments"),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 6.0, right: 6.0),
                                        child: const Text(
                                          ".",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 16.0),
                                        child: const Text("456 shares"),
                                      )
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                print("I liked this post");
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 20.0,
                                    ),
                                  ),
                                  const Text(
                                    "Like",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                print("I commented this post");
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
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
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                print("I shared this post");
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
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
                                        color: Colors.black, fontSize: 16),
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
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future<void> handleDeletePost(BuildContext context, postId) async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.deletePost);
      Map body = {
        "id": postId,
      };

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      final responseBody = jsonDecode(response.body);
      if (responseBody['code'] == '1000') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Thông báo'),
              content: Text('Bạn đã xóa thành công!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagePostsPage(),
                      ),
                    );
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
}
