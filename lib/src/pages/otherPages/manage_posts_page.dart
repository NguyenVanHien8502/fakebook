import 'dart:convert';
import 'package:fakebook/src/api/api.dart';

import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/edit_post_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
    // getListFeels();
  }


  //get list post
  var listPosts = [];
  var listPostId=[];

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

  //get list feel
  var listFeels = [];
  dynamic userId;

  // Future<void> getListFeels() async {
  //   String? token = await storage.read(key: 'token');
  //   dynamic currentUser = await storage.read(key: 'currentUser');
  //   userId = jsonDecode(currentUser)['id'];
  //   dynamic responseBody;
  //   try {
  //     var url = Uri.parse(ListAPI.getListFeels);
  //     Map body = {"id": widget.postId, "index": "0", "count": "10"};
  //
  //     http.Response response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token'
  //       },
  //       body: jsonEncode(body),
  //     );
  //
  //     // Chuyển chuỗi JSON thành một đối tượng Dart
  //     responseBody = jsonDecode(response.body);
  //     // print(responseBody['data']);
  //     setState(() {
  //       listFeels = responseBody['data'];
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  bool isClickedLike = false;
  bool isLongPress = false;
  String selectedReaction = '';

  dynamic isFeltKudo;

  bool isFelt() {
    for (var i = 0; i < listFeels.length; i++) {
      if (listFeels[i]['feel']['user']['id'] == userId) {
        isFeltKudo = listFeels[i]['feel']['type'] == '0' ? '0' : '1';
        return true;
      }
    }
    return false;
  }

// Hàm hiển thị menu tùy chọn
//   void showReactionMenu(BuildContext context) {
//     showMenu(
//       context: context,
//       position: const RelativeRect.fromLTRB(-80, 315, 0, 0),
//       elevation: 0,
//       // Đặt độ nâng của PopupMenu để loại bỏ border
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0), // Đặt độ cong của border
//       ),
//       color: Colors.transparent,
//       // color: Colors.blue,
//       items: [
//         PopupMenuItem<String>(
//           padding: const EdgeInsets.all(0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               PopupMenuItem<String>(
//                 padding: const EdgeInsets.all(0),
//                 value: '1',
//                 child: Image.asset(
//                   'lib/src/assets/images/reactions/like.png',
//                   width: 30,
//                   height: 30,
//                 ),
//               ),
//               PopupMenuItem<String>(
//                 padding: const EdgeInsets.all(0),
//                 value: '0',
//                 child: Image.asset(
//                   'lib/src/assets/images/reactions/angry.png',
//                   width: 30,
//                   height: 30,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ).then((value) async {
//       if (value != null) {
//         setState(() {
//           selectedReaction = value;
//           isFeltKudo = value == '1' ? '1' : '0';
//         });
//         // Thực hiện các hành động tương ứng
//         String? token = await storage.read(key: 'token');
//         try {
//           var url = Uri.parse(ListAPI.feel);
//           Map body = {"id": widget.postId, "type": value};
//           http.Response response = await http.post(
//             url,
//             headers: {
//               'Content-Type': 'application/json',
//               'Authorization': 'Bearer $token'
//             },
//             body: jsonEncode(body),
//           );
//
//           // Chuyển chuỗi JSON thành một đối tượng Dart
//           var responseBody = jsonDecode(response.body);
//           print(responseBody);
//         } catch (e) {
//           print('Error: $e');
//         }
//       }
//     });
//   }


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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Text(
                                          formatTimeDifference(post['created']),
                                          style: const TextStyle(
                                              color: Colors.black),
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
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext context) {
                                                                return AlertDialog(
                                                                  title: const Text('Xóa bài viết?'),
                                                                  content: const Text('Bạn có thể chỉnh sửa bài viết nếu cần thay đổi.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        handleDeletePost(
                                                                            context,
                                                                            post['id']);
                                                                      },
                                                                      child: const Text(
                                                                        'Xóa',
                                                                        style: TextStyle(color: Colors.blue, fontSize: 14),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                (context) =>
                                                                                EditPostPage(
                                                                                  postId: int
                                                                                      .parse(post[
                                                                                  'id']),
                                                                                ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child: const Text(
                                                                        'Chỉnh sửa',
                                                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: const Text(
                                                                        'Hủy',
                                                                        style: TextStyle(color: Colors.black, fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
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
                          children: [
                            Text(post['described'],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16))
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
                                      left: 10.0, top: 5.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 6.0, top: 5.0),
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
                                              child: Text(
                                                (int.parse(post['feel'] ?? '0'))
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.black, fontSize: 16),
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
                                            const EdgeInsets.only(right: 12.0),
                                        child: Text("${post['comment_mark']} comments"),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                // Xử lý khi nhấn nút like (không nhấn giữ)
                                if (isLongPress == false) {
                                  setState(() {
                                    isClickedLike = !isClickedLike;
                                    selectedReaction = isClickedLike ? '1' : '0';
                                  });
                                }
                                // if (selectedReaction != '') {
                                //   setState(() {
                                //     selectedReaction = '';
                                //   });
                                // }
                              },
                              onLongPress: () {
                                // Xử lý khi nhấn giữ nút like
                                setState(() {
                                  isLongPress = true;
                                });
                                // showReactionMenu(context);
                              },
                              onLongPressEnd: (_) {
                                // Khi nhấn giữ kết thúc, cập nhật giá trị và ẩn menu
                                setState(() {
                                  isLongPress = false;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                      isFelt()
                                          ? (isFeltKudo == '1'
                                          ? ('lib/src/assets/images/reactions/like.png')
                                          : ('lib/src/assets/images/reactions/angry.png'))
                                          : (selectedReaction != ''
                                          ? (selectedReaction == '1'
                                          ? 'lib/src/assets/images/reactions/like.png'
                                          : 'lib/src/assets/images/reactions/angry.png')
                                          : 'lib/src/assets/images/like.png'),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  Text(
                                    isFelt()
                                        ? (isFeltKudo == '1' ? ('Like') : ('Phẫn nộ'))
                                        : (selectedReaction != ''
                                        ? (selectedReaction == '1'
                                        ? 'Like'
                                        : 'Phẫn nộ')
                                        : 'Like'),
                                    style: TextStyle(
                                        color: isFelt()
                                            ? (isFeltKudo == '1'
                                            ? (Colors.blue)
                                            : (Colors.green))
                                            : (selectedReaction != ''
                                            ? (selectedReaction == '1'
                                            ? Colors.blue
                                            : Colors.green)
                                            : Colors.black),
                                        fontSize: 16),
                                  )
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
