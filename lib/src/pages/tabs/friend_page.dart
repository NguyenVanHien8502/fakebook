import 'package:flutter/material.dart';

class FriendPage extends StatelessWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  hintText: "Click here to search...",
                  fillColor: Colors.white10,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Nội dung của trang bạn muốn hiển thị
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "999 friends",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Text(
                              "Sort",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: const Divider(
                          height: 1,
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Navigate to view detail your friend");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: const Text(
                                        "Nguyen Van Hien",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: const Text(
                                      "1 mutual friend",
                                      style: TextStyle(color: Colors.black),
                                    )),
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
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
