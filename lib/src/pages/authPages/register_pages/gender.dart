import 'package:fakebook/src/pages/authPages/register_pages/email.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class GenderRegisterPage extends StatefulWidget {
  const GenderRegisterPage({Key? key}) : super(key: key);

  @override
  GenderRegisterPageState createState() => GenderRegisterPageState();
}

class GenderRegisterPageState extends State<GenderRegisterPage> {
  String? selectedGender;

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
                    "Giới tính của bạn là gì?",
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
                    "Bạn có thể thay đổi người nhìn thấy giới tính của mình trên trang cá nhân vào lúc khác.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nữ",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Radio(
                            value: "female",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nam",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Radio(
                            value: "male",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 270,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tùy chọn khác",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(height: 5.0,),
                                Text(
                                  "Chọn tùy chọn khác nếu bạn thuộc giới tính khác hoặc không muốn tiết lộ.",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Radio(
                            value: "other",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmailRegisterPage()));
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
                        "Tiếp",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 300,
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
