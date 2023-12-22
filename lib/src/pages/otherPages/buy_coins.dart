import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:core';
import 'package:http/http.dart' as http;

class BuyCoins extends StatefulWidget {
  const BuyCoins({Key? key}) : super(key: key);

  @override
  BuyCoinsState createState() => BuyCoinsState();
}

class BuyCoinsState extends State<BuyCoins> {
  static const storage = FlutterSecureStorage();

  final TextEditingController coinsController = TextEditingController();

  Future<void> handleBuyCoins() async {
    String? token = await storage.read(key: 'token');
    String coins = coinsController.text;
    try {
      var url = Uri.parse(ListAPI.buyCoins);
      Map body = {
        "code": "string",
        "coins": coins,
      };

      http.Response response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(body));
      final responseBody = jsonDecode(response.body);
      print(responseBody);

      if(responseBody['code']=='1000'){
        coinsController.clear();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Notification'),
              content: const Text(
                  'Congratulations! You have successfully bought coins.'),
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
      }
    } catch (e) {
      print("Error buy coins: $e");
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
          // Đặt màu của mũi tên quay lại thành màu đen
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      "Mua coins",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      "Coins giúp bạn có thể thực hiện các chức năng của ứng dụng như đăng bài viết, comment, tương tác với bạn bè,...",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: const Text(
                      "Nhập số coins bạn muốn mua *:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: coinsController,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Nhập số lượng coins',
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
                          Icons.monetization_on_outlined,
                          color: Colors.black54,
                        ),
                      ),
                      cursorColor: Colors.black, //chỉnh màu của cái vạch nháy
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: handleBuyCoins,
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(370, 50),
                        padding: EdgeInsets.zero,
                        // Loại bỏ padding mặc định của nút
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Đặt độ cong của góc
                        ),
                        backgroundColor: Colors.blue,
                        // Đặt màu nền của nút
                        side: const BorderSide(
                          color: Color.fromARGB(
                              255, 0, 68, 255), // Đặt màu đường viền
                          width: 0.4, // Đặt độ dày của đường viền
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Mua",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
