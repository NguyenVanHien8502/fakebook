import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/manage_posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class EditPostPage extends StatefulWidget {
  final int postId;

  const EditPostPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  EditPostPageState createState() => EditPostPageState();
}

class SelectedImage {
  final String
      pathOrUrl; // Sử dụng một trường để chứa cả đường dẫn local và URL
  bool shouldDelete;

  SelectedImage({required this.pathOrUrl, required this.shouldDelete});
}

class SelectedVideo {
  final File file;
  bool shouldDelete;

  SelectedVideo(this.file, this.shouldDelete);
}

class EditPostPageState extends State<EditPostPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
    getPost();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  var post = {};

  Future<void> getPost() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.getPost);
      Map body = {"id": widget.postId};

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      responseBody = jsonDecode(response.body);
      print(responseBody['data']);
      setState(() {
        post = responseBody['data'];
        describedController.text = post['described'];
        if (post['image'].length > 0) {
          checkImageOrVideo = 1;
          for (var image in post['image']) {
            images.add(
                SelectedImage(pathOrUrl: image['url'], shouldDelete: false));
          }
        }
        if (post['video'] != null) {
          checkImageOrVideo = 2;
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  TextEditingController describedController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  int checkImageOrVideo =
      0; //0: chưa chọn image hoặc video, 1: đã chọn image, 2: đã chọn video

  //get images
  List<SelectedImage> images = [];

  Future<void> getImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();
    for (var selectedImage in selectedImages) {
      images.add(
          SelectedImage(pathOrUrl: selectedImage.path, shouldDelete: false));
    }
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        checkImageOrVideo = 1;
      });
    }
  }

  //get video
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(File(''));
  late File _video = File('');
  SelectedVideo? selectedVideo;

  Future<void> getVideo() async {
    final selectedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (selectedVideo == null) {
      print("Người dùng hủy chọn video");
      return;
    }
    print("Người dùng đã chọn video");
    _video = File(selectedVideo.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });

    // Chỉ lưu trữ video đã chọn
    setState(() {
      checkImageOrVideo = 2;
      this.selectedVideo = SelectedVideo(_video, false);
    });
  }

  Future<void> handleEditPost(BuildContext context, postId) async {
    String described = describedController.text;
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.editPost);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['id'] = widget.postId.toString();
      if (described.trim() != "") {
        request.fields['described'] = described;
      }

      //add image into request
      for (int i = 0; i < post['image'].length; i++) {
        for (var selectedImage in images) {
          if (selectedImage.pathOrUrl != post['image'][i]['url']) {
            if (!selectedImage.shouldDelete) {
              var stream = http.ByteStream(DelegatingStream.typed(
                  File(selectedImage.pathOrUrl).openRead()));
              var length = await File(selectedImage.pathOrUrl).length();
              var multipart = http.MultipartFile(
                'image',
                stream,
                length,
                filename: basename(selectedImage.pathOrUrl),
                contentType: MediaType('image', 'jpg'),
              );
              request.files.add(multipart);
            }
          }
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
    bool hasText = describedController.text.trim() != "";
    bool hasImages = images.isNotEmpty;
    bool hasVideo = _video.existsSync();
    return hasText || hasImages || hasVideo
        ? Colors.blueAccent
        : Colors.grey[200];
  }

  // vô hiệu hóa nút Đăng nếu không có thông tin gì về post
  bool isButtonEnabled() {
    bool hasText = describedController.text.trim() != "";
    bool hasImages = images.isNotEmpty;
    bool hasVideo = _video.existsSync();
    return hasText || hasImages || hasVideo;
  }

  bool hasImageChanges() {
    if (images.length != post['image'].length) {
      return true;
    }

    for (int i = 0; i < images.length; i++) {
      if (images[i].pathOrUrl != post['image'][i]['url']) {
        return true;
      }
    }

    return false;
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
            if (describedController.text.trim() != post['described'] ||
                hasImageChanges() ||
                _video.existsSync()) {
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

                //options when post
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
                            onTap:
                                checkImageOrVideo == 0 || checkImageOrVideo == 1
                                    ? () => getImages()
                                    : null,
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 16.0,
                                      color: checkImageOrVideo == 0 ||
                                              checkImageOrVideo == 1
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      'Chọn ảnh',
                                      style: TextStyle(
                                        color: checkImageOrVideo == 0 ||
                                                checkImageOrVideo == 1
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 16.0,
                                      color: checkImageOrVideo == 0 ||
                                              checkImageOrVideo == 1
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap:
                                checkImageOrVideo == 0 || checkImageOrVideo == 2
                                    ? () => getVideo()
                                    : null,
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
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 16.0,
                                      color: checkImageOrVideo == 0 ||
                                              checkImageOrVideo == 2
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Text(
                                      'Chọn video',
                                      style: TextStyle(
                                        color: checkImageOrVideo == 0 ||
                                                checkImageOrVideo == 2
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3.0,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 16.0,
                                      color: checkImageOrVideo == 0 ||
                                              checkImageOrVideo == 2
                                          ? Colors.blueAccent
                                          : Colors.grey,
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
                    cursorColor: Colors.black,
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

                // Hiển thị ảnh
                () {
                  return Container(
                    height: 1000,
                    margin: const EdgeInsets.all(25.0),
                    child: GridView.builder(
                      itemCount: images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (images.isNotEmpty) {
                          if (images[index].pathOrUrl.startsWith('https')) {
                            if (!images[index].shouldDelete) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child:
                                        Image.network(images[index].pathOrUrl),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          images.removeAt(index);
                                          if (images.isEmpty) {
                                            checkImageOrVideo = 0;
                                          }
                                        });

                                        //xóa image gửi lên server
                                        try {
                                          String? token =
                                              await storage.read(key: 'token');
                                          var url = Uri.parse(ListAPI.editPost);
                                          var request = http.MultipartRequest(
                                              'POST', url);
                                          request.headers['Authorization'] =
                                              'Bearer $token';
                                          request.headers['Content-Type'] =
                                              'multipart/form-data';
                                          request.fields['id'] =
                                              "${post['id']}";
                                          request.fields['image_del'] =
                                              "${index + 1}";

                                          var response = await request.send();
                                          final responseBody = await response
                                              .stream
                                              .bytesToString();
                                          final decodedResponse =
                                              jsonDecode(responseBody);
                                          print("abc: $decodedResponse");
                                        } catch (e) {
                                          print("Error when editing post: $e");
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        color: Colors.red,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container(); // Trả về container trống nếu ảnh đã bị xóa
                            }
                          } else {
                            if (!images[index].shouldDelete) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Image.file(
                                      File(images[index].pathOrUrl).absolute,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          images.removeAt(index);
                                          if (images.isEmpty) {
                                            checkImageOrVideo = 0;
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        color: Colors.red,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container(); // Trả về container trống nếu ảnh đã bị xóa
                            }
                          }
                        } else {
                          return Container(); // Trả về container trống nếu danh sách ảnh rỗng
                        }
                      },
                    ),
                  );
                }(),

                // Hiển thị video
                () {
                  if (_video != null &&
                      selectedVideo != null &&
                      !selectedVideo!.shouldDelete) {
                    if (_videoPlayerController != null &&
                        _videoPlayerController.value.isInitialized) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedVideo!.shouldDelete = true;
                                  _videoPlayerController =
                                      VideoPlayerController.file(File(''));
                                  _video = File('');
                                  checkImageOrVideo = 0;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: 10,
                      );
                    }
                  } else {
                    return Container();
                  }
                }(),
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
                          Text("Không chỉnh sửa nữa",
                              style: TextStyle(fontSize: 20)),
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
