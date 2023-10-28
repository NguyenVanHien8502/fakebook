import 'package:fakebook/src/pages/tabs/menu_page.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ArgumentMenu;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Facebook"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(args.linkAvatar),
                  radius: 60,
                ),
                //Name - Intro
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 15, top: 20, left: 20, right: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            args.name,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      const Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Sinh viên năm 4 Đại học Bách Khoa Hà Nội, chuyên ngành Khoa học máy tính - hệ Cử nhân',
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines:
                                  2, // Số dòng tối đa trước khi xuống dòng
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //Detail Info
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.6, color: Colors.black),
                      bottom: BorderSide(width: 0.6, color: Colors.black),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 20, bottom: 16, top: 6),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Đã làm việc tại công ty ABC',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.book,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Học tại Đại học Bách Khoa Hà Nội - HaNoi University of Science and Technology',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Sống tại Hà Nội',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.map,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Đến từ Hà Nội',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.wifi,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Có 2.602 người theo dõi',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
