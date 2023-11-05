import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool usernameError = false;

  bool isUsernameValid(String username) {
    if (username.length < 2 || username.length > 30) {
      return false;
    }
    return true;
  }

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

  bool confirmPasswordError = false;

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Username*:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Username...',
                obscureText: false,
                hintPadding: const EdgeInsets.only(left: 10.0),
              ),
              if (usernameError)
                Container(
                  margin: const EdgeInsets.only(right: 30.0, top: 5.0),
                  child: const Text(
                    'Username must be from 2 to 30 characters',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Your email*:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Email...',
                obscureText: false,
                hintPadding: const EdgeInsets.only(left: 10.0),
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
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Your password*:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Password...',
                obscureText: true,
                hintPadding: const EdgeInsets.only(left: 10.0),
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
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm your password*:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm password...',
                obscureText: true,
                hintPadding: const EdgeInsets.only(left: 10.0),
              ),
              if (confirmPasswordError)
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'Confirm password must be the same as password',
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(
                height: 40,
              ),

              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  if (!isUsernameValid(username)) {
                    setState(() {
                      usernameError = true;
                    });
                  } else {
                    setState(() {
                      usernameError = false;
                    });
                  }
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
                  if (confirmPassword != password) {
                    setState(() {
                      confirmPasswordError = true;
                    });
                  } else {
                    setState(() {
                      confirmPasswordError = false;
                    });
                  }
                  if (isEmailValid(email) &&
                      isPasswordValid(password) &&
                      password != email &&
                      confirmPassword == password &&
                      isUsernameValid(username)) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Notification'),
                          content: const Text(
                              'Congratulations! You have successfully registered. Now go to the login page to log in.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginPage()));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size(300, 50),
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
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
