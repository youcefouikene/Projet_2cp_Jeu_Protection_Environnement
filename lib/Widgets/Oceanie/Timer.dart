import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projet_2cp/progress/progress.dart';
import '../../../Screens/EndGamePage.dart';
import 'package:projet_2cp/backend/progress_controllers.dart';
import 'package:projet_2cp/constants.dart';

class Time extends StatefulWidget {
  final Function(int) callback;
  int stationIndex;
  String station;
  String background;
  bool ignore;
  String refreshPath;
  Time(
      {required this.stationIndex,
      required this.ignore,
      required this.callback,
      required this.background,
      required this.station,
      required this.refreshPath});
  @override
  _Time createState() => _Time();
}

class _Time extends State<Time> {
  int _secondsElapsed = 30;
  final Color _backgroundColor = Colors.white;

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _secondsElapsed--;
      });
      if ((_secondsElapsed == 0) || (widget.ignore == true)) {
        widget.callback(_secondsElapsed);
        timer.cancel();
        dataUpdator(
            context,
            userProgress.stations[widget.stationIndex],
            userProgress.stations[widget.stationIndex].games[1],
            _secondsElapsed,
            (_secondsElapsed == 0) ? 0 : _secondsElapsed ~/ 10 + 1);
        print('voici secondElapsed ${_secondsElapsed}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EndGamePage(
                score: _secondsElapsed,
                stars: (_secondsElapsed == 0) ? 0 : _secondsElapsed ~/ 10 + 1,
                stationIndex: widget.stationIndex,
                background: widget.background,
                station: widget.station,
                refreshPath: widget.refreshPath,
              ),
            ));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  int getSecond() {
    return _secondsElapsed;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.0859444,
            width: MediaQuery.of(context).size.width * 0.146425,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36.5),
              border: Border.all(
                color: const Color(0xffE84560),
                width: 3,
              ),
            ),
            //padding: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                '00:$_secondsElapsed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Atma',
                  fontSize: MediaQuery.of(context).size.width * 0.025,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1277777,
            width: MediaQuery.of(context).size.height * 0.1277777,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xffE84560),
                width: 3,
              ),
            ),
            child: Image.asset('assets/images/oceanie/timer.png'),
          ),
        ],
      ),
    );
  }
}
