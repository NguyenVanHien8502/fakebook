import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:chewie/chewie.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  WatchPageState createState() => WatchPageState();
}

class WatchPageState extends State<WatchPage> {
  String status =
      "Sau khoảng thời gian trải qua những thử thách đầy cam go, bằng tài năng và sự nỗ lực của mình, các đội đã dần về đích và tiến gần hơn đến ngôi vị quán quân. Những dự án cộng đồng thiết thực, có tính đột phá đã nhận được những đánh giá  cao từ Ban giám khảo và khán giả của chương trình. ";
  int maxLength = 100; // Giới hạn độ dài của đoạn status
  bool isExpanded = false;
  String displayedStatus = "";

  late VideoPlayerController videoPlayerController;
  //late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    isExpanded = status.length <= maxLength;
    updateDisplayedStatus();

    // Đường dẫn đến video của bạn
    videoPlayerController =
        VideoPlayerController.asset('lib/src/assets/videos/video_watch.mp4');
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: false, // Bật tự động phát video khi mở trang
    //   looping: false, // Lặp lại video khi kết thúc
    //   allowFullScreen: true, // Cho phép chế độ toàn màn hình
    // );
  }

  void updateDisplayedStatus() {
    setState(() {
      displayedStatus = isExpanded ? status : status.substring(0, maxLength);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Thân xem video
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "Video",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.person, size: 30),
                            onPressed: () {
                              print("go to settings");
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          const Icon(Icons.search, size: 30),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                  thickness: 2,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("abc");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DetailPostPage()));
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 16.0, top: 16.0, bottom: 16.0),
                            child: const Image(
                              image: AssetImage(
                                  'lib/src/assets/images/avatar.jpg'),
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 16.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    child: const Text(
                                      "Lời thì thầm của đá",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )),
                              Container(
                                  margin: const EdgeInsets.only(left: 16.0),
                                  child: const Text(
                                    "1 day ago",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ],
                          ),
                          const Spacer(),
                          // dùng cái này để icon xuống phía bên phải cùng của row
                          Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("Blocked status");
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: const Icon(
                                      IconData(0x2716,
                                          fontFamily: 'MaterialIcons'),
                                      size: 20.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Options");
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, left: 8.0),
                                    child: const Icon(
                                      Icons.more_horiz,
                                      size: 30.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // Status
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: displayedStatus,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          if (!isExpanded) ...{
                            TextSpan(
                              text: ' Xem thêm...',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                    updateDisplayedStatus();
                                  });
                                },
                            ),
                          } else ...{
                            TextSpan(
                              text: ' Rút gọn',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                    updateDisplayedStatus();
                                  });
                                },
                            ),
                          },
                        ]),
                      ),
                    ),

                    // Video player
                    Container(
                      margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                      // child: Chewie(
                      //   controller: chewieController,
                      // ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.thumb_up,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.favorite,
                                size: 20.0,
                              ),
                              Text("99")
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 6.0),
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
                                margin: const EdgeInsets.only(right: 16.0),
                                child: const Text("456 shares"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
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
                      margin: const EdgeInsets.only(top: 30.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 4,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    //chewieController.dispose();
  }
}
