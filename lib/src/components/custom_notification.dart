import 'package:flutter/material.dart';

class CustomListItem extends StatefulWidget {
  final Function()? onTap;
  final String name;
  final String text;
  final String time;
  final String linkAvatar;

  const CustomListItem({
    required this.onTap,
    required this.name,
    required this.text,
    required this.time,
    required this.linkAvatar,
  });

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onTapCancel: () {
        setState(() {
          isHovered = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: isHovered ? Color.fromARGB(255, 244, 245, 246) : Colors.white,
        ),
        child: Container(
          height: 120, // Thay đổi chiều cao tùy ý
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.linkAvatar),
                radius: 32,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(widget.time),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
