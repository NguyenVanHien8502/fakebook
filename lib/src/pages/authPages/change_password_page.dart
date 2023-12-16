import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  static const storage = FlutterSecureStorage();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

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
                    "Thay đổi mật khẩu của bạn",
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
                    "Nhập mật khẩu hiện tại và mật khẩu mới để tiến hành thay đổi mật khẩu cho bạn. Lưu ý hãy ghi nhớ mật khẩu mới của bạn.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Mật khẩu hiện tại *:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Nhập mật khẩu hiện tại',
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
                        Icons.password,
                        color: Colors.black54,
                      ),
                    ),
                    cursorColor: Colors.black, //chỉnh màu của cái vạch nháy
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Mật khẩu mới *:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: true,
                    controller: newPasswordController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Nhập mật khẩu mới',
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
                        Icons.password,
                        color: Colors.black54,
                      ),
                    ),
                    cursorColor: Colors.black, //chỉnh màu của cái vạch nháy
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: handleChangePassword,
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
                        "Change password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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

  Future<void> handleChangePassword() async {
    String password = passwordController.text;
    String newPassword = newPasswordController.text;
    String? token =await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.changePassword);
      Map body = {
        'password': password,
        'new_password': newPassword,
      };

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization':'Bearer $token'},
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
          String token=responseBody['data']['token'];
          await storage.write(key: 'password', value: newPassword);
          await storage.write(key: 'token', value: token);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Notification'),
                content: const Text(
                    'Congratulations! You have successfully changed password.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      passwordController.clear();
                      newPasswordController.clear();
                      Navigator.pushNamed(
                        context,
                        HomeScreen.routeName,
                      );
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
