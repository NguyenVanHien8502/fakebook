import 'package:fakebook/src/pages/app.dart';
import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
        title: const Text(
          "Bài viết",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("Search");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: Image(
                          image: const AssetImage(
                              'lib/src/assets/images/avatar.jpg'),
                          height: h * 0.15,
                          width: w * 0.15,
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
                          child: GestureDetector(
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
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      "Xin chào các bạn, bên team mình vừa biên soạn một lộ trình học lập trình cho các bạn muốn tìm hiểu về IT hoặc đang là người mới, người muốn update thêm kỹ năng . Hiện tại mình muốn tìm kiếm những bạn có tiềm năng để phát triển nên mình xin tặng cho các bạn khóa học này, với lộ trình cấp tốc các bạn sẽ được rất nhiều kiến thức và ứng dụng trong thực tế!",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  child: const Image(
                    image: AssetImage('lib/src/assets/images/avatar.jpg'),
                    height: 300,
                    width: 300,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14.0),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                  margin: const EdgeInsets.only(top: 14.0),
                  child: const Divider(
                    height: 1,
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12.0, top: 5.0),
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
                        margin: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: const Text(
                          "Lê Văn Luyện và 98 người khác",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
