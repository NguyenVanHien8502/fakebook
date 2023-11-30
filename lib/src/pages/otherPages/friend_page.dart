import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => FriendPageState();
}

class FriendRequest {
  final User user;
  final int? mutualFriends;
  FriendRequest({
    required this.user,
    this.mutualFriends,
  });
}

class FriendPageState extends State<FriendPage> {
  User user = User(
      id: "26",
      name: "Nguyễn Ngọc Linh",
      avatar: 'lib/src/assets/images/avatar.jpg');

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Bạn bè",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.search, color: Colors.black), // Icon tìm kiếm
            onPressed: () {
              print(
                  "Tìm cái méo gì, làm cho đẹp thôi, bấm textfield ở dưới mà tìm");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Container(
              width: 400,
              height: 80,
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 5.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  hintText: "Click here to search...",
                  fillColor: Colors.white10,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nội dung của trang bạn muốn hiển thị
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "999 bạn bè",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Text(
                              "Sắp xếp",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: const Divider(
                          height: 1,
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OtherPersonalPageScreen.routeName,
                            arguments: user,
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 16.0),
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
                                        margin:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: const Text(
                                            "Nguyen Van Hien",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(left: 16.0),
                                        child: const Text(
                                          "3 thông tin mới",
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
                                      child: const Icon(
                                        Icons.more_horiz,
                                        size: 20.0,
                                        color: Colors.black54,
                                      ),
                                    ))
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
