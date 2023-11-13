import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/pages/tabs/friend_page.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = '/friends-screen';
  static double offset = 0;
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class FriendRequest {
  final User user;
  final String time;
  final int? mutualFriends;
  final User? f1;
  final User? f2;
  FriendRequest({
    required this.user,
    required this.time,
    this.mutualFriends,
    this.f1,
    this.f2,
  });
}

class _FriendsScreenState extends State<FriendsScreen> {
  final today = DateTime.now();
  final friends = [
    FriendRequest(
      user: User(
        name: 'Nguyễn Văn Hiển',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '1 tuần',
      mutualFriends: 25,
      f1: User(
        name: 'Ngọc Linh',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      f2: User(
        name: 'Leo Messi',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
    ),
    FriendRequest(
      user: User(
        name: 'Ngọc Linh',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '3 tuần',
      mutualFriends: 1,
      f1: User(
        name: 'Bảo Ngân',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
    ),
    FriendRequest(
      user: User(
        name: 'Nguyễn Bá Duy',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '2 tuần',
    ),
    FriendRequest(
      user: User(
        name: 'Đỗ Nghĩa',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      mutualFriends: 455,
      f1: User(
        name: 'Minh Hương',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      f2: User(
        name: 'Hà Linhh',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '2 năm',
    ),
    FriendRequest(
      user: User(
        name: 'Ninh Thành Vinh',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '2 năm',
    ),
    FriendRequest(
      user: User(
        name: 'Linh Nguyễn',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '4 năm',
    ),
    FriendRequest(
      user: User(
        name: 'Văn Hiển',
        avatar: "lib/src/assets/images/avatar.jpg",
      ),
      time: '5 năm',
    ),
  ];

  ScrollController scrollController =
      ScrollController(initialScrollOffset: FriendsScreen.offset);
  ScrollController headerScrollController = ScrollController();

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
          FriendsScreen.offset);
      FriendsScreen.offset = scrollController.offset;
    });
    return NestedScrollView(
      controller: headerScrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          toolbarHeight: 45,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Bạn bè',
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
                              Icons.person_rounded,
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
              ],
            ),
          ),
        )
      ],
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Gợi ý bạn bè
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Gợi ý',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FriendPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Bạn bè',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
              thickness: 0.5,
              height: 40,
              indent: 10,
              endIndent: 10,
            ),
            //Lời mời kết bạn
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Lời mời kết bạn',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '568',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Danh sách kết bạn

            for (int i = 0; i < friends.length; i++)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(friends[i].user.avatar),
                        radius: 46,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                friends[i].user.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                friends[i].time,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          if (friends[i].mutualFriends != null &&
                              friends[i].mutualFriends! > 0)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 2,
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      friends[i].f2 != null
                                          ? const SizedBox(
                                              width: 46,
                                              height: 28,
                                            )
                                          : const SizedBox(
                                              width: 28,
                                              height: 28,
                                            ),
                                      if (friends[i].f2 != null)
                                        Positioned(
                                          left: 22,
                                          top: 2,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                friends[i].f2!.avatar),
                                            radius: 12,
                                          ),
                                        ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                friends[i].f1!.avatar),
                                            radius: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${friends[i].mutualFriends} bạn chung',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.blue[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Chấp nhận',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Xóa',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
