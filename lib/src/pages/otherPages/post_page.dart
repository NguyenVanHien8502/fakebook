import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tạo bài viết",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        // centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (textEditingController.text.isNotEmpty) {
              showConfirmationBottomSheet(context);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: TextButton(
                onPressed: () {
                  print("Post status");
                },
                child: const Text(
                  "Đăng",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 14, left: 18),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                        AssetImage('lib/src/assets/images/fakebook.png'),
                        radius: 26,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Nguyen Ngoc Linh",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print(1);
                                },
                                child: const Center(
                                  child: Text(
                                    "Công khai",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(
                                          0xFF016BF5), // Đặt màu chữ của nút
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Bạn đang nghĩ gì?",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    maxLines: null,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        height: 1.4),
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

void showConfirmationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Bạn muốn hoàn thành bài viết của mình sau ư?",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hãy lưu làm bản nháp hoặc tiếp tục chỉnh sửa.",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        // Xử lý khi dòng 1 được click
                        Navigator.of(context).pop(); // Đóng hộp thoại
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: const Row(
                          children: [
                            Icon(Icons.bookmark, size: 36),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Lưu làm bản nháp",
                                style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete_sharp,
                              size: 36,
                              color: Color.fromARGB(255, 223, 99, 90),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Bỏ bài viết", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.done,
                              size: 36,
                              color: Color.fromARGB(255, 0, 83, 250),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Tiếp tục chỉnh sửa",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 83, 250))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    },
  );
}
