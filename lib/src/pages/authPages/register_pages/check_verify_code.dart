import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/authPages/register_pages/password.dart';
import 'package:fakebook/src/pages/authPages/register_pages/save_info_login.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class CheckVerifyCodePage extends StatefulWidget {
  const CheckVerifyCodePage({Key? key}) : super(key: key);

  @override
  CheckVerifyCodePageState createState() => CheckVerifyCodePageState();
}

class CheckVerifyCodePageState extends State<CheckVerifyCodePage> {
  final TextEditingController codeController = TextEditingController();
  late String userEmail;

  @override
  void initState() {
    super.initState();
    getEmailFromStorage();
  }

  Future<void> getEmailFromStorage() async {
    // Lấy email từ FlutterSecureStorage
    String? email = await storage.read(key: 'email');
    if (email != null) {
      setState(() {
        userEmail = email;
      });
    } else {
      print("Email is not exist in FlutterSecureStorage");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Not have email!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    "Xác thực email của bạn",
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
                    "Tuyệt đối không để ai biết mã verify code của bạn nhằm mục đích bảo mật thông tin cho chính bạn. Chúng tôi cũng sẽ giữ kín thông tin nhạy cảm của bạn.",
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
                          controller: codeController,
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
                            hintText: "Enter verify code",
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
                    onPressed: handleCheckVerifyCode,
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
                        "Xác thực",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 400,
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

  Future<void> handleCheckVerifyCode() async {
    String email = userEmail;
    String verifyCode = codeController.text;
    try {
      var url = Uri.parse(ListAPI.checkVerifyCode);
      Map body = {
        "email": email,
        'code_verify': verifyCode,
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Notification'),
                content: const Text(
                    'Congratulations! You have successfully verify.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      codeController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SaveInfoLoginPage()));
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('${responseBody['message']}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('${responseBody['message']}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error during login: $e');
      // Handle the error, e.g., show a general error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred during login.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
