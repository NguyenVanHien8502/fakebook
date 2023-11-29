import 'package:fakebook/src/pages/authPages/register_pages/save_info_login.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class PasswordRegisterPage extends StatefulWidget {
  const PasswordRegisterPage({Key? key}) : super(key: key);

  @override
  PasswordRegisterPageState createState() => PasswordRegisterPageState();
}

class PasswordRegisterPageState extends State<PasswordRegisterPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Tạo mật khẩu",
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
                    "Tạo mật khẩu gồm ít nhất 6 chữ cái hoặc chữ số. Bạn nên chọn mật khẩu thật khó đoán.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            fillColor: Colors.white10,
                            filled: true,
                            hintText: "Mật khẩu của bạn",
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Notification'),
                            content: const Text(
                                'Congratulations! You have successfully registered.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SaveInfoLoginPage()));
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          );
                        },
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
                        "Xong",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 430,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        'Bạn có tài khoản rồi ư?',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
