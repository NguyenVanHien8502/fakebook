import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/reset_password_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: const Text(
                      "Please complete all information below to reset your password",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const Column(
                    children: [
                      Text("Enter phone number or registered email"),
                      SizedBox(
                        height: 10.0,
                      ),
                      MyTextField(
                        hintText: 'Phone number or email',
                        obscureText: false,
                        hintPadding: EdgeInsets.only(left: 20.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                MyButton(
                    nameButton: "Submit",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
