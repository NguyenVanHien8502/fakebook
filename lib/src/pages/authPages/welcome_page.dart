import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:fakebook/src/pages/authPages/pre_register_page.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fakebook/src/model/user.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = '/welcome';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 32,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                currentUser != null
                    ? ClipOval(
                        child: Image.network(
                          '${jsonDecode(currentUser)['avatar']}',
                          height: 200,
                          width: 200,
                          fit: BoxFit
                              .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                        ),
                      )
                    : const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
                        height: 200,
                        width: 200,
                      ),
                const SizedBox(
                  height: 30,
                ),
                currentUser != null
                    ? Text(
                        "${jsonDecode(currentUser)['username']}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(
                        height: 20.0,
                      ),

                const SizedBox(
                  height: 30,
                ),
                //login current account
                ElevatedButton(
                  onPressed: handleLoginQuickly,
                  style: ElevatedButton.styleFrom(
                      maximumSize: Size(w * 0.85, 50),
                      padding:
                          EdgeInsets.zero, // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      backgroundColor: Colors.blue // Đặt màu nền của nút
                      ),
                  child: const Center(
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //navigate login page
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(w * 0.85, 50),
                    padding:
                        EdgeInsets.zero, // Loại bỏ padding mặc định của nút
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Đặt độ cong của góc
                    ),
                    primary: const Color.fromARGB(
                        255, 241, 245, 248), // Đặt màu nền của nút
                  ),
                  child: const Center(
                    child: Text(
                      "Đăng nhập bằng tài khoản khác",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 95, 94, 94)),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 80)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PreRegisterPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.6,
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
                      width: 0.5, // Đặt độ dày của đường viền
                    ), // Đặt màu nền của nút
                  ),
                  child: const Center(
                    child: Text(
                      "Tạo tài khoản mới",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 1, 107, 245)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('lib/src/assets/images/meta_icon.jpg'),
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "Meta",
                      style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLoginQuickly() async {
    String? email = await storage.read(key: 'email');
    String? password = await storage.read(key: 'password');
    if (email == null || password == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bạn chưa lưu thông tin đăng nhập'),
            content: RichText(
              text: TextSpan(
                text: 'Vui lòng chọn ',
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Đăng nhập bằng tài khoản khác',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16, // Màu bạn muốn sử dụng để highlight
                    ),
                  ),
                  TextSpan(text: ' để đăng nhập lại.'),
                ],
              ),
            ),
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
    } else {
      try {
        var url = Uri.parse(ListAPI.login);
        Map body = {
          "email": email,
          'password': password,
          'uuid': 'string',
        };

        http.Response response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            var token = responseBody['data']['token'];
            const storage = FlutterSecureStorage();

            User user = User(
                id: responseBody['data']['id'],
                name: responseBody['data']['username'],
                avatar:
                    //responseBody['data']['avatar'] ??
                    'lib/src/assets/images/avatarfb.jpg');

            Provider.of<UserProvider>(context, listen: false).updateUse(user);

            await storage.write(key: 'token', value: token);
            Navigator.pushNamed(
              context,
              HomeScreen.routeName,
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
}
