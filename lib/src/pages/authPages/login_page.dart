import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/authPages/forgot_password_page.dart';
import 'package:fakebook/src/pages/authPages/pre_register_page.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emailError = false;

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool passwordError = false;

  bool isPasswordValid(String password) {
    if (password.length < 4 || password.length > 20) {
      return false;
    }
    final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (specialCharacterRegex.hasMatch(password)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('lib/src/assets/images/fakebook.png'),
                  height: h * 0.2,
                  width: w * 0.2,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        hintPadding: const EdgeInsets.only(left: 20.0),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black54,
                        ),
                      ),
                      if (emailError)
                        Container(
                          margin: const EdgeInsets.only(right: 165.0, top: 5.0),
                          child: const Text(
                            'Invalid email address',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        hintPadding: const EdgeInsets.only(left: 20.0),
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.black54,
                        ),
                      ),
                      if (passwordError)
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Text(
                            'Invalid password: password must be longer than or equal to 6 characters, contain no special characters and must not be similar to an email',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(w * 0.85, 50),
                    padding: EdgeInsets.zero,
                    // Loại bỏ padding mặc định của nút
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Đặt độ cong của góc
                    ),
                    backgroundColor: Colors.blue,
                    // Đặt màu nền của nút
                    side: const BorderSide(
                      color:
                          Color.fromARGB(255, 0, 68, 255), // Đặt màu đường viền
                      width: 0.4, // Đặt độ dày của đường viền
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                    },
                    child: const Text(
                      'Bạn quên mật khẩu ư?',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 95,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PreRegisterPage()));
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
                      width: 0.8, // Đặt độ dày của đường viền
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

  Future<void> handleLogin() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (!isEmailValid(email)) {
      setState(() {
        emailError = true;
      });
    } else {
      setState(() {
        emailError = false;
      });
    }

    if (!isPasswordValid(password) || password == email) {
      setState(() {
        passwordError = true;
      });
    } else {
      setState(() {
        passwordError = false;
      });
    }
    if (isEmailValid(email) && isPasswordValid(password) && password != email) {
      _login(context, email, password);
    }
  }

  Future<void> _login(
      BuildContext context, String email, String password) async {
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
          print(responseBody['data']);
          const storage = FlutterSecureStorage();
          await storage.write(key: 'token', value: token);
          // String? tokenn = await storage.read(key: 'token');
          User user = User(
              id: responseBody['data']['id'],
              name: responseBody['data']['username'],
              avatar:
                  //responseBody['data']['avatar'] ??
                  'lib/src/assets/images/avatarfb.jpg');

          //Cập nhật trạng thái toàn cầu
          Provider.of<UserProvider>(context, listen: false).updateUse(user);

          await storage.write(key: 'token', value: token);
          await storage.write(key: 'email', value: email);
          await storage.write(key: 'password', value: password);
          emailController.clear();
          passwordController.clear();
          // if(await storage.read(key: 'token') != null) {

          // }
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

  ///
  Future<void> _fetchUserData(BuildContext context, String token) async {
    try {
      var url = Uri.parse(ListAPI.get_user_info);
    } catch (e) {
      print('Lỗi khi lấy dữ liệu người dùng: $e');
    }
  }
}
