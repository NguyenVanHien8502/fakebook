import 'package:fakebook/src/data/infouser.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/personal-page",
                            arguments: ArgumentMenu(
                                'lib/src/assets/images/avatar.jpg',
                                "Nguyen Văn Hiển"));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/src/assets/images/avatar.jpg'),
                          radius: 24,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PostPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(220, 40),
                          padding: EdgeInsets.zero,
                          // Loại bỏ padding mặc định của nút
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50), // Đặt độ cong của góc
                          ),
                          primary: const Color.fromARGB(255, 248, 248, 248),
                          side: const BorderSide(
                            color: Colors.grey, // Đặt màu đường viền
                            width: 0, // Đặt độ dày của đường viền
                          ),
                          elevation: 0.2,
                          shadowColor: Colors.grey,
                        ),
                        child: const Center(
                          child: Text(
                            "Bạn đang nghĩ gì?",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          print("navigate to album");
                        },
                        child: const Icon(
                          Icons.photo_library_outlined,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                  thickness: 5,
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
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
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: const Divider(
                    height: 1,
                    color: Colors.black12,
                    thickness: 3,
                  ),
                ),

                //Start list posts
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
                        text: TextSpan(
                          children: [
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
                          ]
                        ),
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
                        text: TextSpan(
                            children: [
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
                            ]
                        ),
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
                        text: TextSpan(
                            children: [
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
                            ]
                        ),
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
                        text: TextSpan(
                            children: [
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
                            ]
                        ),
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
                        thickness: 3,
                      ),
                    )
                  ],
                ),
                ///End list posts
              ],
            ),
          ),
        ),
      ),
    );
  }
}
