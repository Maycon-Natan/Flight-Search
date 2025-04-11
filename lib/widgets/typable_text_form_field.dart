import 'package:flutter/material.dart';

class TypeableTextFormField extends StatefulWidget {
  final String finalText;
  final InputDecoration decoration;
  final Animation<double> animation;

  const TypeableTextFormField(
      {super.key,
      required this.finalText,
      required this.decoration,
      required this.animation});

  @override
  State<TypeableTextFormField> createState() => _TypeableTextFormFieldState();
}

class _TypeableTextFormFieldState extends State<TypeableTextFormField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    widget.animation.addListener(() {
      int totalLettersCount = widget.finalText.length;
      int currentLetterCount =
          (totalLettersCount * widget.animation.value).round();
      setState(() {
        controller.text = widget.finalText.substring(0, currentLetterCount);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: widget.decoration,
      controller: controller,
    );
  }
}
