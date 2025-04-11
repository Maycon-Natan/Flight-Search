import 'package:flutter/material.dart';

class ContentCard extends StatefulWidget {
  const ContentCard({super.key});

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!showInput) {
            setState(() {
              showInput = true;
              showInputTabOptions = true;
            });
            return Future(() => false);
          } else {
            return Future(() => true);
          }
        },
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(8),
          child: DefaultTabController(
              length: 3,
              child: LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return Column(
                  children: [
                    _buildTabBar(showFirstOption: true),
                  ],
                );
              })),
        ));
  }

  Widget _buildTabBar({bool? showFirstOption}) {
    return TabBar(
      tabs: [
        Tab(text: showInputTabOptions ? "Flight" : "Price"),
        Tab(text: showInputTabOptions ? "Train" : "Duration"),
        Tab(text: showInputTabOptions ? "Bus" : "Stops"),
      ],
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.red,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
        child: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: viewportConstraints.maxHeight - 48,
        ),
        child: IntrinsicHeight(
          child: showInput
              ? _buildMuticityTab()
              : Container(
                  color: Colors.red,
                  height: 30,
                  width: 30,
                ),
        ),
      ),
    ));
  }

  Widget _buildMuticityTab() {
    return Column(
      children: [],
    );
  }
}
