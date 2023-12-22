import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fakebook/src/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

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
    getListFeels();
    getMarkComment();
  }

  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _commentFocusNode.dispose();
    videoPlayerController.dispose();
  }

  //xử lý video
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  //get post
  var post = {};

  Future<void> getPost() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getPost);
      Map body = {"id": widget.postId};

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
        if (post['video'] != null && post['video']['url'] != null) {
          var videoUrl = Uri.parse(post['video']['url']);
          print(videoUrl);
          videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
          initializeVideoPlayerFuture = videoPlayerController.initialize();
          videoPlayerController.setLooping(true);
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // Xử lý ngày giờ đăng post, comment
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

  //get list feel
  var listFeels = [];
  dynamic userId;

  Future<void> getListFeels() async {
    String? token = await storage.read(key: 'token');
    dynamic currentUser = await storage.read(key: 'currentUser');
    userId = jsonDecode(currentUser)['id'];
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getListFeels);
      Map body = {"id": widget.postId, "index": "0", "count": "10"};

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
      // print(responseBody['data']);
      setState(() {
        listFeels = responseBody['data'];
        feel = listFeels.length;
      });
      dynamic isFelt = listFeels.firstWhere((element) {
        return element['feel']['user']['id'] == userId;
      }, orElse: () => null);
      if (isFelt == null) {
        setState(() {
          isFeltKudo = '-1';
        });
      } else {
        if (isFelt['feel']['type'] == '0') {
          setState(() {
            isFeltKudo = '0';
          });
        } else if (isFelt['feel']['type'] == '1') {
          setState(() {
            isFeltKudo = '1';
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  dynamic
      isFeltKudo; //-1, 0, 1 lần lượt là không bày tỏ cảm xúc, bày tỏ phẫn nộ và bày tỏ like
  dynamic feel;

// Hàm hiển thị menu tùy chọn
  void showReactionMenu(BuildContext context) {
    // Get the position of the button
    // RenderBox button = context.findRenderObject() as RenderBox;
    // Offset buttonPosition = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(-80, 315, 0, 0),
      // position: RelativeRect.fromLTRB(
      //   buttonPosition.dx,
      //   buttonPosition.dy + button.size.height+300,
      //   buttonPosition.dx + button.size.width,
      //   buttonPosition.dy + button.size.height, // Height of the menu
      // ),
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
        setState(() {
          if (isFeltKudo == '-1') {
            feel = feel + 1;
          }
          isFeltKudo = value == '1' ? '1' : '0';
        });
        // Thực hiện các hành động tương ứng
        String? token = await storage.read(key: 'token');
        try {
          var url = Uri.parse(ListAPI.feel);
          Map body = {"id": widget.postId, "type": value};
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
        } catch (e) {
          print('Error: $e');
        }
      }
    });
  }

  //xử lý phần get comment
  var markComment = [];

  Future<void> getMarkComment() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getMarkComment);
      Map body = {"id": widget.postId, "index": "0", "count": "10"};

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
      // print(responseBody['data']);
      setState(() {
        markComment = responseBody['data'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  //xử lý set comment
  bool isTextFieldFocusDirectly = false;
  int markId = -1;
  final TextEditingController contentController = TextEditingController();

  Future<void> handleSetMarkComment() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.setMarkComment);
      Map body = {};
      if (isTextFieldFocusDirectly) {
        body = {
          "id": widget.postId,
          "content": contentController.text,
          "index": "0",
          "count": "10",
          "type": "1"
        };
      } else {
        body = {
          "id": widget.postId,
          "content": contentController.text,
          "index": "0",
          "count": "10",
          "mark_id": '$markId'
        };
      }

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      contentController.clear();

      // Chuyển chuỗi JSON thành một đối tượng Dart
      responseBody = jsonDecode(response.body);
      print(responseBody['data']);
      setState(() {
        markComment = responseBody['data'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

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
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: () {
                          if (post['author'] != null &&
                              post['author']['avatar'] != null &&
                              post['author']['avatar'] != '') {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      post['author']?['name'] ??
                                          'Lỗi hiển thị username',
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
                                  Text(
                                    formatTimeDifference(post['created'] ??
                                        '2023-12-15T04:35:45.921Z'),
                                    style: const TextStyle(color: Colors.black),
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
                      Row(
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
                      )
                    ],
                  ),
                ),

                //status
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      Text(post['described'] ?? 'Lỗi hiển thị status',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16))
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),

                //image and video of post
                Column(
                  children: [
                    //image of post
                    if (post['image'] != null && post['image'].isNotEmpty)
                      ...post['image'].map((image) => Column(
                            children: [
                              Container(
                                color: const Color(0xFFFFF2EE),
                                child: Image.network(
                                  '${image['url']}',
                                  height: 200,
                                  width: w,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          )),

                    //video of post
                    () {
                      if (post['video'] != null &&
                          post['video'].isNotEmpty &&
                          post['video']['url'] != null &&
                          post['video']['url'].isNotEmpty) {
                        return FutureBuilder(
                          future: initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                print(
                                    "Lỗi khởi tạo trình phát video: ${snapshot.error}");
                                return const Text(
                                    "Lỗi khởi tạo trình phát video");
                              }

                              if (videoPlayerController.value.isInitialized) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      height: 400,
                                      width: MediaQuery.of(context).size.width,
                                      child: AspectRatio(
                                        aspectRatio: videoPlayerController
                                            .value.aspectRatio,
                                        child:
                                            VideoPlayer(videoPlayerController),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          videoPlayerController.value.isPlaying
                                              ? videoPlayerController.pause()
                                              : videoPlayerController.play();
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Icon(
                                          videoPlayerController.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 60.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text("Video is not initialized");
                              }
                            } else {
                              return const Text(
                                  "Loading..."); // Hoặc một widget khác khi video vẫn đang khởi tạo
                            }
                          },
                        );
                      } else {
                        return Container(); // Hoặc một widget khác khi không có video
                      }
                    }(),
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

                //options like comment share
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: InkWell(
                        onTap: () async {
                          String? token = await storage.read(key: 'token');
                          if (isFeltKudo == '1' || isFeltKudo == '0') {
                            // xử lý delete feel
                            try {
                              var url = Uri.parse(ListAPI.deleteFeel);
                              Map body = {"id": widget.postId};
                              http.Response response = await http.post(
                                url,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $token'
                                },
                                body: jsonEncode(body),
                              );

                              //cập nhật lại trạng thái của isFeltKudo
                              setState(() {
                                isFeltKudo = '-1';
                                feel = feel - 1;
                              });

                              // Chuyển chuỗi JSON thành một đối tượng Dart
                              var responseBody = jsonDecode(response.body);
                              print(responseBody);
                            } catch (e) {
                              print('Error: $e');
                            }
                          } else {
                            // xử lý set feel kudo
                            try {
                              var url = Uri.parse(ListAPI.feel);
                              Map body = {"id": widget.postId, "type": "1"};
                              http.Response response = await http.post(
                                url,
                                headers: {
                                  'Content-Type': 'application/json',
                                  'Authorization': 'Bearer $token'
                                },
                                body: jsonEncode(body),
                              );

                              //cập nhật lại trạng thái của isFeltKudo
                              setState(() {
                                isFeltKudo = '1';
                                feel = feel + 1;
                              });

                              // Chuyển chuỗi JSON thành một đối tượng Dart
                              var responseBody = jsonDecode(response.body);
                              print(responseBody);
                            } catch (e) {
                              print('Error: $e');
                            }
                          }
                        },
                        onLongPress: () {
                          // Xử lý khi nhấn giữ nút like
                          showReactionMenu(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: () {
                                if (isFeltKudo == '-1') {
                                  return Image.asset(
                                    'lib/src/assets/images/like.png',
                                    width: 20,
                                    height: 20,
                                  );
                                } else if (isFeltKudo == '0') {
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
                              if (isFeltKudo == '-1') {
                                return const Text(
                                  "Like",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                );
                              } else if (isFeltKudo == '0') {
                                return const Text(
                                  "Phẫn nộ",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                );
                              } else {
                                return const Text(
                                  "Like",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                );
                              }
                            }(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: InkWell(
                        onTap: () {
                          _commentFocusNode.requestFocus();
                          setState(() {
                            isTextFieldFocusDirectly = true;
                          });
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
                      child: InkWell(
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
                    ),
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

                //số lượng bày tỏ cảm xúc
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
                            'lib/src/assets/images/reactions/angry.png',
                            width: 20,
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: () {
                              if (feel != null) {
                                return Text(
                                  feel.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                );
                              }
                            }(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20.0,
                ),

                //comment part
                Column(
                  children: markComment
                      .map((markComment) => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        () {
                                          if (markComment['poster']['avatar'] !=
                                              '') {
                                            return ClipOval(
                                              child: Image.network(
                                                '${markComment['poster']['avatar']}',
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit
                                                    .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                              ),
                                            );
                                          } else {
                                            return Image.asset(
                                              'lib/src/assets/images/avatar.jpg',
                                              width: 40,
                                              height: 40,
                                            );
                                          }
                                        }(),
                                        const SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE8EBF5),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  // Màu của border
                                                  width:
                                                      0, // Độ rộng của border
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0), // Độ cong của góc
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14.0,
                                                      vertical: 3.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    markComment['poster']
                                                        ['name'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    markComment['mark_content'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    formatTimeDifference(
                                                        markComment[
                                                                'created'] ??
                                                            '2023-12-15T04:35:45.921Z'),
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 25.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _commentFocusNode
                                                          .requestFocus();
                                                      setState(() {
                                                        isTextFieldFocusDirectly =
                                                            false;
                                                        markId = int.parse(
                                                            markComment['id']);
                                                      });
                                                    },
                                                    child: const Text(
                                                      "Phản hồi",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Column(
                                      children: markComment['comments']
                                          .map<Widget>((comment) => Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 30.0,
                                                            right: 16.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        () {
                                                          if (comment['poster']
                                                                  ['avatar'] !=
                                                              '') {
                                                            return ClipOval(
                                                              child:
                                                                  Image.network(
                                                                '${comment['poster']['avatar']}',
                                                                height: 40,
                                                                width: 40,
                                                                fit: BoxFit
                                                                    .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                                              ),
                                                            );
                                                          } else {
                                                            return Image.asset(
                                                              'lib/src/assets/images/avatar.jpg',
                                                              width: 40,
                                                              height: 40,
                                                            );
                                                          }
                                                        }(),
                                                        const SizedBox(
                                                          width: 15.0,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFE8EBF5),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                    // Màu của border
                                                                    width:
                                                                        0, // Độ rộng của border
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0), // Độ cong của góc
                                                                ),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        3.0,
                                                                    horizontal:
                                                                        14.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      comment['poster']
                                                                          [
                                                                          'name'],
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          5.0,
                                                                    ),
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              16.0),
                                                                      child:
                                                                          Text(
                                                                        comment[
                                                                            'content'],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 15),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      formatTimeDifference(
                                                                          comment['created'] ??
                                                                              '2023-12-15T04:35:45.921Z'),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: contentController,
                      onTap: () {
                        setState(() {
                          isTextFieldFocusDirectly = true;
                        });
                      },
                      cursorColor: Colors.black,
                      focusNode: _commentFocusNode,
                      maxLines: null,
                      // giúp có thể xuống dòng khi nhập quá nhiều chữ trong textfield
                      decoration: InputDecoration(
                        hintText: 'Nhập mark/comment...',
                        contentPadding:
                            const EdgeInsets.only(left: 16, bottom: 12),
                        hintStyle: const TextStyle(color: Colors.blueGrey),
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      handleSetMarkComment();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Màu nền
                      onPrimary: Colors.white, // Màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Độ cong của góc
                      ),
                      elevation: 0.75, // Độ đổ bóng
                    ),
                    child: const Text(
                      "Gửi",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
