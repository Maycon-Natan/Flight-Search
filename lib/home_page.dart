import 'package:flight_search/air_asia_bar.dart';
import 'package:flight_search/content_card.dart';
import 'package:flight_search/widgets/top_bar_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexButton = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AirAsiaBar(height: 210),
          Positioned.fill(
              child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
            child: Column(
              children: [_buildButtonsRow(), Expanded(child: ContentCard())],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  indexButton = 0;
                });
              },
              child: TopBarButton(
                name: 'ONE WAY',
                actived: indexButton == 0 ? true : false,
              )),
          InkWell(
              onTap: () {
                setState(() {
                  indexButton = 1;
                });
              },
              child: TopBarButton(
                name: 'ROUND',
                actived: indexButton == 1 ? true : false,
              )),
          InkWell(
              onTap: () {
                setState(() {
                  indexButton = 2;
                });
              },
              child: TopBarButton(
                name: 'MULTCITY',
                actived: indexButton == 2 ? true : false,
              )),
        ],
      ),
    );
  }
}
