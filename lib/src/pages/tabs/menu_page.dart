import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    /////
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.settings, size: 30),
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/personal-page",
                        arguments: ArgumentMenu(
                            'lib/src/assets/images/fakebook.png',
                            "Nguyen Ngoc Linh"));
                  },
                  child: Container(
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 213, 213, 213),

                    ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: w * 0.45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 213, 213),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin:
                              const EdgeInsets.only(left: 5, right: 3, top: 10),
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.save,
                                  color: Color.fromARGB(255, 203, 94, 194),
                                  size: 32),
                              Text(
                                "Đã lưu",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: w * 0.45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 213, 213),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin:
                              const EdgeInsets.only(left: 5, right: 3, top: 10),
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            children: [
                              Icon(Icons.watch_later,
                                  color: Color.fromARGB(255, 34, 222, 255),
                                  size: 32),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: w * 0.45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 213, 213),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin:
                              const EdgeInsets.only(left: 5, right: 3, top: 10),
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.group,
                                  color: Color.fromARGB(255, 240, 78, 9),
                                  size: 32),
                              Text(
                                "Nhóm",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: w * 0.45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 213, 213, 213),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 3,
                            top: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Column(
                            children: [
                              Icon(Icons.video_call,
                                  color: Color.fromARGB(255, 34, 222, 255),
                                  size: 32),
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
                //Thông tin cài đặt và trợ giúp
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.3, color: Colors.black),
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.only(
                          left: 24, right: 12, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.help, color: Colors.grey, size: 38.0),
                              SizedBox(width: 16.0),
                              Text(
                                'Trợ giúp và hỗ trợ',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more),
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                                print(isExpanded);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/personal-page",
                            arguments: ArgumentMenu(
                                'lib/src/assets/images/fakebook.png',
                                "Settings"));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 0.3, color: Colors.black),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 24, right: 12, top: 8, bottom: 8),
                        child: const Row(
                          children: [
                            Icon(Icons.settings,
                                color: Colors.grey, size: 38.0),
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
                          top: BorderSide(width: 0.3, color: Colors.black),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 24, right: 12, top: 8, bottom: 8),
                      child: const Row(
                        children: [
                          Icon(Icons.data_exploration,
                              color: Colors.grey, size: 38.0),
                          SizedBox(width: 16.0),
                          Text(
                            'Quyền truy cập chuyên nghiệp',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.3, color: Colors.black),
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
                //Đăng xuất
                Container(
                  margin: const EdgeInsets.only(bottom: 28),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(w * 0.85, 50),
                      padding: EdgeInsets.zero,
                      // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      primary: const Color.fromARGB(255, 248, 248, 248),
                      side: const BorderSide(
                        color:
                        Color.fromARGB(255, 0, 68, 255), // Đặt màu đường viền
                        width: 0.2, // Đặt độ dày của đường viền
                      ),
                      backgroundColor: Colors.blue,// Đặt màu nền của nút
                    ),
                    child: const Center(
                      child: Text(
                        "Đăng xuất",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArgumentMenu {
  String linkAvatar;
  String name;
  ArgumentMenu(this.linkAvatar, this.name);
}
