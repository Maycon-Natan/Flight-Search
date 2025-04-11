import 'package:flight_search/price_tab/domain/entities/ticket_flight_stop.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final TicketFlightStop stop;

  const TicketCard({Key? key, required this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(10.0),
      child: Material(
        elevation: 4.0,
        shadowColor: Color(0x30E5E5E5),
        color: Colors.transparent,
        child: ClipPath(
          clipper: TicketClipper(12.0),
          child: Card(
            elevation: 0.0,
            margin: const EdgeInsets.all(2.0),
            child: _buildCardContent(),
          ),
        ),
      ),
    );
  }

  SizedBox _buildCardContent() {
    TextStyle airportNameStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    TextStyle airportShortNameStyle =
        TextStyle(fontSize: 36, fontWeight: FontWeight.w200);
    TextStyle flightNumberStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return SizedBox(
      height: 104.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(stop.from, style: airportNameStyle),
                  ),
                  Text(stop.fromShort, style: airportShortNameStyle),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(Icons.airplanemode_active,
                    color: Colors.red, size: 36.0),
              ),
              Text(
                stop.flightNumber,
                style: flightNumberStyle,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(stop.to, style: airportNameStyle),
                  ),
                  Text(stop.toShort, style: airportShortNameStyle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
