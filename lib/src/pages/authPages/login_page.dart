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
                //logo
                Image(
                  image: const AssetImage('lib/src/assets/images/fakebook.png'),
                  height: h * 0.15,
                  width: w * 0.15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 25.0),
                  ),
                ),

                // username text-field
                const SizedBox(height: 25),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Số di động hoặc email',
                  obscureText: false,
                  hintPading: const EdgeInsets.only(left: 20.0),
                ),

                //password text-field
                const SizedBox(height: 15),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Mật khẩu',
                  obscureText: true,
                  hintPading: const EdgeInsets.only(left: 20.0),
                ),

                const SizedBox(height: 25),
                MyButton(
                    nameButton: "Sign in",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const App()));
                    }),

                //forgot password
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
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
                    ],
                  ),
                ),
                //sign in button

                const SizedBox(height: 50),

                //Haven't you already account? Register now
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
