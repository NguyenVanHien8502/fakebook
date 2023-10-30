import 'package:fakebook/src/components/my_textfield.dart';
import 'package:fakebook/src/pages/authPages/reset_password_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: const Text(
                    "Tìm tài khoản",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: const Text(
                    "Nhập email đăng ký của bạn",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20.0),
                const MyTextField(
                  hintText: 'Enter registered email',
                  obscureText: false,
                  hintPadding: EdgeInsets.only(left: 20.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: const Text(
                    "Chúng tôi có thể gửi thông báo qua Email và WhatsApp để phục vụ mục đích bảo mật và hỗ trợ bạn đăng nhập.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(w * 0.85, 50),
                      padding: EdgeInsets.zero,
                      // Loại bỏ padding mặc định của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(50), // Đặt độ cong của góc
                      ),
                      backgroundColor: Colors.blue,// Đặt màu nền của nút
                      side: const BorderSide(
                        color:
                        Color.fromARGB(255, 0, 68, 255), // Đặt màu đường viền
                        width: 0.4, // Đặt độ dày của đường viền
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Tìm tài khoản",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
