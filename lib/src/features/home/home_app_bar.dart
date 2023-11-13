import 'package:fakebook/src/constants/global_variables.dart';
import 'package:fakebook/src/messenger/messenger_page.dart';
import 'package:fakebook/src/pages/otherPages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeAppbarScreen extends StatefulWidget {
  const HomeAppbarScreen({super.key});

  @override
  State<HomeAppbarScreen> createState() => _HomeAppbarScreenState();
}

class _HomeAppbarScreenState extends State<HomeAppbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            // IconButton(
            //   splashRadius: 20,
            //   onPressed: () {},
            //   icon: const ImageIcon(
            //     AssetImage('lib/src/assets/images/menu.png'),
            //     color: Colors.black,
            //     size: 20,
            //   ),
            // ),
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
