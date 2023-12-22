import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/otherPages/buy_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  TextEditingController describedController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  //get images
  List<XFile>? images = [];

  Future<void> getImages() async {
    if (images!.length > 4) {
      return;
    }
    final List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      // images!.addAll(selectedImages.sublist(0, 4 - images!.length));
      images = selectedImages.sublist(0, min(selectedImages.length, 4));
    }
    setState(() {});
  }

  //get video
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(File(''));
  late File _video = File('');

  getVideo() async {
    final selectedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo == null) {
      print("Người dùng hủy chọn video");
      return;
    }
    print("Người dùng đã chọn video");
    _video = File(selectedVideo!.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  Future<void> handleAddPost(BuildContext context) async {
    String described = describedController.text;
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.addPost);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['described'] = described;

      //add image into request
      if (images!.isNotEmpty) {
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

      //add video into request
      if (_video.existsSync()) {
        var videoStream =
            http.ByteStream(DelegatingStream.typed(_video.openRead()));
        var videoLength = await _video.length();
        var videoMultipart = http.MultipartFile(
          'video',
          videoStream,
          videoLength,
          filename: basename(_video.path),
          contentType: MediaType('video', 'mp4'),
        );
        request.files.add(videoMultipart);
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      print(decodedResponse);
      if (decodedResponse['code'] == '1000') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text('Bạn đã đăng bài viết thành công.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      HomeScreen.routeName,
                    );
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BuyCoins()));
                  },
                  child: const Text(
                    'MUA COINS',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
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
      print("Occur error when posting:: $e");
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
          "Tạo bài viết",
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
                  onTap:
                      isButtonEnabled() ? () => handleAddPost(context) : null,
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
                      'Đăng',
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

                //avatar + username
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

                // options khi đăng bài
                Container(
                  margin: const EdgeInsets.only(left: 70.0, top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
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
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
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
                                      'Chọn ảnh',
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
                          const SizedBox(
                            width: 8.0,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: getVideo,
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
                                      'Chọn video',
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

                //description of post
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
                      isDense: true,
                      hintText: "Bạn đang nghĩ gì?",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    cursorColor: Colors.black,
                    maxLines: null,
                    style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        height: 1.4),
                  ),
                ),

                //hiển thị ảnh
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
                        height: 80,
                      ),

                // Hiển thị video
                if (_video != null)
                  _videoPlayerController.value.isInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _videoPlayerController.value.isPlaying
                                      ? _videoPlayerController.pause()
                                      : _videoPlayerController.play();
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Icon(
                                  _videoPlayerController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 60.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 10,
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
        ),
      );
    },
  );
}
