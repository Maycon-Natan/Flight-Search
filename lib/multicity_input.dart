import 'package:flight_search/widgets/typable_text_form_field.dart';
import 'package:flutter/material.dart';

class MulticityInput extends StatefulWidget {
  const MulticityInput({super.key});

  @override
  MulticityInputState createState() {
    return MulticityInputState();
  }
}

class MulticityInputState extends State<MulticityInput>
    with TickerProviderStateMixin {
  AnimationController? textInputAnimationController;

  @override
  void initState() {
    textInputAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    textInputAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                finalText: "Kochfurt",
                animation: _buildInputAnimation(begin: 0.0, end: 0.2),
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_takeoff, color: Colors.red),
                  labelText: "From",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
              child: TypeableTextFormField(
                animation: _buildInputAnimation(begin: 0.15, end: 0.35),
                finalText: "Lake Xanderland",
                decoration: InputDecoration(
                  icon: Icon(Icons.flight_land, color: Colors.red),
                  labelText: "To",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CurvedAnimation _buildInputAnimation(
      {required double begin, required double end}) {
    return CurvedAnimation(
      parent: textInputAnimationController!,
      curve: Interval(begin, end, curve: Curves.linear),
    );
  }
}
