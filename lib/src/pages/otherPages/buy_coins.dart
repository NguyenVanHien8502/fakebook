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

  final TextEditingController buyCoinsText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.black), // Đặt màu của mũi tên quay lại thành màu đen
        title: const Text(
          "Mua Coins",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(child: ,)
    );
  }
}
