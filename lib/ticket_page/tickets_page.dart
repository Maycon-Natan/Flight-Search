import 'package:flight_search/air_asia_bar.dart';
import 'package:flight_search/home_page.dart';
import 'package:flight_search/price_tab/domain/entities/ticket_flight_stop.dart';
import 'package:flight_search/price_tab/widgets/fade_route.dart';
import 'package:flight_search/ticket_page/ticket_card.dart';
import 'package:flutter/material.dart';

class TicketsPage extends StatefulWidget {
  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
    with TickerProviderStateMixin {
  List<TicketFlightStop> stops = [
    TicketFlightStop("Sahara", "SHE", "Macao", "MAC", "SE2341"),
    TicketFlightStop("Macao", "MAC", "Cape Verde", "CAP", "KU2342"),
    TicketFlightStop("Cape Verde", "CAP", "Ireland", "IRE", "KR3452"),
    TicketFlightStop("Ireland", "IRE", "Sahara", "SHE", "MR4321"),
  ];
  AnimationController? cardEntranceAnimationController;
  List<Animation>? ticketAnimations;
  Animation<double>? fabAnimation;

  @override
  void initState() {
    super.initState();
    cardEntranceAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );
    ticketAnimations = stops.map((stop) {
      int index = stops.indexOf(stop);
      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start;
      return Tween<double>(begin: 800.0, end: 0.0).animate(CurvedAnimation(
          parent: cardEntranceAnimationController!,
          curve: Interval(start, end, curve: Curves.decelerate)));
    }).toList();
    fabAnimation = CurvedAnimation(
        parent: cardEntranceAnimationController!,
        curve: Interval(0.7, 1.0, curve: Curves.decelerate));
    cardEntranceAnimationController!.forward();
  }

  @override
  void dispose() {
    cardEntranceAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AirAsiaBar(
            height: 180.0,
          ),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 64.0,
            child: SingleChildScrollView(
              child: Column(
                children: _buildTickets().toList(),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Iterable<Widget> _buildTickets() {
    return stops.map((stop) {
      int index = stops.indexOf(stop);
      return AnimatedBuilder(
        animation: cardEntranceAnimationController!,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: TicketCard(stop: stop),
        ),
        builder: (context, child) => Transform.translate(
          offset: Offset(0.0, ticketAnimations![index].value),
          child: child,
        ),
      );
    });
  }

  _buildFab() {
    return ScaleTransition(
      scale: fabAnimation!,
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(FadeRoute(builder: (context) => HomePage()));
        },
        child: Icon(Icons.fingerprint, color: Colors.white, size: 36.0),
      ),
    );
  }
}
