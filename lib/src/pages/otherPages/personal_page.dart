import 'package:fakebook/src/components/my_button.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Facebook"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 24, right: 12, top: 10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "638 bạn bè",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "If you want to",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  MyButton(onTap: null, nameButton: "Thêm vào tin")
                ],
              ),
            ),
          ],
        ));
  }
}
