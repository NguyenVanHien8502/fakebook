import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:fakebook/src/pages/otherPages/personal_page_screen.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  User user = User(
      id: "36",
      name: "Nguyễn Ngọc Linh",
      avatar: 'lib/src/assets/images/avatar.jpg');

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
        titleSpacing: 0,
        //xóa bỏ khoảng cách mặc định giữa icontheme và title
        title: Container(
          margin: const EdgeInsets.only(right: 16.0, top: 5.0),
          width: 290,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.withOpacity(0.1), // Đổi màu background tại đây
          ),
          child: const TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none, // Xóa border
              hintText: "Search...",
              contentPadding: EdgeInsets.only(left: 16.0, bottom: 9.0),
              hintStyle: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              height: 1,
              color: Colors.black12,
              thickness: 3,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      // Nội dung của trang bạn muốn hiển thị
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gần đây",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Text(
                              "Xem tất cả",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20.0),
                            )
                          ],
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
