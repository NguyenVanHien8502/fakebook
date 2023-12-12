import 'dart:math';

import 'package:fakebook/src/components/widget/story_card.dart';
import 'package:fakebook/src/model/user.dart';
import 'package:fakebook/src/providers/user_data.dart';
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
    User? user = Provider.of<UserProvider>(context).user;
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
              //search
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
                        child: CircleAvatar(
                          backgroundImage: AssetImage(user!.avatar),
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
            //Name
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            //Giới thiệu cá nhân
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Chi tiết',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (User_data.userData.educations != null)
                    for (int i = 0;
                        i < User_data.userData.educations!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.school_rounded,
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Học ${User_data.userData.educations![i].majors != '' ? '${User_data.userData.educations![i].majors} ' : ''}tại ',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: User_data
                                          .userData.educations![i].school,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  if (User_data.userData.address != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.house_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Sống tại ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: User_data.userData.address,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (User_data.userData.hometown != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 25,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Đến từ ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: User_data.userData.hometown,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (User_data.userData.type != 'page' &&
                      user.followers != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: ImageIcon(
                              AssetImage('lib/src/assets/images/menu.png'),
                              size: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Có ${User_data.userData.followers} người theo dõi',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (User_data.userData.socialMedias != null)
                    for (int i = 0;
                        i < User_data.userData.socialMedias!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageIcon(
                              AssetImage(
                                  User_data.userData.socialMedias![i].icon),
                              size: 25,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                User_data.userData.socialMedias![i].name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.more_horiz_rounded,
                          size: 25,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            isMine
                                ? 'Xem thông tin giới thiệu của bạn'
                                : 'Xem thông tin giới thiệu của ${User_data.userData.name}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (User_data.userData.hobbies != null)
                    Wrap(
                      spacing: 10,
                      children: [
                        for (int i = 0;
                            i < User_data.userData.hobbies!.length;
                            i++)
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              User_data.userData.hobbies![i],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (User_data.userData.stories != null)
                    const SizedBox(
                      height: 10,
                    ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       if (isMine)
                  //         Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Container(
                  //               width: 80,
                  //               height: 144,
                  //               decoration: BoxDecoration(
                  //                 shape: BoxShape.rectangle,
                  //                 color: Colors.grey[200],
                  //                 borderRadius: BorderRadius.circular(10),
                  //               ),
                  //               child: const Icon(
                  //                 Icons.add,
                  //                 color: Colors.black54,
                  //                 size: 25,
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               height: 5,
                  //             ),
                  //             const Text(
                  //               'Mới',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 16,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       if (isMine)
                  //         const SizedBox(
                  //           width: 15,
                  //         ),
                  //       if (User_data.userData.stories != null)
                  //         for (int i = 0;
                  //             i < User_data.userData.stories!.length;
                  //             i++)
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 right: i < User_data.userData.stories!.length
                  //                     ? 15
                  //                     : 0),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 SizedBox(
                  //                   width: 80,
                  //                   height: 144,
                  //                   child: FittedBox(
                  //                     child: StoryCard(
                  //                       story: User_data.userData.stories![i],
                  //                       hidden: true,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Text(
                  //                   User_data.userData.stories![i].name != null
                  //                       ? User_data.userData.stories![i].name!
                  //                       : 'Tin nổi bật',
                  //                   style: const TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 16,
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //     ],
                  //   ),
                  // ),
                  if (User_data.userData.stories != null)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: Text(
                            'Chỉnh sửa chi tiết công khai',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
            //Đăng bài
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(user.avatar),
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
