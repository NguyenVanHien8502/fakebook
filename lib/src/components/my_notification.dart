import 'package:flutter/material.dart';

class MyNotification extends StatelessWidget {
  final String avatarUrl;
  final String content;
  final String timeAgo;

  const MyNotification({super.key,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(content),
      subtitle: Text(timeAgo),
    );
  }
}
