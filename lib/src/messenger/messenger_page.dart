import 'package:fakebook/src/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({super.key});

  @override
  MessengerPageState createState() => MessengerPageState();
}

class MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,

      //Thân messenger
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 6),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Chat",
                      style: TextStyle(
                          fontSize: 30,
                          color: GlobalVariables.secondaryColor,
                          fontWeight: FontWeight.w800),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        print("hit");
                      }, // Sử dụng onPressed để xử lý khi được click
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color.fromARGB(255, 113, 95, 95)
                                .withOpacity(0.23),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Ionicons.camera,
                              color: GlobalVariables.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("hit");
                      }, // Sử dụng onPressed để xử lý khi được click
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color.fromARGB(255, 113, 95, 95)
                                .withOpacity(0.23),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: GlobalVariables.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                //search
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 237, 231, 231),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
