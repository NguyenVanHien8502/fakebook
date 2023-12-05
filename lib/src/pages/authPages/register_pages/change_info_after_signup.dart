import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/authPages/register_pages/save_info_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChangeInfoAfterSignupPage extends StatefulWidget {
  const ChangeInfoAfterSignupPage({Key? key}) : super(key: key);

  @override
  ChangeInfoAfterSignupPageState createState() =>
      ChangeInfoAfterSignupPageState();
}

class ChangeInfoAfterSignupPageState extends State<ChangeInfoAfterSignupPage> {
  static const storage = FlutterSecureStorage();

  final TextEditingController usernameController = TextEditingController();
  File? image;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future<void> handleChangeInfoAfterSignup(BuildContext context) async {
    String username = usernameController.text;
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.changeInfoAfterSignup);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['username'] = username;
      if (image != null) {
        var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
        var length = await image!.length();
        var multipart = http.MultipartFile('avatar', stream, length,
            filename: basename(image!.path),
            contentType: MediaType('avatar', 'jpg'));
        request.files.add(multipart);
      }
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      if (decodedResponse['code'] == '1000') {
        var userId = decodedResponse['data']['id'];
        var url = Uri.parse(ListAPI.getUserInfo);
        Map body = {
          "user_id": userId,
        };

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final getUserInfo = jsonDecode(response.body);
        if (response.statusCode == 201) {
          if (getUserInfo['code'] == '1000') {
            var currentUser = getUserInfo['data'];
            var currentUserJson = jsonEncode(currentUser);
            await storage.write(key: 'currentUser', value: currentUserJson);
          }
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content:
                  const Text('Chúc mừng! Đã cập nhật thông tin thành công.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SaveInfoLoginPage()));
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
              title: const Text('Thông báo'),
              content: const Text('An error occurred!'),
              actions: <Widget>[
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
      print("Occur error:: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Tạo username && avatar",
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
                    "Tạo username và avatar giúp người khác có thể dễ dàng theo dõi và kết bạn với bạn.",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: const Text(
                    "Username *:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: usernameController,
                          obscureText: false,
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
                            hintText: "Username của bạn",
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: const Text(
                    "Avatar:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                    child: image == null
                        ? Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              onPressed: getImage,
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(370, 50),
                                padding: EdgeInsets.zero,
                                // Loại bỏ padding mặc định của nút
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50), // Đặt độ cong của góc
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
                                  "Chọn ảnh",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(25.0),
                            child: Center(
                                child: Column(
                              children: [
                                Image.file(
                                  File(image!.path).absolute,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: ElevatedButton(
                                    onPressed: getImage,
                                    style: ElevatedButton.styleFrom(
                                      maximumSize: const Size(370, 50),
                                      padding: EdgeInsets.zero,
                                      // Loại bỏ padding mặc định của nút
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50), // Đặt độ cong của góc
                                      ),
                                      backgroundColor: Colors.white,
                                      // Đặt màu nền của nút
                                      side: const BorderSide(
                                        color: Color.fromARGB(255, 0, 68, 255),
                                        // Đặt màu đường viền
                                        width: 0.4, // Đặt độ dày của đường viền
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Chọn lại",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          )),
                const SizedBox(height: 25.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      handleChangeInfoAfterSignup(context);
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
                        "Lưu thông tin",
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
}
