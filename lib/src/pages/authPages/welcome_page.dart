import 'package:fakebook/src/components/my_button.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
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
            children: [
              Image(
                image: const AssetImage('lib/src/assets/images/welcome.jpg'),
                width: w * 0.8,
                height: h * 0.8,
              ),
              const Text(
                'Join with us & Enjoy healthy life',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10,),
              MyButton(
                nameButton: "Next",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                icon: const Icon(Icons.arrow_right),
              )
            ],
          ),
        ))));
  }
}
