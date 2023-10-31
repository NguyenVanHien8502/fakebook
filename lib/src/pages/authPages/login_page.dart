import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/forgot_password_page.dart';
import 'package:fakebook/src/pages/app.dart';
import 'package:fakebook/src/pages/authPages/pre_register_page.dart';
import 'package:fakebook/src/pages/authPages/register_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
        iconTheme: const IconThemeData(color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
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
                      const SizedBox(height: 30,),
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
                            'Invalid password: password should be between 4 and 20 characters long, contain no special characters and must not be similar to an email',
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
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
                    if (isEmailValid(email) &&
                        isPasswordValid(password) &&
                        password != email) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const App()));
                    }
                  },
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
}
