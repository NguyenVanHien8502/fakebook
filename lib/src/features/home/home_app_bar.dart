import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/constants/global_variables.dart';
import 'package:fakebook/src/messenger/messenger_page.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/otherPages/search_page.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeAppbarScreen extends StatefulWidget {
  const HomeAppbarScreen({super.key});

  @override
  State<HomeAppbarScreen> createState() => _HomeAppbarScreenState();
}

class _HomeAppbarScreenState extends State<HomeAppbarScreen> {
  // String coins = '0';
  //
  // Future<String?> getToken() async {
  //   const storage = FlutterSecureStorage();
  //   return await storage.read(key: 'token');
  // }
  //
  // Future<void> getInfoUser(BuildContext context, String id) async {
  //   try {
  //     String? token = await getToken();
  //     if (token != null) {
  //       var url = Uri.parse(ListAPI.getUserInfo);
  //       Map body = {
  //         "user_id": id,
  //       };
  //
  //       print(body);
  //
  //       http.Response response = await http.post(
  //         url,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         body: jsonEncode(body),
  //       );
  //
  //       // Chuyển chuỗi JSON thành một đối tượng Dart
  //       final responseBody = jsonDecode(response.body);
  //
  //       if (response.statusCode == 201) {
  //         if (responseBody['code'] == '1000') {
  //           setState(() {
  //             coins = responseBody['data']['coins'];
  //           });
  //         } else {
  //           print('API returned an error: ${responseBody['message']}');
  //         }
  //       } else {
  //         print('Failed to load friends. Status Code: ${response.statusCode}');
  //       }
  //     } else {
  //       print("No token");
  //     }
  //   } catch (error) {
  //     print('Error fetching friends: $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //User? user = Provider.of<UserProvider>(context, listen: false).user;
    //getInfoUser(context, user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Facebook',
              style: TextStyle(
                color: GlobalVariables.secondaryColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Image.asset(
        //       'lib/src/assets/images/dollar.png',
        //       width: 30,
        //       height: 30,
        //     ),
        //     const SizedBox(
        //       width: 6,
        //     ),
        //     Text(
        //       "${coins}",
        //       style: TextStyle(fontSize: 18, color: Colors.yellow),
        //     )
        //   ],
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //button search
            Container(
              alignment: Alignment.center,
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: IconButton(
                  splashRadius: 18,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
            //Botton Messenger
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 5, right: 12.0),
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black12,
              ),
              child: IconButton(
                splashRadius: 18,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessengerPage()));
                },
                icon: const Icon(
                  FontAwesome5Brands.facebook_messenger,
                  color: Colors.black,
                ),
              ),
            ),
            //end button messenger
          ],
        )
      ],
    );
  }
}
