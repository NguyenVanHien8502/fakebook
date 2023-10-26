import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/forgot_password_page.dart';
import 'package:fakebook/src/pages/app.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('lib/src/assets/images/fakebook.png'),
                  height: h * 0.35,
                  width: w * 0.35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 25.0),
                  ),
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 25),
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
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Did you forget your password? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordPage()));
                        },
                        child: const Text(
                          'Click here',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                MyButton(
                  nameButton: "Sign in",
                  onTap: () {
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
                    if (isEmailValid(email) && isPasswordValid(password) && password!=email) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const App()));
                    }
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Haven\'t you already account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold),
                      ),
                    )
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
