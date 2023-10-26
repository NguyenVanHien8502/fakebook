import 'package:fakebook/src/components/custom_notification.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: AppBar(
            title: const Text("Thông báo"),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),

        //Body - phần thân thông báo
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/personal-page",
                          arguments: {"name": "Nguyen Ngoc Linh", "age": "22"});
                    },
                    child: Container(
                      height: h * 0.12,
                      padding: const EdgeInsets.only(left: 16),
                      child: const Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'lib/src/assets/images/fakebook.png'),
                            radius: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Bạn có thể thay đổi giá trị 40 thành bất kỳ giá trị nào bạn muốn để điều chỉnh kích thước của avatar",
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Hôm qua lúc 23:27")
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                  const CustomListItem(
                      onTap: null,
                      name: "Linh",
                      text: "Nguyen Ngoc Linh",
                      time: "Hôm qua lúc 23:23",
                      linkAvatar: "lib/src/assets/images/fakebook.png"),
                ],
              ),
            ),
          ),
        ));
  }
}
