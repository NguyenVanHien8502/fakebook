import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/authPages/restore_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class GetVerifyCodePage extends StatefulWidget {
  const GetVerifyCodePage({Key? key}) : super(key: key);

  @override
  GetVerifyCodePageState createState() => GetVerifyCodePageState();
}

class GetVerifyCodePageState extends State<GetVerifyCodePage> {
  static const storage = FlutterSecureStorage();
  final TextEditingController emailController = TextEditingController();

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
                  margin: const EdgeInsets.only(left: 24.0),
                  child: const Text(
                    "Lấy mã xác thực",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: const Text(
                    "Nhập email đăng ký của bạn để chúng tôi sẽ gửi mã xác thực cho bạn qua email. Bạn có thể lấy mã đó để khôi phục tài khoản của mình",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter registered email',
                      contentPadding: const EdgeInsets.only(left: 20.0),
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      filled: true,
                      fillColor: Colors.grey[200],
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignLabelWithHint: true,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black54,
                      ),
                    ),
                    cursorColor: Colors.black, //chỉnh màu của cái vạch nháy
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: const Text(
                    "Chúng tôi có thể gửi thông báo qua Email và WhatsApp để phục vụ mục đích bảo mật và hỗ trợ bạn khôi phục tài khoản.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: ElevatedButton(
                    onPressed: handleGetVerifyCode,
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(310, 50),
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
                        "Lấy mã",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleGetVerifyCode() async {
    String email = emailController.text;
    try {
      var url = Uri.parse(ListAPI.getVerifyCode);
      Map body = {
        'email': email,
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      final responseBody = jsonDecode(response.body);

      if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
        await storage.write(key: 'emailToRestoreUser', value: email);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Verify Code'),
              content: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Enter the following code to restore your account: ",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    TextSpan(
                      text: "${responseBody['data']['verify_code']}.",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold, // Màu xanh
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const RestoreUserPage()));
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
