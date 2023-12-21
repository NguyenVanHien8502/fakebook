import 'dart:async';
import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/pages/otherPages/other_personal_page_screen.dart';
import 'package:fakebook/src/pages/otherPages/result_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistorySearchPage extends StatefulWidget {
  const HistorySearchPage({
    Key? key,
  }) : super(key: key);

  @override
  HistorySearchPageState createState() => HistorySearchPageState();
}

class HistorySearchPageState extends State<HistorySearchPage> {
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
      Map body = {"index": "0", "count": "1000"};

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
      print(responseBody['data']);
      setState(() {
        listHistorySearch.addAll(responseBody['data'] ?? []);
      });
    } catch (error) {
      print('Error fetching history search: $error');
    }
  }

  //delete single history search
  Future<void> handleDeleteSingleHistorySearch(int itemId) async {
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

  //delete all history search
  Future<void> handleDeleteAllHistorySearch() async {
    String? token = await storage.read(key: 'token');
    try {
      var url = Uri.parse(ListAPI.delSavedSearch);
      Map body = {"all": "1"};

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
      print(responseBody);
      if (responseBody['code'] == '1000') {
        Navigator.pop(context);
      }
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
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Lịch sử",
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 16.0, right: 16.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                          'Bạn có thực sự muốn xóa toàn bộ lịch sử tìm kiếm?'),
                      content: const Text(
                          'Nếu bạn xóa, bạn sẽ không thể khôi phục lại, bạn có chắc chắn về quyết định của mình?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Hủy',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            handleDeleteAllHistorySearch();
                            setState(() {
                              listHistorySearch.clear();
                            });
                          },
                          child: const Text(
                            'Có',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Xóa tất cả",
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: listHistorySearch.isNotEmpty
                      ? listHistorySearch.map((item) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
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
                                          formatTimeDifference(item['created']),
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        int itemId = int.parse(item['id']);
                                        handleDeleteSingleHistorySearch(itemId);
                                        setState(() {
                                          listHistorySearch.removeWhere(
                                              (element) => element == item);
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
