import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    /////
    return Scaffold(
        body: Column(
      children: <Widget>[
        /// Menu và cài đặt
        Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Menu",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, "/about");
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
        // Trang cá nhân
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/personal-page",
                arguments: {"name": "Nguyen Ngoc Linh", "age": "22"});
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.only(left: 12),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('lib/src/assets/images/fakebook.png'),
                  radius: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Nguyen Van A",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 213, 213, 213),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save,
                          color: Color.fromARGB(255, 203, 94, 194), size: 32),
                      Text(
                        "Đã lưu",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 213, 213, 213),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    children: [
                      Icon(Icons.watch_later,
                          color: Color.fromARGB(255, 34, 222, 255), size: 32),
                      Text(
                        "Kỷ niệm",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            //Hàng 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 213, 213, 213),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group,
                          color: Color.fromARGB(255, 240, 78, 9), size: 32),
                      Text(
                        "Nhóm",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: w * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 213, 213, 213),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  child: const Column(
                    children: [
                      Icon(Icons.video_call,
                          color: Color.fromARGB(255, 34, 222, 255), size: 32),
                      Text(
                        "Video",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        //Thông tin cài đặt, trợ giúp
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              padding:
                  const EdgeInsets.only(left: 24, right: 12, top: 8, bottom: 8),
              child: const Row(
                children: [
                  Icon(Icons.help, color: Colors.grey, size: 38.0),
                  SizedBox(width: 16.0),
                  Text(
                    'Trợ giúp và hỗ trợ',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/personal-page");
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.6, color: Colors.black),
                  ),
                ),
                padding: const EdgeInsets.only(
                    left: 24, right: 12, top: 8, bottom: 8),
                child: const Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey, size: 38.0),
                    SizedBox(width: 16.0),
                    Text(
                      'Cài đặt & quyền riêng tư',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              padding:
                  const EdgeInsets.only(left: 24, right: 12, top: 8, bottom: 8),
              child: const Row(
                children: [
                  Icon(Icons.data_exploration, color: Colors.grey, size: 38.0),
                  SizedBox(width: 16.0),
                  Text(
                    'Quyền truy cập chuyên nghiệp',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 0.6, color: Colors.black),
                ),
              ),
              padding: const EdgeInsets.only(
                  left: 24, right: 12, top: 8, bottom: 20),
              child: const Row(
                children: [
                  Icon(Icons.bookmark, color: Colors.grey, size: 38.0),
                  SizedBox(width: 16.0),
                  Text(
                    'Điều khoản và chính sách',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        // Nút Đăng xuất
        Container(
          margin: const EdgeInsets.only(bottom: 28),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50), // Kích thước cho nút
            ),
            child: const Text(
              "Đăng xuất",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    ));
  }
}
