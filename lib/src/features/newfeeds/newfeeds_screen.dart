import 'dart:convert';

import 'package:fakebook/src/components/widget/add_story_card.dart';
import 'package:fakebook/src/components/widget/story_card.dart';
import 'package:fakebook/src/model/story.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/buy_coins.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:fakebook/src/pages/otherPages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class NewfeedsScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;

  const NewfeedsScreen({super.key, required this.parentScrollController});

  @override
  State<NewfeedsScreen> createState() => _NewfeedsScreenState();
}

class _NewfeedsScreenState extends State<NewfeedsScreen> {
  Color colorNewPost = Colors.transparent;

  final stories = [
    Story(
      user: User(
          id: "36",
          name: 'Nguyễn Văn Hiển',
          avatar: 'lib/src/assets/images/hien.jpg'),
      image: ['lib/src/assets/images/2.jpg'],
      time: ['3 giờ'],
      shareWith: 'friends',
    ),
    Story(
      user: User(
        id: "36",
        name: 'Đỗ Minh Nghĩa',
        avatar: 'lib/src/assets/images/nghia.jpg',
        type: 'page',
      ),
      image: ['lib/src/assets/images/nghia2.jpg'],
      time: ['5 giờ'],
      shareWith: 'friends-of-friends',
    ),
    Story(
      user: User(
          id: "36",
          name: 'Ngoc Linh',
          avatar: 'lib/src/assets/images/linh.jpg'),
      image: [
        'lib/src/assets/images/linh2.jpg',
        'lib/src/assets/images/linh3.jpg',
        'lib/src/assets/images/linh4.jpg',
        'lib/src/assets/images/linh.jpg',
      ],
      video: ['lib/src/assets/images/4.mp4', 'lib/src/assets/images/4.mp4'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
    Story(
      user: User(
        id: "36",
        name: 'Doraemon',
        avatar: 'lib/src/assets/images/vinh.jpg',
        type: 'page',
      ),
      image: ['lib/src/assets/images/vinh2.jpg'],
      time: ['12 phút'],
      shareWith: 'public',
    ),
    Story(
      user: User(
          id: "36", name: 'Bá Duy', avatar: 'lib/src/assets/images/duy.jpg'),
      image: ['lib/src/assets/images/vinh3.jpg'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
  ];

  static const storage = FlutterSecureStorage();

  Map<int, bool> postVisible = {};

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
    getListPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerControllers.forEach((key, videoPlayerController) {
      videoPlayerController.dispose();
    });
  }

  //xử lý video
  Map<int, VideoPlayerController> videoPlayerControllers = {};
  Map<int, Future<void>> initializeVideoPlayerFutures = {};

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  //get list post
  var listPosts = [];
  int followLastId = 0;
  int lastId = 0;
  int index = 0;
  int count = 10;

  Future<void> getListPosts() async {
    String? token = await storage.read(key: 'token');
    dynamic currentUser = await storage.read(key: 'currentUser');
    dynamic userId = jsonDecode(currentUser)['id'];
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getListPosts);
      Map body = {
        //"user_id": userId,
        "in_campaign": "1",
        "campaign_id": "1",
        "latitude": "1.0",
        "longitude": "1.0",
        "last_id": '$lastId',
        "index": "$index",
        "count": "$count"
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
        followLastId = int.parse(responseBody['data']['last_id']);
        listPosts.addAll(responseBody['data']['post'] ?? []);
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
          postVisible[postId] = true;
          feel[postId] = feelOfPost;

          //set state cho video
          if (listPosts[i]['video'] != null &&
              listPosts[i]['video']['url'] != null) {
            var videoUrl = Uri.parse(listPosts[i]['video']['url']);
            videoPlayerControllers[postId] =
                VideoPlayerController.networkUrl(videoUrl);
            initializeVideoPlayerFutures[postId] =
                videoPlayerControllers[postId]!.initialize();
            videoPlayerControllers[postId]?.setLooping(true);
          }
        });
      }
    } catch (e) {
      print('Error: $e');
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

  //xử lý pull down to refresh data
  Future<void> _loadResources(bool reload) async {
    print('Start reloading ...');
    try {
      await getListPosts();
      print('Reloaded successfully.');
    } catch (e) {
      print('Error reload: $e');
    }
  }

  //xử lý pull up to load more data
  final ScrollController _scrollController = ScrollController();

  Future<bool> _loadMore() async {
    print("Start Loading More");
    try {
      setState(() {
        lastId = followLastId;
      });
      await Future.delayed(const Duration(seconds: 1, milliseconds: 100));
      await getListPosts();
      print("Loaded More Successfully");
      return true;
    } catch (e) {
      print('Error load more: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadResources(true);
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            //Header NewFeedsScreen
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentUser != null
                      ? Container(
                          margin: const EdgeInsets.only(right: 6.0),
                          child: ClipOval(
                            child: Image.network(
                              '${jsonDecode(currentUser)['avatar']}',
                              height: 50,
                              width: 50,
                              fit: BoxFit
                                  .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(right: 6.0),
                          child: const Image(
                            image:
                                AssetImage('lib/src/assets/images/avatar.jpg'),
                            height: 50,
                            width: 50,
                          ),
                        ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostPage()));
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black12,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: colorNewPost,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text('Bạn đang nghĩ gì?'),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Colors.black12,
              thickness: 5,
            ),

            //Story
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: AddStoryCard(),
                  ),
                  ...stories
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: StoryCard(story: e),
                          ))
                      .toList()
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 5,
              color: Colors.black26,
            ),

