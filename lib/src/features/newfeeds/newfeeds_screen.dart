import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NewfeedsScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;

  const NewfeedsScreen({super.key, required this.parentScrollController});

  @override
  State<NewfeedsScreen> createState() => _NewfeedsScreenState();
}

class _NewfeedsScreenState extends State<NewfeedsScreen> {
  Color colorNewPost = Colors.transparent;

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NewfeedsScreen.offset);

  @override
  void dispose() {
    scrollController.dispose();
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
  }

  void updateDisplayedStatus() {
    setState(() {
      displayedStatus = isExpanded ? status : status.substring(0, maxLength);
    });
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
          //Heder NewFeedsScreen
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("lib/src/assets/images/avatar.jpg"),
                    radius: 20,
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
                    // onTapUp: (tapUpDetails) {
                    //   setState(() {
                    //     colorNewPost = Colors.black12;
                    //   });
                    // },
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
          //
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          const SizedBox(
            height: 10,
          ),
          // start story

          // end story

          //start options
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    AntDesign.camera,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Live",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesome.photo,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Photo",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Check in",
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )
                ],
              )
            ],
          ),
          //end options
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
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPostPage()));
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
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
                                IconData(0x2716, fontFamily: 'MaterialIcons'),
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
                              margin:
                                  const EdgeInsets.only(top: 10.0, left: 8.0),
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
                      style: const TextStyle(color: Colors.black, fontSize: 16),
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

              //image of post
              Container(
                margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                child: const Image(
                  image: AssetImage('lib/src/assets/images/avatar.jpg'),
                  height: 200,
                  width: 200,
                ),
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
                          margin:
                              const EdgeInsets.only(bottom: 6.0, right: 6.0),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                              image:
                                  AssetImage('lib/src/assets/images/share.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                          const Text(
                            "Share",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                  thickness: 3,
                ),
              )
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPostPage()));
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
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
                                IconData(0x2716, fontFamily: 'MaterialIcons'),
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
                              margin:
                              const EdgeInsets.only(top: 10.0, left: 8.0),
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
                      style: const TextStyle(color: Colors.black, fontSize: 16),
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

              //image of post
              Container(
                margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                child: const Image(
                  image: AssetImage('lib/src/assets/images/avatar.jpg'),
                  height: 200,
                  width: 200,
                ),
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
                          margin:
                          const EdgeInsets.only(bottom: 6.0, right: 6.0),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                              image:
                              AssetImage('lib/src/assets/images/share.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                          const Text(
                            "Share",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                  thickness: 3,
                ),
              )
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPostPage()));
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
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
                                IconData(0x2716, fontFamily: 'MaterialIcons'),
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
                              margin:
                              const EdgeInsets.only(top: 10.0, left: 8.0),
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
                      style: const TextStyle(color: Colors.black, fontSize: 16),
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

              //image of post
              Container(
                margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                child: const Image(
                  image: AssetImage('lib/src/assets/images/avatar.jpg'),
                  height: 200,
                  width: 200,
                ),
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
                          margin:
                          const EdgeInsets.only(bottom: 6.0, right: 6.0),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                              image:
                              AssetImage('lib/src/assets/images/share.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                          const Text(
                            "Share",
                            style: TextStyle(color: Colors.black, fontSize: 16),
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
                  thickness: 3,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
