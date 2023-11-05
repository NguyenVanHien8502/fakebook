import 'package:fakebook/src/data/infouser.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:flutter/material.dart';

class MenuPage1 extends StatefulWidget {
  static double offset = 0;
  static bool viewMoreShortcuts = false;
  static bool viewMoreHelps = false;
  static bool viewMoreSettings = false;
  const MenuPage1({super.key});

  @override
  State<MenuPage1> createState() => _MenuPage1State();
}

class _MenuPage1State extends State<MenuPage1> {
  ScrollController scrollController =
      ScrollController(initialScrollOffset: MenuPage1.offset);
  ScrollController headerScrollController = ScrollController();
  User user = User(name: 'Nguyen Ngoc Linh', avatar: '');
  User secondUser = User(name: 'Ngoc Linh', avatar: '');
  final List<Widget> shortcuts = [];

  @override
  void initState() {
    super.initState();
  }

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
          MenuPage1.offset);
      MenuPage1.offset = scrollController.offset;
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
                          AssetImage('lib/src/assets/images/avatar.jpg'),
                          color: Colors.black,
                          size: 50,
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/personal-page",
                      arguments: ArgumentMenu(
                          'lib/src/assets/images/fakebook.png',
                          "Nguyen Ngoc Linh"));
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
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black12,
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(user.avatar),
                              radius: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
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
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(secondUser.avatar),
                          radius: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
