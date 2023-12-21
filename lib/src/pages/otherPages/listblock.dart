import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BlockPage extends StatefulWidget {
  const BlockPage({Key? key}) : super(key: key);

  @override
  State<BlockPage> createState() => BlockPageState();
}

class BlockPageState extends State<BlockPage> {
  List<User> listBlock = [];
  String totalBlock = "";

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> getListBlock(BuildContext context) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getListBlocks);
        Map body = {"index": "0", "count": "20"};

        //print(body);

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
            final List<dynamic> listfriendsData = responseBody['data'];

            setState(() {
              listBlock = listfriendsData.map((item) {
                return User(
                  id: item['id'].toString() ?? '1',
                  name: item['name'].toString() ?? 'name',
                  avatar: item['avatar'] == null
                      ? 'lib/src/assets/images/avatarfb.jpg'
                      : item['avatar'],
                );
              }).toList();
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

  @override
  void initState() {
    super.initState();
    getListBlock(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Danh sách Chặn",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),

          //Danh sach chan
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //List Block
                    for (int i = 0; i < listBlock.length; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(listBlock[i].avatar),
                                radius: 25,
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
                                      child: Text(
                                        listBlock[i].name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )),
                              ],
                            ),
                            const Spacer(),
                            // dùng cái này để icon xuống phía bên phải cùng của row
                            Container(
                              margin: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  showConfirmationBottomSheet(context,
                                      listBlock[i].name, listBlock[i].id);
                                },
                                child: const Icon(
                                  Icons.more_horiz,
                                  size: 20.0,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

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
                    // InkWell(
                    //   onTap: () {
                    //     // Xử lý khi dòng 1 được click
                    //     Navigator.of(context).pop(); // Đóng hộp thoại
                    //   },
                    //   child: Container(
                    //     padding: const EdgeInsets.only(left: 16),
                    //     height: 60,
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           width: 40, // Đặt kích thước vòng tròn
                    //           height: 40,
                    //           decoration: const BoxDecoration(
                    //             shape: BoxShape
                    //                 .circle, // Đặt hình dạng thành hình tròn
                    //             color: Colors.grey, // Màu nền của vòng tròn
                    //           ),
                    //           child: const Icon(
                    //             FontAwesome5Brands
                    //                 .facebook_messenger, // Biểu tượng bạn muốn đặt trong vòng tròn
                    //             color: Colors.white, // Màu biểu tượng
                    //             size: 24, // Kích thước biểu tượng
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text("Nhắn tin cho ${name}",
                    //             style: TextStyle(fontSize: 20)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        handleunBlock(name, id);
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
                                    .unlock, // Biểu tượng bạn muốn đặt trong vòng tròn
                                color: Colors.white, // Màu biểu tượng
                                size: 24, // Kích thước biểu tượng
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Huỷ chặn ${name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w600, // Đặt font in đậm
                                    fontFamily:
                                        "FacebookFont", // Đặt font chữ của Facebook
                                  ),
                                ),
                                // const Padding(
                                //   padding: EdgeInsets.all(4),
                                // ),
                                // Flexible(
                                //   child: Column(
                                //     children: [
                                //       Text(
                                //         "sẽ không thể thấy bạn hoặc ",
                                //         style: const TextStyle(
                                //           fontSize: 14,
                                //           fontFamily: "FacebookFont",
                                //         ),
                                //         overflow: TextOverflow.ellipsis,
                                //         maxLines: 2,
                                //       ),
                                //     ],
                                //   ),
                                // )
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

  Future<void> handleunBlock(String name, String id) async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hủy chặn với ${name}'),
          content: Text('Bạn có chắc muốn hủy chặn với ${name} không?'),
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
                unBlockFriend(context, id);
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

  Future<void> unBlockFriend(BuildContext context, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.unBlock);
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
              listBlock.removeWhere((friend) => friend.id == id);
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
}
