import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    /////
    return Scaffold(
        body: Column(
      children: <Widget>[
        /// Menu và cài đặt
        Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Menu",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                  ),
                  const Icon(Icons.search, size: 30),
                ],
              ),
            ],
          ),
        ),
        // Trang cá nhân
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/personal-page");
          },
          child: Container(
            padding: const EdgeInsets.only(left: 12),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('lib/src/assets/images/fakebook.png'),
                  radius: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Nguyen Van A",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Icon(Icons.downhill_skiing)
              ],
            ),
          ),
        ),
        const Spacer(),
        // Nút Đăng xuất
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
          child: const Text("Đăng xuất"),
        )
      ],
    ));
  }
}
