import 'package:flutter/material.dart';

class TopBarButton extends StatefulWidget {
  bool actived;
  String name;
  TopBarButton({super.key, required this.actived, required this.name});

  @override
  State<TopBarButton> createState() => _TopBarButtonState();
}

class _TopBarButtonState extends State<TopBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white),
        color: widget.actived ? Colors.white : Colors.transparent,
      ),
      child: Center(
        child: Text(
          widget.name,
          style: TextStyle(
              color: widget.actived ? Colors.red : Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