            // List posts
            Column(
              children:
                  listPosts.where((post) => post['id'] != null).map((post) {
                return Column(
                  children: <Widget>[
                    () {
                      int postId = int.parse(post['id']);
                      if (postVisible[postId] == true) {
                        return Column(
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OtherPersonalPageScreen(
                                                  userId: post['author']['id']),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 16.0, top: 16.0, bottom: 16.0),
                                      child: () {
                                        if (post['author']['avatar'] != '') {
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
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Text(
                                                  post['author']['name'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                          margin:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                formatTimeDifference(
                                                    post['created']),
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
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                    ),
                                                    color: Colors.grey[300],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                          color: Colors.grey,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ReportPage(postId: int.parse(post['id']))));
                                                                },
                                                                child: ListTile(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  tileColor:
                                                                      Colors
                                                                          .white,
                                                                  minLeadingWidth:
                                                                      10,
                                                                  titleAlignment:
                                                                      ListTileTitleAlignment
                                                                          .center,
                                                                  leading:
                                                                      const Icon(
                                                                    Icons
                                                                        .report,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  title:
                                                                      const Text(
                                                                    'Báo cáo bài viết',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {},
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                child:
                                                                    const ListTile(
                                                                  titleAlignment:
                                                                      ListTileTitleAlignment
                                                                          .center,
                                                                  tileColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  minLeadingWidth:
                                                                      10,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .add_circle_rounded,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  title: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Hiển thị thêm',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'Bạn sẽ nhìn thấy nhiều bài viết tương tự hơn.',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black54,
                                                                          fontSize:
                                                                              14,
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
                                                              child: InkWell(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                onTap: () {},
                                                                child:
                                                                    const ListTile(
                                                                  titleAlignment:
                                                                      ListTileTitleAlignment
                                                                          .center,
                                                                  tileColor:
                                                                      Colors
                                                                          .white,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  minLeadingWidth:
                                                                      10,
                                                                  leading: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  title: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Ẩn bớt',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        'Bạn sẽ nhìn thấy ít bài viết tương tự hơn.',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                onTap: () {},
                                                                child: ListTile(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  tileColor:
                                                                      Colors
                                                                          .white,
                                                                  minLeadingWidth:
                                                                      10,
                                                                  titleAlignment:
                                                                      ListTileTitleAlignment
                                                                          .center,
                                                                  leading:
                                                                      const Icon(
                                                                    Icons
                                                                        .file_copy_rounded,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 30,
                                                                  ),
                                                                  title:
                                                                      const Text(
                                                                    'Sao chép liên kết',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                onTap: () {},
                                                                child: ListTile(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  tileColor:
                                                                      Colors
                                                                          .white,
                                                                  minLeadingWidth:
                                                                      10,
                                                                  titleAlignment:
                                                                      ListTileTitleAlignment
                                                                          .center,
                                                                  leading:
                                                                      const Icon(
                                                                    Icons
                                                                        .view_list_rounded,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  title:
                                                                      const Text(
                                                                    'Quản lý bảng feed',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16,
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
                                        GestureDetector(
                                          onTap: () {
                                            int postId =
                                                int.parse(post['id'] ?? "");
                                            setState(() {
                                              postVisible[postId] = false;
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 8.0),
                                            child: const Icon(
                                              Icons.close,
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

                            // Status
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
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
                            if (post['image'] != null &&
                                post['image'].isNotEmpty)
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
                                      ),
                                    );
                                  }).toList(),
                                );
                              }),

                            //video of post
                            () {
                              if (post['video'] != null &&
                                  post['video'].isNotEmpty &&
                                  post['video']['url'] != null &&
                                  post['video']['url'].isNotEmpty) {
                                return FutureBuilder(
                                  future: initializeVideoPlayerFutures[
                                      int.parse(post['id'])],
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.yellow,
                                        ),
                                      );
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        print(
                                            "Lỗi khởi tạo trình phát video: ${snapshot.error}");
                                        // return const Text("Lỗi khởi tạo trình phát video");
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        );
                                      }

                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            height: 400,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: AspectRatio(
                                              aspectRatio:
                                                  videoPlayerControllers[
                                                          int.parse(
                                                              post['id'])]!
                                                      .value
                                                      .aspectRatio,
                                              child: VideoPlayer(
                                                  videoPlayerControllers[
                                                      int.parse(post['id'])]!),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                videoPlayerControllers[
                                                            int.parse(
                                                                post['id'])]!
                                                        .value
                                                        .isPlaying
                                                    ? videoPlayerControllers[
                                                            int.parse(
                                                                post['id'])]!
                                                        .pause()
                                                    : videoPlayerControllers[
                                                            int.parse(
                                                                post['id'])]!
                                                        .play();
                                              });
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                              ),
                                              child: Icon(
                                                videoPlayerControllers[
                                                            int.parse(
                                                                post['id'])]!
                                                        .value
                                                        .isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                size: 60.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(); // Hoặc một widget khác khi không có video
                              }
                            }(),

                            //số lượng cảm xúc và comment
                            Material(
                              color: Colors.white,
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
                                              margin: const EdgeInsets.only(
                                                  left: 6.0, top: 5.0),
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
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      (feel[int.parse(
                                                                  post['id'] ??
                                                                      '0')] ??
                                                              '0')
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black,
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
                                              margin: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Text(
                                                  "${post['comment_mark']} comments"),
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
                                  child: InkWell(
                                    onTap: () async {
                                      String? token =
                                          await storage.read(key: 'token');
                                      int postId = int.parse(post['id'] ?? "");
                                      if (isFeltKudo.containsKey(postId) &&
                                          (isFeltKudo[postId] == '1' ||
                                              isFeltKudo[postId] == '0')) {
                                        // xử lý delete feel
                                        try {
                                          var url =
                                              Uri.parse(ListAPI.deleteFeel);
                                          Map body = {"id": '$postId'};
                                          http.Response response =
                                              await http.post(
                                            url,
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                              'Authorization': 'Bearer $token'
                                            },
                                            body: jsonEncode(body),
                                          );

                                          //cập nhật lại trạng thái của isFeltKudo
                                          setState(() {
                                            isFeltKudo[postId] = '-1';
                                            feel[postId] = (feel[postId]! - 1)!;
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
                                          var url = Uri.parse(ListAPI.feel);
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
                                              'Authorization': 'Bearer $token'
                                            },
                                            body: jsonEncode(body),
                                          );

                                          // Chuyển chuỗi JSON thành một đối tượng Dart
                                          var responseBody =
                                              jsonDecode(response.body);
                                          print(responseBody);
                                          if (responseBody['code'] == '1000') {
                                            //cập nhật lại trạng thái của isFeltKudo
                                            setState(() {
                                              isFeltKudo[postId] = '1';
                                              feel[postId] =
                                                  (feel[postId]! + 1)!;
                                            });
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text('Thông báo'),
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
                                                            color: Colors.blue,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
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
                                      showReactionMenu(
                                          context, int.parse(post['id']));
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          child: () {
                                            int postId =
                                                int.parse(post['id'] ?? "");
                                            if (isFeltKudo
                                                    .containsKey(postId) &&
                                                isFeltKudo[postId] == '-1') {
                                              return Image.asset(
                                                'lib/src/assets/images/like.png',
                                                width: 20,
                                                height: 20,
                                              );
                                            } else if (isFeltKudo
                                                    .containsKey(postId) &&
                                                isFeltKudo[postId] == '0') {
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
                                          int postId =
                                              int.parse(post['id'] ?? "");
                                          if (isFeltKudo.containsKey(postId) &&
                                              isFeltKudo[postId] == '-1') {
                                            return const Text(
                                              "Like",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            );
                                          } else if (isFeltKudo
                                                  .containsKey(postId) &&
                                              isFeltKudo[postId] == '0') {
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
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("I commented this post");
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
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
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("I shared this post");
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 5),
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
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.visibility_off_rounded,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Đã ẩn',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Việc ẩn bài viết giúp Facebook cá nhân hóa Bảng feed của bạn.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      int postId = int.parse(post['id'] ?? "");
                                      setState(() {
                                        postVisible[postId] = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text(
                                      'Hoàn tác',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.black12,
                                thickness: 0.5,
                                height: 20,
                              ),
                              Row(
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black12,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'lib/src/assets/images/avatar.jpg'),
                                      radius: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Tạm ẩn bài viết này trong 30 ngày',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.report,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Báo cáo bài viết',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.view_list_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Quản lý Bảng feed',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: const Divider(
                                  height: 1,
                                  color: Colors.black12,
                                  thickness: 5,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }()
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
