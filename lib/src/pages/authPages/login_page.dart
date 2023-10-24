import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/forgot_password_page.dart';
import 'package:fakebook/src/pages/app.dart';
import 'package:fakebook/src/pages/authPages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void navigateRegisterScreen() {}

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
                  controller: usernameController,
                  hintText: 'Phone number or email',
                  obscureText: false,
                  hintPadding: const EdgeInsets.only(left: 20.0),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black54,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const App()));
                    }),
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
