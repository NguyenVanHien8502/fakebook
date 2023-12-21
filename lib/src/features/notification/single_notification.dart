import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/noti.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class SingleNotification extends StatefulWidget {
  final Noti notification;
  const SingleNotification({super.key, required this.notification});

  @override
  State<SingleNotification> createState() => _SingleNotificationState();
}

class _SingleNotificationState extends State<SingleNotification> {
  List<String> texts = [];
  String isFriend = '-1';

  Future<void> getInfoUser(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getUserInfo);
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

        if (response.statusCode == 201) {
          if (responseBody['code'] == '1000') {
            setState(() {
              isFriend = responseBody['data']['is_friend'];
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
    setState(() {
      texts = [];
      int s = 0;
      // if (widget.notification.bold != null) {
      //   for (int i = 0; i < widget.notification.bold!.length; i++) {
      //     int j =
      //         widget.notification.title.indexOf(widget.notification.bold![i]);
      //     texts.add(widget.notification.title.substring(s, j));
      //     texts.add(widget.notification.bold![i]);
      //     s = j + widget.notification.bold![i].length;
      //   }
      // }

      texts.add(widget.notification.title
          .substring(s, widget.notification.title.length));
    });
    getInfoUser(context, widget.notification.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (widget.notification.type == '1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtherPersonalPageScreen(
                    userId: widget.notification.user.id),
              ),
            );
          }
          if (widget.notification.type == '3' ||
              widget.notification.type == '5' ||
              widget.notification.type == '6' ||
              widget.notification.type == '9') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPostPage(
                  postId: int.parse(widget.notification.idPost),
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.notification.read == 1
                ? Colors.white.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
              bottom: 10,
              right: 0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //avatar thông báo + icon
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      //Avatar thông báo
                      DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.notification.avatar),
                          radius: 40,
                        ),
                      ),
                      //icon thông báo
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.notification.type ==
                                      '1' //lời mời kết bạn
                                  ? Colors.blue
                                  : widget.notification.type == '6' //Bình luận
                                      ? Colors.green[400]
                                      : widget.notification.type ==
                                              '9' //trả lời bình luận
                                          ? Colors.green[400]
                                          : widget.notification.type == 'group'
                                              ? Colors.blue
                                              : widget.notification.type ==
                                                      'security'
                                                  ? Colors.blue
                                                  : widget.notification.type ==
                                                          'date'
                                                      ? Colors.purple
                                                      : widget.notification
                                                                  .type ==
                                                              'badge'
                                                          ? Colors
                                                              .yellow.shade700
                                                          : Colors.white),
                          child: (widget.notification.type == 'memory')
                              ? const Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 30,
                                )
                              : (widget.notification.type ==
                                      '1') // Lời mời kết bạn
                                  ? const ImageIcon(
                                      AssetImage(
                                          'lib/src/assets/images/friends.png'),
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : (widget.notification.type ==
                                          '6') //Bình luận
                                      ? const ImageIcon(
                                          AssetImage(
                                              'lib/src/assets/images/white-cmt.png'),
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : (widget.notification.type ==
                                              '3') //Thêm bài viết mới
                                          ? const Icon(
                                              Icons.post_add,
                                              color: Colors.grey,
                                              size: 24,
                                            )
                                          : (widget.notification.type ==
                                                  '2') // chấp nhận lời mời kết bạn
                                              ? const Icon(
                                                  Icons.groups_rounded,
                                                  color: Colors.grey,
                                                  size: 24,
                                                )
                                              : (widget.notification.type ==
                                                      '9') // tra lời cmt
                                                  ? const ImageIcon(
                                                      AssetImage(
                                                          'lib/src/assets/images/white-cmt.png'),
                                                      color: Colors.white,
                                                      size: 16,
                                                    )
                                                  : (widget.notification.type ==
                                                          'date')
                                                      ? const Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color: Colors.white,
                                                          size: 20,
                                                        )
                                                      : (widget.notification
                                                                  .type ==
                                                              'badge')
                                                          ? const ImageIcon(
                                                              AssetImage(
                                                                'lib/src/assets/images/home.png',
                                                              ),
                                                              size: 18,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : (widget
                                                                      .notification
                                                                      .feels
                                                                      .type ==
                                                                  '1')
                                                              ? Image.asset(
                                                                  'lib/src/assets/images/reactions/like.png')
                                                              : (widget.notification
                                                                          .type ==
                                                                      'love')
                                                                  ? Image.asset(
                                                                      'lib/src/assets/images/reactions/love.png')
                                                                  : (widget.notification
                                                                              .type ==
                                                                          'haha')
                                                                      ? Image.asset(
                                                                          'lib/src/assets/images/reactions/haha.png')
                                                                      : (widget.notification.type ==
                                                                              'wow')
                                                                          ? Image.asset(
                                                                              'lib/src/assets/images/reactions/wow.png')
                                                                          : (widget.notification.type == 'lovelove')
                                                                              ? Image.asset('lib/src/assets/images/reactions/care.png')
                                                                              : (widget.notification.type == 'sad')
                                                                                  ? Image.asset('lib/src/assets/images/reactions/sad.png')
                                                                                  : (widget.notification.feels.type == '0')
                                                                                      ? Image.asset('lib/src/assets/images/reactions/angry.png')
                                                                                      : const Icon(
                                                                                          Icons.facebook,
                                                                                          color: Colors.blue,
                                                                                          size: 30,
                                                                                        ),
                        ),
                      )
                    ],
                  ),
                ),
                //Nội dung thông báo
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Thông báo nổi bật
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  height: 1.4),
                              children: texts
                                  .map(
                                    (e) => TextSpan(
                                      text: e,
                                      style: TextStyle(
                                        fontWeight:
                                            widget.notification.bold != null &&
                                                    widget.notification.bold!
                                                        .contains(e)
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                        ////
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            widget.notification.created,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        //
                        if (widget.notification.type == '1' && isFriend != '1')
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    accecptFriend(
                                        context, widget.notification.user.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  child: const Text(
                                    'Chấp nhận',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color.fromARGB(
                                          237, 219, 218, 218),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(5)),
                                  child: const Text(
                                    'Xóa',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
                          width: 4,
                        ),
                        if (isFriend == '1' && widget.notification.type == '1')
                          const Text(
                            'Các bạn đã là bạn bè!',
                            style: TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    padding: const EdgeInsets.all(5),
                    splashRadius: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> accecptFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.setAcceptFriend);
        Map body = {
          "user_id": id,
          "is_accept": "1",
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
            setState(() {
              isFriend = '1';
            });
            return print("Đã chấp nhận kết bạn");
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
