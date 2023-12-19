import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/notification/single_notification.dart';
import 'package:fakebook/src/model/feel.dart';
import 'package:fakebook/src/model/noti.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static double offset = 0;
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Noti> notifications = [];

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> fetchNotificationList(BuildContext context) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getNotification);
        Map body = {"index": "0", "count": "10"};

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
            final List<dynamic> friendsData = responseBody['data'];

            setState(() {
              notifications = friendsData.map((item) {
                final createdDateTime = DateTime.parse(item['created']);
                final now = DateTime.now();
                final difference = now.difference(createdDateTime);
                String textTitle = '${item['user']['username']}';
                if (item['type'] == '1') {
                  textTitle =
                      '${item['user']['username']} đã gửi cho bạn lời mời kết bạn';
                }
                if (item['type'] == '2') {
                  textTitle =
                      '${item['user']['username']} đã chấp nhận lời mời kết bạn';
                }
                if (item['type'] == '3') {
                  textTitle =
                      '${item['user']['username']} đã thêm bài viết mới';
                }
                if (item['type'] == '5') {
                  textTitle =
                      '${item['user']['username']} đã bày tỏ cảm xúc về bài viết của bạn';
                }
                if (item['type'] == '6') {
                  textTitle =
                      '${item['user']['username']} đã bình luận bài viết của bạn';
                }
                if (item['type'] == '9') {
                  textTitle =
                      '${item['user']['username']} đã trả lời một bình luận trong bài viết của bạn';
                }

                return Noti(
                  type: item['type'].toString() ?? '5',
                  object_id: item['object_id'] ?? '36',
                  title: textTitle,
                  noti_id: item['noti_id'] ?? "36",
                  created: formatDuration(difference) ?? 'vừa xong',
                  avatar:
                      item['avatar'] ?? 'lib/src/assets/images/avatarfb.jpg',
                  read: item['read'] ?? '0',
                  group: item['group'] ?? 0,
                  bold: item['user']['username'] ?? 'name',
                  user: User(
                    id: item['user']['id'] ?? '36',
                    name: item['user']['name'] ?? 'name',
                    avatar: item['user']['avatar'] ??
                        'lib/src/assets/images/avatarfb.jpg',
                  ),
                  feels: Feels(
                      fellId:
                          item['feel'] != null ? item['feel']['feel_id'] : '1',
                      type: item['feel'] != null ? item['feel']['type'] : '1'),
                  idPost: item['post'] != null ? item['post']['id'] : '1',
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

  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} ngày trước';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} giờ trước';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} phút trước';
    } else {
      return 'vừa xong';
    }
  }

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NotificationScreen.offset);
  ScrollController headerScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    fetchNotificationList(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          NotificationScreen.offset);
      NotificationScreen.offset = scrollController.offset;
    });
    return Scaffold(
      body: NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 50,
            titleSpacing: 0,
            pinned: true,
            floating: true,
            primary: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox()),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: const Text(
                      'Thông báo',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
            ),
          )
        ],
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: notifications
                .map((e) => SingleNotification(notification: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
