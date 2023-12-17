import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:fakebook/src/pages/authPages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  final int postId;

  const ReportPage({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  static const storage = FlutterSecureStorage();

  final TextEditingController detailsController = TextEditingController();

  Map<String, bool> isClickedButtonMap = {
    "Ảnh khỏa thân": false,
    "Bạo lực": false,
    "Quấy rối": false,
    "Tự tử/Tự gây thương tích": false,
    "Tin giả": false,
    "Bán hàng trái phép": false,
    "Ngôn từ gây thù ghét": false,
    "Khủng bố": false,
    "Spam": false,
    "Vấn đề khác": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        // Đặt màu của mũi tên quay lại thành màu đen
        centerTitle: true,
        title: const Text(
          "Báo cáo bài viết",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Vui lòng chọn vấn đề để tiếp tục",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Bạn có thể báo cáo bài viết sau khi chọn vấn đề.",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Ảnh khỏa thân'] =
                                    !isClickedButtonMap['Ảnh khỏa thân']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Ảnh khỏa thân'] !=
                                    null) {
                                  if (isClickedButtonMap['Ảnh khỏa thân'] ==
                                      true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Ảnh khỏa thân",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Bạo lực'] =
                                    !isClickedButtonMap['Bạo lực']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Bạo lực'] != null) {
                                  if (isClickedButtonMap['Bạo lực'] == true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Bạo lực",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Quấy rối'] =
                                    !isClickedButtonMap['Quấy rối']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Quấy rối'] != null) {
                                  if (isClickedButtonMap['Quấy rối'] == true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Quấy rối",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Tự tử/Tự gây thương tích'] =
                                    !isClickedButtonMap[
                                        'Tự tử/Tự gây thương tích']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap[
                                        'Tự tử/Tự gây thương tích'] !=
                                    null) {
                                  if (isClickedButtonMap[
                                          'Tự tử/Tự gây thương tích'] ==
                                      true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Tự tử/Tự gây thương tích",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Tin giả'] =
                                    !isClickedButtonMap['Tin giả']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Tin giả'] != null) {
                                  if (isClickedButtonMap['Tin giả'] == true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Tin giả",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Bán hàng trái phép'] =
                                    !isClickedButtonMap['Bán hàng trái phép']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Bán hàng trái phép'] !=
                                    null) {
                                  if (isClickedButtonMap[
                                          'Bán hàng trái phép'] ==
                                      true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Bán hàng trái phép",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Ngôn từ gây thù ghét'] =
                                    !isClickedButtonMap[
                                        'Ngôn từ gây thù ghét']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap[
                                        'Ngôn từ gây thù ghét'] !=
                                    null) {
                                  if (isClickedButtonMap[
                                          'Ngôn từ gây thù ghét'] ==
                                      true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Ngôn từ gây thù ghét",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Khủng bố'] =
                                    !isClickedButtonMap['Khủng bố']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Khủng bố'] != null) {
                                  if (isClickedButtonMap['Khủng bố'] == true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Khủng bố",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Spam'] =
                                    !isClickedButtonMap['Spam']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Spam'] != null) {
                                  if (isClickedButtonMap['Spam'] == true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Spam",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isClickedButtonMap['Vấn đề khác'] =
                                    !isClickedButtonMap['Vấn đề khác']!;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: () {
                                if (isClickedButtonMap['Vấn đề khác'] != null) {
                                  if (isClickedButtonMap['Vấn đề khác'] ==
                                      true) {
                                    return Colors.blue;
                                  } else {
                                    return Colors.grey;
                                  }
                                }
                              }(), // Màu nền
                              onPrimary: Colors.white, // Màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Độ cong của góc
                              ),
                              elevation: 0.75, // Độ đổ bóng
                            ),
                            child: const Text(
                              "Vấn đề khác",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Chi tiết báo cáo:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      Text(
                        "Bạn có thể viết những lời bạn muốn nhắn nhủ với chúng tôi xuống đây.",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: false,
                    controller: detailsController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Enter here...',
                      contentPadding: const EdgeInsets.only(left: 20.0),
                      hintStyle: const TextStyle(color: Colors.blueGrey),
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
                      prefixIcon: const Icon(
                        Icons.warning,
                        color: Colors.black54,
                      ),
                    ),
                    cursorColor: Colors.black,
                    //chỉnh màu của cái vạch nháy
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const SizedBox(
                  height: 200.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      handleReport();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(370, 50),
                      primary: Colors.blueGrey,
                      // Màu nền
                      onPrimary: Colors.white,
                      // Màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Độ cong của góc
                      ),
                      elevation: 0.75, // Độ đổ bóng
                    ),
                    child: const Text(
                      "Xác nhận báo cáo",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
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

  Future<void> handleReport() async {
    String? token = await storage.read(key: 'token');
    String details = detailsController.text;
    List<String> selectedOptionsReport = [];
    isClickedButtonMap.forEach((key, value) {
      if (value == true) {
        selectedOptionsReport.add(key);
      }
    });
    String subject = selectedOptionsReport.join(", ");
    try {
      var url = Uri.parse(ListAPI.reportPost);
      Map body = {
        "id": widget.postId,
        'subject': subject,
        'details': details,
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
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Notification'),
                content: const Text('Bạn đã report thành công bài viết này.'),
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
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                title: Text('Error'),
                content: Text('${responseBody['message']}'),
                actions: [
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('${responseBody['message']}'),
              actions: [
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
      print('Error during login: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred during login.'),
            actions: [
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
  }
}
