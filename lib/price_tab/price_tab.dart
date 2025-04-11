import 'package:flight_search/price_tab/domain/entities/flight_stop.dart';
import 'package:flight_search/price_tab/flight_stop_card.dart';
import 'package:flight_search/price_tab/widgets/animated_dot.dart';
import 'package:flight_search/price_tab/widgets/animated_plane_icon.dart';
import 'package:flight_search/price_tab/widgets/fade_route.dart';
import 'package:flight_search/ticket_page/tickets_page.dart';
import 'package:flutter/material.dart';

class PriceTab extends StatefulWidget {
  final double height;
  final VoidCallback onPlaneFlightStart;
  const PriceTab(
      {super.key, required this.height, required this.onPlaneFlightStart});

  @override
  State<PriceTab> createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  final double _initialPlanePaddingBottom = 16;
  final double _minPlanePaddingTop = 16;
  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];
  final List<GlobalKey<FlightStopCardState>> _stopKeys = [];

  AnimationController? _planeSizeAnimationController;
  AnimationController? _planeTravelController;
  AnimationController? _dotsAnimationController;
  AnimationController? _fabAnimationController;
  Animation<double>? _planeSizeAnimation;
  Animation<double>? _planeTravelAnimation;
  Animation<double>? _fabAnimation;

  List<Animation<double>> _dotPositions = [];

  double get _planeTopPadding =>
      _minPlanePaddingTop +
      (1 - _planeTravelAnimation!.value) * _maxPlaneTopPadding;
  double get _maxPlaneTopPadding =>
      widget.height -
      _minPlanePaddingTop -
      _initialPlanePaddingBottom -
      _planeSize;
  double get _planeSize => _planeSizeAnimation!.value;

  @override
  void initState() {
    _initSizeAnimations();
    _initPlaneTravelAnimations();
    _initDotAnimationController();
    _initDotAnimations();
    _initFabAnimationController();
    for (var stop in _flightStops) {
      _stopKeys.add(GlobalKey<FlightStopCardState>());
    }
    _planeSizeAnimationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _planeSizeAnimationController!.dispose();
    _planeTravelController!.dispose();
    _dotsAnimationController!.dispose();
    _fabAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildPlane(),
          ..._flightStops.map(_buildStopCard),
          ..._flightStops.map(_mapFlightStopToDot),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = _dotPositions[index].value -
        0.5 * (FlightStopCard.height - AnimatedDot.size);
    bool isLeft = index.isOdd;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLeft ? Container() : Expanded(child: Container()),
            Expanded(
              child: FlightStopCard(
                key: _stopKeys[index],
                flightStop: stop,
                isLeft: isLeft,
              ),
            ),
            !isLeft ? Container() : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  Widget _mapFlightStopToDot(stop) {
    int index = _flightStops.indexOf(stop);
    bool isStartOrEnd = index == 0 || index == _flightStops.length - 1;
    Color color = isStartOrEnd ? Colors.red : Colors.green;

    return AnimatedDot(
      animation: _dotPositions[index],
      color: color,
    );
  }

  Widget _buildPlane() {
    return AnimatedBuilder(
        animation: _planeTravelAnimation!,
        child: Column(
          children: [
            AnimatedPlaneIcon(
              animation: _planeSizeAnimation!,
            ),
            Container(
              width: 2,
              height: _flightStops.length * FlightStopCard.height * 0.8,
              color: Color.fromARGB(255, 200, 200, 200),
            )
          ],
        ),
        builder: (context, child) => Positioned(
              top: _planeTopPadding,
              child: child!,
            ));
  }

  Widget _buildFab() {
    return Positioned(
        bottom: 16,
        child: ScaleTransition(
          scale: _fabAnimation!,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            shape: CircleBorder(),
            onPressed: () => Navigator.of(context)
                .push(FadeRoute(builder: (context) => TicketsPage())),
            child: Icon(
              Icons.check,
              size: 36,
              color: Colors.white,
            ),
          ),
        ));
  }

  _initSizeAnimations() {
    _planeSizeAnimationController =
        AnimationController(duration: Duration(milliseconds: 340), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.delayed(Duration(milliseconds: 500), () {
                widget.onPlaneFlightStart();
                _planeTravelController!.forward();
              });
              Future.delayed(Duration(milliseconds: 700), () {
                _dotsAnimationController!.forward();
              });
            }
          });
    _planeSizeAnimation = Tween<double>(begin: 60, end: 36).animate(
        CurvedAnimation(
            parent: _planeSizeAnimationController!, curve: Curves.easeOut));
  }

  _initPlaneTravelAnimations() {
    _planeTravelController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _planeTravelAnimation = CurvedAnimation(
        parent: _planeTravelController!, curve: Curves.fastOutSlowIn);
  }

  void _initDotAnimations() {
    //what part of whole animation takes one dot travel
    final double slideDurationInterval = 0.4;
    //what are delays between dot animations
    final double slideDelayInterval = 0.2;
    //at the bottom of the screen
    double startingMarginTop = widget.height;
    //minimal margin from the top (where first dot will be placed)
    double minMarginTop =
        _minPlanePaddingTop + _planeSize + 0.5 * (0.8 * FlightStopCard.height);

    for (int i = 0; i < _flightStops.length; i++) {
      final start = slideDelayInterval * i;
      final end = start + slideDurationInterval;

      double finalMarginTop = minMarginTop + i * (0.8 * FlightStopCard.height);
      Animation<double> animation = Tween(
        begin: startingMarginTop,
        end: finalMarginTop,
      ).animate(CurvedAnimation(
          parent: _dotsAnimationController!,
          curve: Interval(start, end, curve: Curves.easeOut)));
      _dotPositions.add(animation);
    }
  }

  void _initDotAnimationController() {
    _dotsAnimationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {});
              _animateFlightStopCards().then((_) => _animateFab());
            }
          });
  }

  Future _animateFlightStopCards() async {
    return Future.forEach(_stopKeys, (GlobalKey<FlightStopCardState> stopKey) {
      return Future.delayed(Duration(milliseconds: 250), () {
        debugPrint('runAnimation');
        stopKey.currentState!.runAnimation();
      });
    });
  }

  void _initFabAnimationController() {
    _fabAnimationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _fabAnimation = CurvedAnimation(
        parent: _fabAnimationController!, curve: Curves.easeOut);
  }

  void _animateFab() {
    _fabAnimationController!.forward();
  }
}
