import 'dart:math';

import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalPageScreen extends StatefulWidget {
  static const String routeName = '/personal-page';
  final User user;
  const PersonalPageScreen({super.key, required this.user});

  @override
  State<PersonalPageScreen> createState() => _PersonalPageScreenState();
}

class _PersonalPageScreenState extends State<PersonalPageScreen> {
  final TextEditingController searchController = TextEditingController();
  final Random random = Random();
  bool isMine = false;
  int mutualFriends = 0;

  @override
  Widget build(BuildContext context) {
    //User user = Provider.of<UserProvider>(context).user;
    // if (widget.user.avatar != user.avatar) {
    //   user = widget.user;

    //   if (user.friends == null) {
    //     user = user.copyWith(
    //       friends: random.nextInt(5000),
    //     );
    //   }
    //   if (user.likes == null) {
    //     user = user.copyWith(
    //       likes: random.nextInt(1000000),
    //     );
    //   }
    //   if (user.type == 'page' && user.followers == null) {
    //     user = user.copyWith(
    //       followers: random.nextInt(1000000),
    //     );
    //   }
    //   mutualFriends = random.nextInt(user.friends ?? 1000);
    // } else {
    //   setState(() {
    //     isMine = true;
    //   });
    // }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(
              color: Colors.black12,
              width: double.infinity,
              height: 0.5,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Tìm kiếm',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                          size: 25,
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 45, maxHeight: 41),
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
                      contentPadding: EdgeInsets.zero,
                    ),
                    cursorColor: Colors.black,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //////////
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Avtar + anh bia
            Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 270,
                ),
                // Image.asset(
                //   'lib/src/assets/images/avatar.jpg',
                //   fit: BoxFit.cover,
                //   height: 220,
                //   width: double.infinity,
                // ),
                // :
                Container(
                  width: double.infinity,
                  height: 220,
                  color: Colors.grey,
                ),
                Positioned(
                  left: 12,
                  bottom: 0,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/src/assets/images/avatar.jpg'),
                          radius: 75,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.black,
                              size: 22,
                            )),
                      ),
                    ],
                  ),
                ),
                //if (isMine)
                Positioned(
                  bottom: 65,
                  right: 15,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          shape: BoxShape.circle,
                        ),
                        child: const ImageIcon(
                          AssetImage('lib/src/assets/images/avatar.jpg'),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 15,
            ),
            //header post personal
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bài viết',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Bộ lọc',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            //end
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/src/assets/images/avatar.jpg'),
                        radius: 20,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        1 > 0 ? 'Bạn đang nghĩ gì?' : 'Viết gì đó cho',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //////
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.black12,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.75,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                      'lib/src/assets/images/avatar.jpg'),
                                  color: Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Thước phim',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.75,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.video_camera_front_rounded,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Phát trực tiếp',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.black12,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_rounded,
                                  color: Colors.black, size: 18),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Quản lý bài viết',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Ảnh',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey,
            ),
            // for (int i = 0; i < user.posts!.length; i++)
            //   Column(
            //     children: [
            //       const SizedBox(height: 10),
            //       PostCard(
            //         post: user.posts![i],
            //       ),
            //       Container(
            //         width: double.infinity,
            //         height: 5,
            //         color: Colors.grey,
            //       ),
            //     ],
            //   )
          ],
        ),
      ),
    );
  }
}
