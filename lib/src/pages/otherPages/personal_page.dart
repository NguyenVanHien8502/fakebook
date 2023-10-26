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
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 200),
              CircleAvatar(
                backgroundImage:
                    AssetImage('lib/src/assets/images/fakebook.png'),
                radius: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
