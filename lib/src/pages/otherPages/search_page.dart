import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/history_search_page.dart';
import 'package:fakebook/src/pages/otherPages/result_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getHistorySearch();
  }

  //get history search
  var listHistorySearch = [];

  Future<void> getHistorySearch() async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.getSavedSearch);
      Map body = {"index": "0", "count": "10"};

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
      // print(responseBody['data']);
      setState(() {
        listHistorySearch.addAll(responseBody['data'] ?? []);
      });
    } catch (error) {
      print('Error fetching history search: $error');
    }
  }

  //delete history search
  Future<void> handleDeleteHistorySearch(int itemId) async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.delSavedSearch);
      Map body = {"search_id": "$itemId", "all": "0"};

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
      // print(responseBody);

    } catch (error) {
      print('Error delete history search: $error');
    }
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
            onSubmitted: (keyword) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultSearchPage(
                    keyword: keyword,
                  ),
                ),
              );
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

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gần đây",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistorySearchPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Xem tất cả",
                                style:
                                TextStyle(color: Colors.blue, fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      //history search
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: listHistorySearch.isNotEmpty
                              ? listHistorySearch.map((item) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ResultSearchPage(
                                                keyword: item['keyword'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${item['keyword']}",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  formatTimeDifference(
                                                      item['created']),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                int itemId =
                                                int.parse(item['id']);
                                                handleDeleteHistorySearch(itemId);
                                                setState(() {
                                                  listHistorySearch.removeWhere((element) => element == item);
                                                });
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 18.0,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  );
                                }).toList()
                              : [
                                  const Center(
                                    child: Text("Lịch sử tìm kiếm rỗng"),
                                  )
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

  String formatTimeDifference(String createdAt) {
    DateTime createdDateTime = DateTime.parse(createdAt);
    Duration difference = DateTime.now().difference(createdDateTime);

    if (difference.inDays > 7) {
      return DateFormat('dd/MM/yyyy').format(createdDateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}
