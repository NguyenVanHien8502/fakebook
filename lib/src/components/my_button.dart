import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap;
  final String nameButton;
  final Icon? icon;

  const MyButton(
      {super.key, required this.onTap, required this.nameButton, this.icon});
  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      //khi user nhấn giữ button
      onTapDown: (_) {
        setState(() {
          isHovered = true;
        });
      },
      //khi user nhấn giữ button rồi kéo tay ra khỏi vị trí ngoài button
      onTapCancel: () {
        setState(() {
          isHovered = false;
        });
      },
      //khi user thả tay khỏi button
      onTapUp: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: isHovered ? Colors.lightBlue : Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          width: 310,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.nameButton,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              widget.icon != null
                  ? Row(
                      children: List.generate(
                        3,
                        (index) => const Icon(Icons.arrow_right),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
