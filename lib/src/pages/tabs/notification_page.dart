import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/components/my_notification.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<MyNotification> notifications = [
      const MyNotification(
        avatarUrl: 'https://example.com/avatar1.jpg',
        content: 'Thông báo 1',
        timeAgo: '5 phút trước',
      ),
      // Thêm các thông báo khác tại đây
    ];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: AppBar(
            title: const Text("Thông báo"),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),

        //Body - phần thân thông báo
        body: const Column(
          children: <Widget>[MyButton(onTap: null, nameButton: "nameButton")],
        ));
  }
}
