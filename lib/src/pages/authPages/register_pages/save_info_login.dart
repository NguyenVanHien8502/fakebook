import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/authPages/register_page.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:image_picker/image_picker.dart';

class SaveInfoLoginPage extends StatefulWidget {
  const SaveInfoLoginPage({Key? key}) : super(key: key);

  @override
  SaveInfoLoginPageState createState() => SaveInfoLoginPageState();
}

class SaveInfoLoginPageState extends State<SaveInfoLoginPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Lưu thông tin đăng nhập?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Chúng tôi sẽ lưu thông tin đăng nhập cho bạn để bạn không cần đăng nhập vào lần sau.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        HomeScreen.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(370, 50),
                      padding: EdgeInsets.zero,
                      // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      backgroundColor: Colors.blue,
                      // Đặt màu nền của nút
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 68, 255), // Đặt màu đường viền
                        width: 0.4, // Đặt độ dày của đường viền
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Lưu",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    // onPressed: () {
                    //   Navigator.pushNamed(
                    //     context,
                    //     HomeScreen.routeName,
                    //   );
                    // },
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        // Xử lý ảnh được chọn ở đây
                        print('Đường dẫn đến ảnh: ${image.path}');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(370, 50),
                      padding: EdgeInsets.zero,
                      // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      backgroundColor: Colors.white,
                      // Đặt màu nền của nút
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 68, 255), // Đặt màu đường viền
                        width: 0.4, // Đặt độ dày của đường viền
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Lúc khác",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
