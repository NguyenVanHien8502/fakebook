import 'package:fakebook/src/pages/otherPages/post_page.dart';
import 'package:flutter/material.dart';

class NewfeedsScreen extends StatefulWidget {
  static double offset = 0;
  final ScrollController parentScrollController;
  const NewfeedsScreen({super.key, required this.parentScrollController});

  @override
  State<NewfeedsScreen> createState() => _NewfeedsScreenState();
}

class _NewfeedsScreenState extends State<NewfeedsScreen> {
  Color colorNewPost = Colors.transparent;

  ScrollController scrollController =
      ScrollController(initialScrollOffset: NewfeedsScreen.offset);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).user;
    scrollController.addListener(() {
      if (widget.parentScrollController.hasClients) {
        widget.parentScrollController.jumpTo(
            widget.parentScrollController.offset +
                scrollController.offset -
                NewfeedsScreen.offset);
        NewfeedsScreen.offset = scrollController.offset;
      }
    });
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          //Heder NewFeedsScreen
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("lib/src/assets/images/avatar.jpg"),
                    radius: 20,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostPage()));
                    },
                    // onTapUp: (tapUpDetails) {
                    //   setState(() {
                    //     colorNewPost = Colors.black12;
                    //   });
                    // },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: colorNewPost,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text('Bạn đang nghĩ gì?'),
                      ),
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
          //
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          const SizedBox(
            height: 10,
          ),
          //Story

          //
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.black26,
          ),
          //Post
        ],
      ),
    );
  }
}
