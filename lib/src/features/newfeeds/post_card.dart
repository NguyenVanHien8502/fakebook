import 'package:fakebook/src/features/comment/screens/comment_screen.dart';
import 'package:fakebook/src/model/post.dart';
import 'package:fakebook/src/pages/otherPages/detail_post_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void dispose() {
    super.dispose();
  }

  String status =
      "Sau khoảng thời gian trải qua những thử thách đầy cam go, bằng tài năng và sự nỗ lực của mình, các đội đã dần về đích và tiến gần hơn đến ngôi vị quán quân. Những dự án cộng đồng thiết thực, có tính đột phá đã nhận được những đánh giá  cao từ Ban giám khảo và khán giả của chương trình. ";
  int maxLength = 100; // Giới hạn độ dài của đoạn status
  bool isExpanded = false;
  String displayedStatus = "";

  bool postVisible = true;

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
    return postVisible
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
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
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8.0),
                                  child: const Text(
                                    "Lời thì thầm của đá",
                                    style: TextStyle(
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
                                const Text(
                                  "1 minute ago",
                                  style: TextStyle(color: Colors.black),
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
                                      borderRadius: const BorderRadius.only(
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
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  onTap: () {},
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: const ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.add_circle_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Hiển thị thêm',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Bạn sẽ nhìn thấy nhiều bài viết tương tự hơn.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.remove_circle,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Ẩn bớt',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'Bạn sẽ nhìn thấy ít bài viết tương tự hơn.',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 14,
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
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  onTap: () {},
                                                  child: const ListTile(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    leading: Icon(
                                                      Icons.file_copy_rounded,
                                                      color: Colors.black,
                                                      size: 30,
                                                    ),
                                                    title: Text(
                                                      'Sao chép liên kết',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  onTap: () {},
                                                  child: ListTile(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    tileColor: Colors.white,
                                                    minLeadingWidth: 10,
                                                    titleAlignment:
                                                        ListTileTitleAlignment
                                                            .center,
                                                    leading: const Icon(
                                                      Icons.view_list_rounded,
                                                      size: 30,
                                                      color: Colors.black,
                                                    ),
                                                    title: const Text(
                                                      'Quản lý bảng feed',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                postVisible = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 8.0),
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
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: displayedStatus,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    if (!isExpanded) ...{
                      TextSpan(
                        text: '... Xem thêm',
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
              Material(
                color: Colors.white,
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CommentScreen.routeName,
                          arguments: widget.post);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'lib/src/assets/images/reactions/like.png',
                                width: 20,
                                height: 20,
                              ),
                              Image.asset(
                                'lib/src/assets/images/reactions/haha.png',
                                width: 20,
                                height: 20,
                              ),
                              Image.asset(
                                'lib/src/assets/images/reactions/love.png',
                                width: 20,
                                height: 20,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: const Text("99"),
                              )
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
                margin: const EdgeInsets.only(top: 20.0),
                child: const Divider(
                  height: 1,
                  color: Colors.black12,
                  thickness: 5,
                ),
              )
            ],
          )
        : Padding(
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
                        setState(() {
                          postVisible = true;
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
                        backgroundImage:
                            AssetImage('lib/src/assets/images/avatar.jpg'),
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
                      Icons.feedback_rounded,
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
}
