import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:fakebook/src/pages/authPages/pre_register_page.dart';
import 'package:fakebook/src/pages/authPages/register_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                const Image(
                  image: AssetImage('lib/src/assets/images/avatar.jpg'),
                  height: 200,
                  width: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Nguyen Van Hien",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 30,
                ),
                //login current account
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/app");
                  },
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
                  onPressed: () {
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
