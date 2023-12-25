import 'package:fakebook/src/constants/global_variables.dart';
import 'package:fakebook/src/messenger/data.dart';
import 'package:fakebook/src/messenger/messenger_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({super.key});

  @override
  MessengerPageState createState() => MessengerPageState();
}

class MessengerPageState extends State<MessengerPage> {
  TextEditingController _searchController = new TextEditingController();
  final primary = Color(0xFFF391A0);
  final grey = Color(0xFFe9eaec);
  final white = Color(0xFFFFFFFF);
  final black = Color(0xFF000000);
  final online = Color(0xFF66BB6A);
  final blue_story = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.backgroundColor,
        //Thân messenger
        body: getBody());
  }

  Widget getBody() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        children: <Widget>[
          //Avatar
          Row(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://scontent.fhan1-1.fna.fbcdn.net/v/t1.6435-9/96847488_1726560717493273_3583323616286081024_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeHPEg3A4b-bv0sjsTPtcQXKOPXuV_NQ_lA49e5X81D-UBmh4vihDxQUvQzUibkIEAI4jPteKh5B-_fm39740Etz&_nc_ohc=PowUCDj0v_kAX9pWgaf&_nc_ht=scontent.fhan1-1.fna&oh=00_AfD_iM5-q2vV9KB_YO-Br5lTCRBcJfQXGWrGt6f-DTj45Q&oe=65B07573"),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              const Text(
                "Chats",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  print("hit");
                }, // Sử dụng onPressed để xử lý khi được click
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 113, 95, 95)
                          .withOpacity(0.23),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Ionicons.camera,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("hit");
                }, // Sử dụng onPressed để xử lý khi được click
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 113, 95, 95)
                          .withOpacity(0.23),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          ////
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(15)),
            child: TextField(
              cursorColor: black,
              controller: _searchController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: black.withOpacity(0.5),
                  ),
                  hintText: "Search",
                  border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: grey),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 33,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        width: 75,
                        child: Align(
                            child: Text(
                          'Bạn đang nghĩ gì',
                          overflow: TextOverflow.ellipsis,
                        )),
                      )
                    ],
                  ),
                ),
                ////
                Row(
                  children: List.generate(
                    userStories.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 75,
                              height: 75,
                              child: Stack(
                                children: <Widget>[
                                  userStories[index]['story']
                                      ? Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: blue_story, width: 3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              width: 75,
                                              height: 75,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          userStories[index]
                                                              ['img']),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userStories[index]
                                                          ['img']),
                                                  fit: BoxFit.cover)),
                                        ),
                                  /////
                                  userStories[index]['online']
                                      ? Positioned(
                                          top: 48,
                                          left: 52,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: online,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: white, width: 3)),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            ////Stories
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 75,
                              child: Align(
                                  child: Text(
                                userStories[index]['name'],
                                overflow: TextOverflow.ellipsis,
                              )),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          ////
          const SizedBox(
            height: 30,
          ),
          Column(
            children: List.generate(userMessages.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MessengerDetail()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 75,
                        height: 75,
                        child: Stack(
                          children: <Widget>[
                            userMessages[index]['story']
                                ? Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: blue_story, width: 3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        width: 75,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    userMessages[index]['img']),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                userMessages[index]['img']),
                                            fit: BoxFit.cover)),
                                  ),
                            userMessages[index]['online']
                                ? Positioned(
                                    top: 48,
                                    left: 52,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: online,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: white, width: 3)),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userMessages[index]['name'],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 135,
                            child: Text(
                              userMessages[index]['message'] +
                                  " - " +
                                  userMessages[index]['created_at'],
                              style: TextStyle(
                                  fontSize: 15, color: black.withOpacity(0.8)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
