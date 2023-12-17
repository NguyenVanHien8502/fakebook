import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class ListSaved {
  final String id;
  final String keyword;
  final String created;
  int del = 0;

  ListSaved({required this.id, required this.keyword, required this.created});

  void updateIsSearch(int newStatus) {
    del = newStatus;
  }
}

class SearchPageState extends State<SearchPage> {
  User user = User(
      id: "36",
      name: "Nguyễn Ngọc Linh",
      avatar: 'lib/src/assets/images/avatar.jpg');

  bool isSearch = false;

  List<ListSaved> listSaved = [];

  TextEditingController _searchController = TextEditingController();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }

  Future<void> handleSearch(
      BuildContext context, String value, String id) async {
    try {
      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.search);
        Map body = {
          "keyword": value,
          "user_id": id,
          "index": "0",
          "count": "20"
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

            return print(responseBody['data']);
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

  Future<void> getSavedSearch(
      BuildContext context) async {
    try {
      await initializeDateFormatting();

      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.getSavedSearch);
        Map body = {
          "index": "0",
          "count": "10"
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
            final List<dynamic> listSavedSearch = responseBody['data'];
            setState(() {
              listSaved = listSavedSearch.map((item) {
                final createdDateTime = DateTime.parse(item['created']);
                final now = DateTime.now();
                final difference = now.difference(createdDateTime);

                return ListSaved(
                  id: item['id'].toString(),
                  keyword: item['keyword'].toString(),
                  created: formatDuration(difference),
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

  Future<void> delSearch(
      BuildContext context, String idSearch, int index) async {
    try {
      await initializeDateFormatting();

      String? token = await getToken();
      if (token != null) {
        var url = Uri.parse(ListAPI.delSavedSearch);
        Map body = {
          "search_id": idSearch,
          "all": "0"
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
              listSaved[index].updateIsSearch(1);
            });
            print("Đã xóa");
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
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    getSavedSearch(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleSpacing: 0,
        //xóa bỏ khoảng cách mặc định giữa icontheme và title
        title: Container(
          margin: const EdgeInsets.only(right: 16.0, top: 5.0),
          width: 290,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey.withOpacity(0.1), // Đổi màu background tại đây
          ),
          child: TextField(
            controller: _searchController,
            onSubmitted: (value) {
              // Gọi hàm xử lý khi nhấn Enter
              handleSearch(context, value, user.id);
            },
            autofocus: true,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Search...',
              contentPadding:
                  const EdgeInsets.only(left: 16.0, bottom: 10.0, top: 25.0),
              hintStyle: const TextStyle(color: Colors.blueGrey),
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
              // contentPadding: EdgeInsets.zero,
            ),
            cursorColor: Colors.black,
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(
              height: 1,
              color: Colors.black12,
              thickness: 3,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      // Nội dung của trang bạn muốn hiển thị
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gần đây",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Text(
                              "Xem tất cả",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                      //Content Saved search
                      if (isSearch)
                        Text("Linh")
                      else
                        ListView(
                          shrinkWrap: true,
                          children: List.generate(
                            listSaved.length,
                                (index) => InkWell(
                              onTap: () {
                                // Xử lý khi người dùng nhấn vào một phần tử trong danh sách
                                print("Item tapped: ${listSaved[index].keyword}");
                              },
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 24.0),
                                title: listSaved[index].del == 0 ?
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listSaved[index].keyword,
                                          style:const TextStyle(fontSize: 16),
                                        ),
                                        const Padding(padding:EdgeInsets.only(top:6)),
                                        Text(
                                          listSaved[index].created,
                                          style:const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )
                                   : Text("Đã xóa"),
                                trailing: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    delSearch(context, listSaved[index].id, index);
                                  },
                                ),
                              ),
                            ),
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


  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} ngày trước';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} giờ trước';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} phút trước';
    } else {
      return 'vừa xong';
    }
  }
}
