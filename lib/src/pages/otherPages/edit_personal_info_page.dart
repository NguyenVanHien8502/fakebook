import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:async/async.dart';
import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/manage_posts_page.dart';
import 'package:fakebook/src/pages/otherPages/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class EditPersonalInfoPage extends StatefulWidget {
  const EditPersonalInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  EditPersonalInfoPageState createState() => EditPersonalInfoPageState();
}

class EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  dynamic currentUser;
  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    print(newData);
    setState(() {
      currentUser = newData;
      usernameController.text = jsonDecode(currentUser)['username'] ?? '';
      descriptionController.text = jsonDecode(currentUser)['description'] ?? '';
      addressController.text = jsonDecode(currentUser)['address'] ?? '';
      cityController.text = jsonDecode(currentUser)['city'] ?? '';
      countryController.text = jsonDecode(currentUser)['country'] ?? '';
      linkController.text = jsonDecode(currentUser)['link'] ?? '';
    });
  }

  File? avatar;
  final _pickerAvatar = ImagePicker();

  Future getAvatar() async {
    final pickedFile = await _pickerAvatar.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        avatar = File(pickedFile.path);
      });
    } else {
      print("No avatar selected");
    }
  }

  File? coverImage;
  final _pickerCoverImage = ImagePicker();

  Future getCoverImage() async {
    final pickedFile = await _pickerCoverImage.pickImage(
        source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    } else {
      print("No avatar selected");
    }
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  Future<void> handleEditPersonalInfo(BuildContext context) async {
    String username = usernameController.text;
    String description = descriptionController.text;
    String address = addressController.text;
    String city = cityController.text;
    String country = countryController.text;
    String link = linkController.text;
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.setUserInfo);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.fields['username'] = username;
      request.fields['description'] = description;
      request.fields['address'] = address;
      request.fields['city'] = city;
      request.fields['country'] = country;
      request.fields['link'] = link;
      if (avatar != null) {
        var stream = http.ByteStream(DelegatingStream.typed(avatar!.openRead()));
        var length = await avatar!.length();
        var multipart = http.MultipartFile('avatar', stream, length,
            filename: basename(avatar!.path),
            contentType: MediaType('avatar', 'jpg'));
        request.files.add(multipart);
      }
      if (coverImage != null) {
        var stream = http.ByteStream(DelegatingStream.typed(coverImage!.openRead()));
        var length = await coverImage!.length();
        var multipart = http.MultipartFile('cover_image', stream, length,
            filename: basename(coverImage!.path),
            contentType: MediaType('cover_image', 'jpg'));
        request.files.add(multipart);
      }
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);
      if (decodedResponse['code'] == '1000') {
        var userId = decodedResponse['data']['id'];
        var url = Uri.parse(ListAPI.getUserInfo);
        Map body = {
          "user_id": userId,
        };

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final getUserInfo = jsonDecode(response.body);
        if (response.statusCode == 201) {
          if (getUserInfo['code'] == '1000') {
            var currentUser = getUserInfo['data'];
            var currentUserJson = jsonEncode(currentUser);
            await storage.write(key: 'currentUser', value: currentUserJson);
          }
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content:
              const Text('Chúc mừng! Đã cập nhật thông tin  cá nhân thành công.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
              content: const Text('An error occurred!'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Chỉnh sửa thông tin cá nhân",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        // centerTitle: true,
        toolbarHeight: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Divider(
                thickness: 1,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15.0,
              ),

              //avatar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ảnh đại diện",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: getAvatar,
                      child: const Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: avatar == null
                    ? ClipOval(
                        child: Image.network(
                          '${jsonDecode(currentUser)['avatar']}',
                          height: 200,
                          width: 200,
                          fit: BoxFit
                              .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          File(avatar!.path).absolute,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                height: 1.0,
                thickness: 0.1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15.0,
              ),

              //cover image
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ảnh bìa",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: getCoverImage,
                      child: const Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: coverImage == null
                    ? ((jsonDecode(currentUser)['cover_image'] is String &&
                            jsonDecode(currentUser)['cover_image'] != "")
                        ? ClipOval(
                            child: Image.network(
                              '${jsonDecode(currentUser)['cover_image']}',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Image(
                            image: AssetImage(
                              'lib/src/assets/images/avatar.jpg',
                            ),
                            height: 200,
                            width: 200,
                          ))
                    : ClipOval(
                        child: Image.file(
                          File(coverImage!.path).absolute,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                height: 1.0,
                thickness: 0.1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 15.0,
              ),

              //username
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Username *:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Username của bạn",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //description
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: descriptionController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Nhập description",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //address
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Address: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Nhập address",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //city
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "City: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Nhập city",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //country
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Country: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: countryController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Nhập country",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //link
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Link: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: linkController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          fillColor: Colors.white10,
                          filled: true,
                          hintText: "Nhập link",
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              //button update
              Container(
                margin: const EdgeInsets.only(right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: (){
                              handleEditPersonalInfo(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

