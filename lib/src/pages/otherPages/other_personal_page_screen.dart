import 'dart:math';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class OtherPersonalPageScreen extends StatefulWidget {
  static const String routeName = '/other-personal-page';
  final String userId;

  const OtherPersonalPageScreen({super.key, required this.userId});

  @override
  State<OtherPersonalPageScreen> createState() =>
      _OtherPersonalPageScreenState();
}

class _OtherPersonalPageScreenState extends State<OtherPersonalPageScreen> {
  final TextEditingController searchController = TextEditingController();
  final Random random = Random();
  User? user;
  bool isMine = false;
  int mutualFriends = 0;
  String name = "Facebook";

  String isFriend = '-1';

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> getInfoUser(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getUserInfo);
        Map body = {
          "user_id": id,
        };

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 201) {
          if (responseBody['code'] == '1000') {
            setState(() {
              user = User(
                id: responseBody['data']['id'],
                name: responseBody['data']['username'],
                avatar: responseBody['data']['avatar'] ??
                    'lib/src/assets/images/avatarfb.jpg',
                cover: responseBody['data']['cover'] ??
                    'lib/src/assets/images/avatarfb.jpg',
                description: responseBody['data']['description'],
                address: responseBody['data']['address'],
                hometown: responseBody['data']['city'],
                friends: responseBody['data']['is_friend'],
                bio: responseBody['data']['link'],
              );

              isFriend = responseBody['data']['is_friend'] ?? ' ';
              name = responseBody['data']['username'];
            });
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  Future<void> requestFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.setRequestFriend);
        Map body = {
          "user_id": id,
        };

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            return print("Đã gửi lời mời kết bạn");
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  Future<void> delRequestFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.delRequestFriend);
        Map body = {
          "user_id": id,
        };

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            // setState(() {
            //   friendRequests[index].updateIsFriend(2);
            // });
            return print("Đã xóa lời mời kết bạn");
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  Future<void> accecptFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.setAcceptFriend);
        Map body = {
          "user_id": id,
          "is_accept": "1",
        };

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            return print("Đã chấp nhận kết bạn");
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoUser(context, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: Colors.black12,
                width: double.infinity,
                height: 0.5,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              splashRadius: 20,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Tìm kiếm',
                        hintStyle: const TextStyle(
                          color: Colors.blueGrey,
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10,
                          ),
                          child: Icon(
                            Icons.search_rounded,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 45, maxHeight: 41),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      cursorColor: Colors.black,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //////////
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Avtar + anh bia
                  Stack(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 270,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: Image.network(
                          user!.cover ?? "",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.grey,
                      ),
                      Positioned(
                        left: 12,
                        bottom: 0,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user!.avatar),
                                radius: 75,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Mô tả cá nhân
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          user!.description ?? "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 5.0,
                  ),

                  //Theem ban be
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isFriend == '0')
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                requestFriend(context, widget.userId);
                                setState(() {
                                  isFriend = '2';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Thêm bạn bè',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (isFriend == '1')
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesome5Brands.facebook_messenger,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Bạn bè',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (isFriend == '2')
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                delRequestFriend(context, widget.userId);
                                setState(() {
                                  isFriend = '0';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Đã gửi lời mời',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (isFriend == '3')
                          Expanded(
                            flex: 4,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                accecptFriend(context, widget.userId);
                                setState(() {
                                  isFriend = '1';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Chấp nhận',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesome5Brands.facebook_messenger,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Nhắn tin',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (isFriend == '1')
                              showConfirmationBottomSheet(
                                  context, name, widget.userId);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 16.0),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.school_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Sinh viên năm 4 tại ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Sống tại "
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Đại học Bách Khoa Hà Nội - Hanoi University of Science and Technology',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        // In đậm cho phần văn bản "Quận Hai Bà Trưng"
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Quận Hai Bà Trưng"
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Số dòng tối đa trước khi xuống dòng
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.house_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Sống tại ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Sống tại "
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${user!.address ?? 'Hà Nội'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        // In đậm cho phần văn bản "Quận Hai Bà Trưng"
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Quận Hai Bà Trưng"
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Số dòng tối đa trước khi xuống dòng
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Đến từ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Sống tại "
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${user!.hometown ?? 'Hà Nội'}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        // In đậm cho phần văn bản "Quận Hai Bà Trưng"
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Quận Hai Bà Trưng"
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Số dòng tối đa trước khi xuống dòng
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 5,
                              ),
                              child: ImageIcon(
                                AssetImage('lib/src/assets/images/wifi.png'),
                                size: 20,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Có 5.000 người đang theo dõi.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors
                                            .black, // Màu cho phần văn bản "Sống tại "
                                      ),
                                    ),
                                  ],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Số dòng tối đa trước khi xuống dòng
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Xem thông tin giới thiệu của Han",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 16.0),
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_rounded,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Ảnh',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
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
          ),
        ),
      );
    }
  }

  ////
  void showConfirmationBottomSheet(
      BuildContext context, String name, String id) {
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
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                FontAwesome5Brands
                                    .facebook_messenger, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Nhắn tin cho ${name}",
                                style: const TextStyle(fontSize: 20)),
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
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                Icons
                                    .star, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bỏ theo dõi ${name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w600, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                const Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        handleBlock(name, id);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.grey, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                FontAwesome
                                    .user_secret, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chặn ${name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w600, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                const Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        handledelete(name, id);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: 60,
                        child: Row(
                          children: [
                            Container(
                              width: 40, // Đặt kích thước vòng tròn
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape
                                    .circle, // Đặt hình dạng thành hình tròn
                                color: Colors.white, // Màu nền của vòng tròn
                              ),
                              child: const Icon(
                                Ionicons
                                    .person_remove, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.red, // Màu biểu tượng
                                size: 26, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hủy kết bạn với ${name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight:
                                        FontWeight.w400, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4),
                                ),
                                const Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        "sẽ không thể thấy bạn hoặc ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "FacebookFont",
                                          color: Colors.red,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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

  Future<void> handleBlock(String name, String id) async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Chặn trang cá nhân của ${name}'),
          content: const Text(
              'Những người bạn chặn sẽ không thể gắn thẻ hay mời tham gia nhóm hoặc sự kiện, cũng không thể bắt đầu trò chuyện.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Huỷ',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                blockFriend(context, id);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Xác nhận',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> handledelete(String name, String id) async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hủy kết bạn với ${name}'),
          content: Text('Bạn có chắc muốn hủy kết bạn với ${name} không?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Huỷ',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteFriend(context, id);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Xác nhận',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.unfriend);
        Map body = {
          "user_id": id,
        };

        print(body);

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            setState(() {
              isFriend = '0';
            });
            return print("Đã xóa");
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }

  Future<void> blockFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.setBlock);
        Map body = {
          "user_id": id,
        };

        http.Response response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body),
        );

        // Chuyển chuỗi JSON thành một đối tượng Dart
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseBody['code'] == '1000') {
            return print("Đã block");
          } else {
            print('API returned an error: ${responseBody['message']}');
          }
        } else {
          print('Failed to load friends. Status Code: ${response.statusCode}');
        }
      } else {
        print("No token");
      }
    } catch (error) {
      print('Error fetching friends: $error');
    }
  }
}
