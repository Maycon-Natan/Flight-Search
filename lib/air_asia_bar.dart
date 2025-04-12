import 'package:flutter/material.dart';

class AirAsiaBar extends StatelessWidget {
  final double height;
  const AirAsiaBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, const Color(0xFFE64C85)])),
        ),
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "AirAsia",
            style: TextStyle(
                fontFamily: 'NothingYouCouldDo',
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        )
      ],
    );
  }
}
