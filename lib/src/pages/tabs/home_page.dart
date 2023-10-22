import 'package:flutter/material.dart';

import '../../components/my_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Image(
                        image: const AssetImage(
                            'lib/src/assets/images/avatar.jpg'),
                        height: h * 0.15,
                        width: w * 0.15,
                      ),
                    ),
                    const Expanded(
                        child: MyTextField(
                      hintText: "What are you thinking?...",
                      obscureText: false,
                      hintPading: EdgeInsets.only(left: 10.0),
                    )),
                    Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          print("navigate to album");
                        },
                        child: const Icon(
                          Icons.photo_library_outlined,
                          size: 30.0,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                  thickness: 3,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0),
                          child: Image(
                            image: const AssetImage(
                                'lib/src/assets/images/avatar.jpg'),
                            height: h * 0.15,
                            width: w * 0.15,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 16.0),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: const Text(
                                    "Top Comment",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )),
                            const Text("1 day ago")
                          ],
                        ),
                        const Spacer(),
                        // dùng cái này để icon xuống phía bên phải cùng của row
                        Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              print("Options");
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
                      child: const Text(
                        "Hello everyone, our status is written here... Hope you don't disappoint me :v",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions_outlined,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.thumb_up,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 20.0,
                              ),
                              Text("99")
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: const Text("123 comments"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: const Text("456 shares"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I liked this post");
                            },
                            child: const Text(
                              "Like",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I commented this post");
                            },
                            child: const Text(
                              "Comment",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I shared this post");
                            },
                            child: const Text(
                              "Share",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0),
                          child: Image(
                            image: const AssetImage(
                                'lib/src/assets/images/avatar.jpg'),
                            height: h * 0.15,
                            width: w * 0.15,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 16.0),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: const Text(
                                    "Top Comment",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )),
                            const Text("1 day ago")
                          ],
                        ),
                        const Spacer(),
                        // dùng cái này để icon xuống phía bên phải cùng của row
                        Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              print("Options");
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
                      child: const Text(
                        "Hello everyone, our status is written here... Hope you don't disappoint me :v",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions_outlined,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.thumb_up,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 20.0,
                              ),
                              Text("99")
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: const Text("123 comments"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: const Text("456 shares"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I liked this post");
                            },
                            child: const Text(
                              "Like",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I commented this post");
                            },
                            child: const Text(
                              "Comment",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I shared this post");
                            },
                            child: const Text(
                              "Share",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 3,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0),
                          child: Image(
                            image: const AssetImage(
                                'lib/src/assets/images/avatar.jpg'),
                            height: h * 0.15,
                            width: w * 0.15,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 16.0),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: const Text(
                                    "Top Comment",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                )),
                            const Text("1 day ago")
                          ],
                        ),
                        const Spacer(),
                        // dùng cái này để icon xuống phía bên phải cùng của row
                        Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              print("Options");
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 12.0),
                      child: const Text(
                        "Hello everyone, our status is written here... Hope you don't disappoint me :v",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0, top: 12.0),
                      child: const Image(
                        image: AssetImage('lib/src/assets/images/avatar.jpg'),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions_outlined,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.thumb_up,
                                size: 20.0,
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 20.0,
                              ),
                              Text("99")
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0, top: 5.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: const Text("123 comments"),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16.0),
                                child: const Text("456 shares"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I liked this post");
                            },
                            child: const Text(
                              "Like",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I commented this post");
                            },
                            child: const Text(
                              "Comment",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              print("I shared this post");
                            },
                            child: const Text(
                              "Share",
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: const Divider(
                        height: 1,
                        color: Colors.black12,
                        thickness: 3,
                      ),
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
