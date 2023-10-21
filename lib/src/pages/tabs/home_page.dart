import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List<String> posts = []; // Danh sách các bài viết từ API

  @override
  void initState() {
    super.initState();
    // Gọi hàm để tải danh sách bài viết từ API và cập nhật vào biến 'posts'
    loadPostsFromAPI();
  }

  // Hàm để tải danh sách bài viết từ API (đã thay thế bằng dữ liệu mẫu ở đây)
  void loadPostsFromAPI() {
    setState(() {
      posts = List.generate(20, (index) => "Post $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Heading
          Container(
            padding: const EdgeInsets.only(top: 8, left: 16),
            child: const Column(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('lib/src/assets/images/fakebook.png'),
                  radius: 20,
                ),
                Icon(Icons.photo_library)
              ],
            ),
          ),
          // Danh sách các bài viết từ API
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]),
                  subtitle: Text("This is the content of ${posts[index]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
