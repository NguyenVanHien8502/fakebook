import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DetailPostPage extends StatefulWidget {
  final int postId;

  const DetailPostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  DetailPostPageState createState() => DetailPostPageState();
}

class DetailPostPageState extends State<DetailPostPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getPost();
  }

  var post = {};

  Future<void> getPost() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getPost);
      Map body = {
        "id": widget.postId
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
      print(responseBody['data']);
      setState(() {
        post = responseBody['data'];
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
        // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
        title: const Text(
          "Bài viết",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Search");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                    margin: const EdgeInsets.only(bottom: 8.0),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                            GestureDetector(
                              onTap: () {
                                print("Options");
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                child: const Icon(
                                  Icons.more_horiz,
                                  size: 22.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //status
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

                //image of post
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

                Container(
                  margin: const EdgeInsets.only(top: 14.0),
                  child: const Divider(
                    height: 1,
                    color: Colors.black12,
                    thickness: 1,
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
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
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
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
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
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14.0),
                  child: const Divider(
                    height: 1,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12.0, top: 5.0),
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
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: const Text("99"),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: const Text(
                          "Lê Văn Luyện và 98 người khác",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}