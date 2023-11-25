import 'package:fakebook/src/features/watch/watch_video.dart';
import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;

  const WatchScreen({super.key, required this.parentScrollController});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class VideoControllerWrapper {
  VideoPlayerController? value;
  VideoControllerWrapper(this.value);
}

class _WatchScreenState extends State<WatchScreen> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: WatchScreen.offset);
  ScrollController headerScrollController = ScrollController();
  int index = 0;
  List<VideoControllerWrapper> videoController = [];
  final posts = [
    Post(
      user: User(name: 'Aki Michio', avatar: 'lib/src/assets/images/avatar.jpg'),
      time: '14 thg 7, 2022',
      shareWith: 'public',
      content: 'Kawaiii quá vậy\nAnime : Con của mẹ kế là bạn gái cũ',
      like: 15000,
      angry: 3,
      comment: 210,
      haha: 3000,
      love: 1100,
      lovelove: 78,
      sad: 36,
      share: 98,
      wow: 18,
      video: ['lib/src/assets/images/4.mp4'],
    ),
    Post(
      user: User(
          name: 'Đài Phát Thanh.', avatar: 'lib/src/assets/images/avatar.jpg'),
      time: '17 thg 1, 2021',
      shareWith: 'public',
      content:
          'Bên anh đến khi già nếu anh cũng muốn ta cùng già ..\n-\nGià Cùng Anh Nếu Anh Cũng Muốn Già Cùng Em\nHIỀN MAI / Live Session…',
      like: 12000,
      angry: 1,
      comment: 902,
      haha: 21,
      love: 2100,
      lovelove: 67,
      sad: 20,
      share: 98,
      wow: 5,
      video: ['lib/src/assets/images/5.mp4'],
    ),
    Post(
      user: User(name: 'Spezon', avatar: 'lib/src/assets/images/avatar.jpg'),
      time: '27 tháng 8',
      shareWith: 'public',
      content: 'Lionel Messi World cup Champion [Messi EP. FINAL]',
      like: 4100,
      angry: 1,
      comment: 72,
      haha: 21,
      love: 888,
      lovelove: 100,
      sad: 20,
      share: 98,
      wow: 5,
      video: ['lib/src/assets/images/6.mp4'],
    ),
  ];
  List<GlobalKey> key = [];

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    for (int i = 0; i < videoController.length; i++) {
      videoController[i].value?.dispose();
    }
    super.dispose();
  }

  String status =
      "Sau khoảng thời gian trải qua những thử thách đầy cam go, bằng tài năng và sự nỗ lực của mình, các đội đã dần về đích và tiến gần hơn đến ngôi vị quán quân. Những dự án cộng đồng thiết thực, có tính đột phá đã nhận được những đánh giá  cao từ Ban giám khảo và khán giả của chương trình. ";
  int maxLength = 100; // Giới hạn độ dài của đoạn status
  bool isExpanded = false;
  String displayedStatus = "";

  @override
  void initState() {
    super.initState();
    isExpanded = status.length <= maxLength;
    updateDisplayedStatus();

    videoController =
        List.generate(posts.length, (index) => VideoControllerWrapper(null));
    key = List.generate(
        posts.length, (index) => GlobalKey(debugLabel: index.toString()));
  }

  void updateDisplayedStatus() {
    setState(() {
      displayedStatus = isExpanded ? status : status.substring(0, maxLength);
    });
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          WatchScreen.offset);
      WatchScreen.offset = scrollController.offset;
    });
    return Scaffold(
      body: NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 120,
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
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
                                Icons.person_rounded,
                                color: Colors.black,
                                size: 24,
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
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  index = 0;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: (index == 0)
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : const BoxDecoration(),
                                child: Text(
                                  'Dành cho bạn',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index == 0
                                        ? Colors.blue[800]
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  index = 1;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: (index == 1)
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : const BoxDecoration(),
                                child: Text(
                                  'Trực tiếp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index == 1
                                        ? Colors.blue[800]
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  index = 2;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: (index == 2)
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : const BoxDecoration(),
                                child: Text(
                                  'Chơi game',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index == 2
                                        ? Colors.blue[800]
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  index = 3;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: (index == 3)
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : const BoxDecoration(),
                                child: Text(
                                  'Reels',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index == 3
                                        ? Colors.blue[800]
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  index = 4;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: (index == 4)
                                    ? BoxDecoration(
                                        color: Colors.blue.withOpacity(0.1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                      )
                                    : const BoxDecoration(),
                                child: Text(
                                  'Đang theo dõi',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: index == 4
                                        ? Colors.blue[800]
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.black26,
                  ),
                  ...posts.asMap().entries.map((e) {
                    return Column(
                      children: [
                        WatchVideo(
                          post: e.value,
                          videoKey: key[e.key],
                          controller: videoController[e.key],
                          autoPlay: e.key == 0,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5,
                          color: Colors.black26,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
