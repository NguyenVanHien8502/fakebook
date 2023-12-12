import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/otherPages/manage_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class EditPostPage extends StatefulWidget {
  final int postId;
  final String described;

  const EditPostPage({
    Key? key,
    required this.postId,
    required this.described,
  }) : super(key: key);

  @override
  EditPostPageState createState() => EditPostPageState();
}

class EditPostPageState extends State<EditPostPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    // Gán giá trị của described cho controller khi trang được khởi tạo
    describedController.text = widget.described;

    getCurrentUserData();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  TextEditingController describedController = TextEditingController();

  List<XFile>? images = [];
  final ImagePicker imagePicker = ImagePicker();

  Future<void> getImages() async {
    if (images != null && images!.length > 4) {
      return;
    }
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      // images!.addAll(selectedImages.sublist(0, 4 - images!.length));
      images = selectedImages.sublist(0, min(selectedImages.length, 4));
    }
    setState(() {});
  }

  Future<void> handleEditPost(BuildContext context, postId) async {
    String described = describedController.text;
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.editPost);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['described'] = described;
      request.fields['id'] = widget.postId.toString();
      if (images != null && images!.isNotEmpty) {
        for (var selectedImage in images!) {
          var stream =
              http.ByteStream(DelegatingStream.typed(selectedImage.openRead()));
          var length = await selectedImage.length();
          var multipart = http.MultipartFile(
            'image',
            stream,
            length,
            filename: basename(selectedImage.path),
            contentType: MediaType('image', 'jpg'),
          );
          request.files.add(multipart);
        }
      }
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      print(decodedResponse);
      if (decodedResponse['code'] == '1000') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ManagePostsPage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: Text('${decodedResponse['message']}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print("Occur error:: $e");
    }
  }

  //thay đổi màu của button "Đăng" khi có text
  bool shouldEnableButton = false;

  Color? getButtonColor() {
    bool hasText = describedController.text.isNotEmpty;
    bool hasImages = images != null && images!.isNotEmpty;
    return hasText || hasImages ? Colors.blueAccent : Colors.grey[200];
  }

  // vô hiệu hóa nút Đăng nếu không có thông tin gì về post
  bool isButtonEnabled() {
    bool hasText = describedController.text.isNotEmpty;
    bool hasImages = images != null && images!.isNotEmpty;

    return hasText || hasImages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Chỉnh sửa bài viết",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        // centerTitle: true,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (describedController.text.isNotEmpty || images!.isNotEmpty) {
              showConfirmationBottomSheet(context);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  onTap: isButtonEnabled()
                      ? () => handleEditPost(context, widget.postId)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: getButtonColor(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Text(
                      'Cập nhật',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 14, left: 18),
                  child: Row(
                    children: [
                      currentUser != null
                          ? ClipOval(
                              child: Image.network(
                                '${jsonDecode(currentUser)['avatar']}',
                                height: 50,
                                width: 50,
                                fit: BoxFit
                                    .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                              ),
                            )
                          : const Image(
                              image: AssetImage(
                                  'lib/src/assets/images/avatar.jpg'),
                              height: 50,
                              width: 50,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          currentUser != null
                              ? Text(
                                  "${jsonDecode(currentUser)['username']}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(
                                  "Lỗi hiển thị username",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 70.0, top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {},
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.public,
                                        size: 12.0,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        'Công khai',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: getImages,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 16.0,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Text(
                                        'Album',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 16.0,
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 130.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5.0),
                          onTap: () {},
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 16.0,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Text(
                                    'Chọn cảm xúc',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.0,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 16.0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(
                  height: 1.0,
                  thickness: 0.1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    controller: describedController,
                    onChanged: (text) {
                      // Kiểm tra xem TextField có chứa ít nhất một ký tự hay không
                      setState(() {
                        shouldEnableButton = text.isNotEmpty;
                      });
                    },
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
                images != null && images!.isNotEmpty
                    ? Container(
                        height: 600,
                        margin: const EdgeInsets.all(25.0),
                        child: GridView.builder(
                          itemCount: images!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.all(5.0),
                              child: Image.file(
                                File(images![index].path).absolute,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(
                        height: 200,
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
  final scrollController = ScrollController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        controller:
            scrollController, // Thêm controller vào SingleChildScrollView
        physics: const ClampingScrollPhysics(), // Điều chỉnh tốc độ trượt lên
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                child: const Text(
                  "Bạn có muốn tiếp tục cập nhật?",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: [
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
                          Text("Không chỉnh sửa nữa", style: TextStyle(fontSize: 20)),
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
        ),
      );
    },
  );
}
