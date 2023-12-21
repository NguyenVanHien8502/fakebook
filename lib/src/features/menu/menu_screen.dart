import 'dart:convert';

import 'package:fakebook/src/api/api.dart';
import 'package:fakebook/src/features/menu/menu_choice.dart';
import 'package:fakebook/src/features/menu/shortcut.dart';
import 'package:fakebook/src/pages/authPages/change_password_page.dart';
import 'package:fakebook/src/pages/authPages/get_verify_code_page.dart';
import 'package:fakebook/src/pages/authPages/welcome_page.dart';
import 'package:fakebook/src/pages/otherPages/buy_coins.dart';
import 'package:fakebook/src/pages/otherPages/listblock.dart';
import 'package:fakebook/src/pages/otherPages/personal_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  static double offset = 0;
  static bool viewMoreShortcuts = false;
  static bool viewMoreHelps = false;
  static bool viewMoreSettings = false;

  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  dynamic currentUser;

  Future<void> getCurrentUserData() async {
    dynamic newData = await storage.read(key: 'currentUser');
    setState(() {
      currentUser = newData;
    });
  }

  ScrollController scrollController =
      ScrollController(initialScrollOffset: MenuScreen.offset);
  ScrollController headerScrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    headerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      headerScrollController.jumpTo(headerScrollController.offset +
          scrollController.offset -
          MenuScreen.offset);
      MenuScreen.offset = scrollController.offset;
    });
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        controller: headerScrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 60,
            titleSpacing: 0,
            pinned: true,
            floating: true,
            primary: false,
            centerTitle: true,
            automaticallyImplyLeading: false,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0), child: SizedBox()),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () {},
                        icon: const ImageIcon(
                          AssetImage('lib/src/assets/images/menu.png'),
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //settings
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      //search
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Avatar link personal
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalPageScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          currentUser != null
                              ? Container(
                                  margin: const EdgeInsets.only(right: 6.0),
                                  child: ClipOval(
                                    child: Image.network(
                                      '${jsonDecode(currentUser)['avatar']}',
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit
                                          .cover, // Đảm bảo ảnh đầy đủ trong hình tròn
                                    ),
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(right: 6.0),
                                  child: const Image(
                                    image: AssetImage(
                                        'lib/src/assets/images/avatarfb.jpg'),
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                currentUser != null
                                    ? Text(
                                        '${jsonDecode(currentUser)['username']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      )
                                    : const Text(
                                        'Lỗi hiển thị username',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Xem trang cá nhân của bạn',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black12,
                indent: 10,
                endIndent: 10,
                height: 0,
              ),
              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Tất cả lối tắt',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              //TIện ích
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, MemoryScreen.routeName);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Shortcut(
                                      img: "lib/src/assets/images/memory.png",
                                      title: 'Kỷ niệm'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context, FriendsScreen.routeName);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Shortcut(
                                      img: "lib/src/assets/images/friends.png",
                                      title: 'Bạn bè'),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: const Shortcut(
                                img: "lib/src/assets/images/video.png",
                                title: 'Video'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                    spreadRadius: 0,
                                  ),
                                ]),
                            child: const Shortcut(
                                img: "lib/src/assets/images/feed.png",
                                title: 'Bảng feed'),
                          ),
                          // if (MenuScreen.viewMoreShortcuts)
                          //   for (int i = 0; i < shortcuts.length; i += 2)
                          //     shortcuts[i],
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Shortcut(
                                img: "lib/src/assets/images/saved.png",
                                title: 'Đã lưu'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Shortcut(
                                img: "lib/src/assets/images/dating.png",
                                title: 'Hẹn hò'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Shortcut(
                                img: "lib/src/assets/images/market.png",
                                title: 'Marketplace'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Shortcut(
                                img: "lib/src/assets/images/event.png",
                                title: 'Sự kiện'),
                          ),
                          // if (MenuScreen.viewMoreShortcuts)
                          //   for (int i = 1; i < shortcuts.length; i += 2)
                          //     shortcuts[i],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            MenuScreen.viewMoreShortcuts =
                                !MenuScreen.viewMoreShortcuts;
                          });
                        },
                        child: Text(
                          MenuScreen.viewMoreShortcuts ? 'Ẩn bớt' : 'Xem thêm',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                color: Colors.black12,
              ),
              /////
              InkWell(
                onTap: () {
                  setState(() {
                    MenuScreen.viewMoreHelps = !MenuScreen.viewMoreHelps;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/src/assets/images/help.png",
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Trợ giúp & hỗ trợ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Icon(
                          MenuScreen.viewMoreHelps
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
              if (MenuScreen.viewMoreHelps)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/center.png',
                            title: 'Trung tâm trợ giúp'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/mail.png',
                            title: 'Hộp thư hỗ trợ'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/problem.png',
                            title: 'Báo cáo sự cố'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/safe.png',
                            title: 'An toàn'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/policy.png',
                            title: 'Điều khoản & chính sách'),
                      ),
                    ],
                  ),
                ),
              const Divider(
                height: 0,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    MenuScreen.viewMoreSettings = !MenuScreen.viewMoreSettings;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'lib/src/assets/images/settings.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Cài đặt & quyền riêng tư',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Icon(
                          MenuScreen.viewMoreSettings
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 30,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
              //
              if (MenuScreen.viewMoreSettings)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //Change password
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'lib/src/assets/images/change_password.png',
                              title: 'Đổi mật khẩu'),
                        ),
                      ),
                      //Buy Coins
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyCoins()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'lib/src/assets/images/dollar.png',
                              title: 'Mua Coins'),
                        ),
                      ),
                      //Chặn
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BlockPage()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'lib/src/assets/images/block.png',
                              title: 'Chặn'),
                        ),
                      ),
                      //
                      GestureDetector(
                        onTap: () {
                          if (jsonDecode(currentUser)['active'] == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Bạn có thực sự muốn vô hiệu hóa tài khoản của mình?'),
                                  content: const Text(
                                      'Nếu vô hiệu hóa tài khoản, bạn sẽ không thể sử dụng các tính năng khác của ứng dụng, trừ khi bạn khôi phục lại.'),
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
                                      onPressed: handleDeactive,
                                      child: const Text(
                                        'Đồng ý',
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
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: const Text(
                                      'Tài khoản của bạn đã bị vô hiệu hóa nên không thể sử dụng tính năng này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Ok',
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
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'lib/src/assets/images/deactive.png',
                              title: 'Vô hiệu hóa tài khoản'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (jsonDecode(currentUser)['active'] == '-2') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GetVerifyCodePage()));
                          } else if (jsonDecode(currentUser)['active'] ==
                              null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Thông báo'),
                                  content: const Text(
                                      'Tài khoản của bạn chưa bị vô hiệu hóa nên không thể sử dụng tính năng này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Ok',
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
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: const MenuChoice(
                              img: 'lib/src/assets/images/restore.png',
                              title: 'Khôi phục tài khoản'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ]),
                        child: const MenuChoice(
                            img: 'lib/src/assets/images/settings2.png',
                            title: 'Cài đặt'),
                      ),
                    ],
                  ),
                ),

              ///Đăng xuất
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shadowColor: Colors.transparent,
                          side: const BorderSide(
                            color: Colors.black12,
                            width: 0.5,
                          ),
                        ),
                        onPressed: handleLogout,
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text(
              'Bạn có muốn lưu thông tin đăng nhập để lần sau đỡ phải đăng nhập hay không?'),
          actions: [
            TextButton(
              onPressed: () async {
                await storage.deleteAll();
                Navigator.pushNamed(
                  context,
                  WelcomePage.routeName,
                );
              },
              child: const Text(
                'Không',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                await storage.delete(key: 'token');
                Navigator.pushNamed(
                  context,
                  WelcomePage.routeName,
                );
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
  }

  Future<void> handleDeactive() async {
    String? token = await storage.read(key: 'token');
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.deactiveUser);

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      responseBody = jsonDecode(response.body);
      if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
        await storage.deleteAll();
        Navigator.pushNamed(
          context,
          WelcomePage.routeName,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> handleRestoreUser() async {
    String? email = await storage.read(key: "email");
    dynamic responseBody;
    try {
      var url = Uri.parse(ListAPI.deactiveUser);

      Map body = {
        "email": email,
        // "code_verify":code,
      };

      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Chuyển chuỗi JSON thành một đối tượng Dart
      responseBody = jsonDecode(response.body);
      if (responseBody['code'] == '1000' && responseBody['message'] == 'OK') {
        await storage.delete(key: 'token');
        await storage.delete(key: 'email');
        await storage.delete(key: 'password');
        await storage.delete(key: 'currentUser');
        Navigator.pushNamed(
          context,
          WelcomePage.routeName,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
