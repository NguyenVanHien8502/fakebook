import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
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
                  margin: const EdgeInsets.only(top: 72),
                  padding: const EdgeInsets.all(10),
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
                Container(
                  height: h * 0.085,
                  width: w * 0.88,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 40),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 205, 205, 205), // Đặt màu nền ở đây
                    borderRadius:
                        BorderRadius.circular(23), // Đặt độ cong của góc
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 26,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Nguyen Ngoc Linh",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.085,
                  width: w * 0.88,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 205, 205, 205), // Đặt màu nền ở đây
                    borderRadius:
                        BorderRadius.circular(23), // Đặt độ cong của góc
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 26,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Nguyen Ngoc Linh",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  height: h * 0.085,
                  width: w * 0.88,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 205, 205, 205), // Đặt màu nền ở đây
                    borderRadius:
                        BorderRadius.circular(23), // Đặt độ cong của góc
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 26,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Nguyen Ngoc Linh",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                //Đăng nhập
                const Padding(padding: EdgeInsets.only(top: 50)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
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
                const Padding(padding: EdgeInsets.only(top: 100)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(w * 0.85, 50),
                    padding:
                        EdgeInsets.zero, // Loại bỏ padding mặc định của nút
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
