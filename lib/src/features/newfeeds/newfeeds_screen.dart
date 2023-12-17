import 'dart:convert';

import 'package:fakebook/src/components/widget/add_story_card.dart';
import 'package:fakebook/src/components/widget/story_card.dart';
import 'package:fakebook/src/features/newfeeds/post_card.dart';
import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/model/story.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        name: 'Doraemon',
        avatar: 'lib/src/assets/images/doraemon.jpg',
        type: 'page',
      ),
      image: ['lib/src/assets/images/1.jpg'],
      time: ['12 phút'],
      shareWith: 'public',
    ),
    Story(
      user: User(
          id: "36",
          name: 'Sách Cũ Ngọc',
          avatar: 'lib/src/assets/images/sachcungoc.jpg'),
      image: ['lib/src/assets/images/2.jpg'],
      time: ['3 giờ'],
      shareWith: 'friends',
    ),
    Story(
      user: User(
        id: "36",
        name: 'Vietnamese Argentina Football Fan Club (VAFFC)',
        avatar: 'lib/src/assets/images/vaffc.jpg',
        type: 'page',
      ),
      image: ['lib/src/assets/images/3.jpg'],
      time: ['5 giờ'],
      shareWith: 'friends-of-friends',
    ),
    Story(
      user: User(
          id: "36", name: 'Minh Hương', avatar: 'lib/src/images/minhhuong.jpg'),
      image: [
        'lib/src/assets/images/4.jpg',
        'lib/src/assets/images/5.jpg',
        'lib/src/assets/images/6.jpg',
        'lib/src/assets/images/7.jpg',
      ],
      video: ['lib/src/assets/images/4.mp4', 'lib/src/assets/images/4.mp4'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
    Story(
      user: User(
          id: "36", name: 'Khánh Vy', avatar: 'lib/src/images/khanhvy.jpg'),
      video: ['lib/src/assets/images/4.mp4'],
      time: ['1 phút'],
      shareWith: 'friends',
    ),
  ];

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NewfeedsScreen.offset);

  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).user;
    scrollController.addListener(() {
      if (widget.parentScrollController.hasClients) {
        widget.parentScrollController.jumpTo(
            widget.parentScrollController.offset +
                scrollController.offset -
                NewfeedsScreen.offset);
        NewfeedsScreen.offset = scrollController.offset;
      }
    });
    return SingleChildScrollView(
      controller: scrollController,
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
                          image: AssetImage('lib/src/assets/images/avatar.jpg'),
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

          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        ],
      ),
    );
  }
}
