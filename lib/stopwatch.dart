import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stopwatch extends StatefulWidget {
  @override
  _stopwatchState createState() => _stopwatchState();
}

class _stopwatchState extends State<stopwatch> {
  bool startPress = true;
  bool stopPress = true;
  bool resetPress = true;
  String stoptimeTodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      stoptimeTodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startStopwatch() {
    setState(() {
      stopPress = false;
      startPress = false;
      swatch.start();
      startTimer();
    });
  }

  void stopedStopwatch() {
    setState(() {
      stopPress = false;
      resetPress = false;
    });
    swatch.stop();
  }

  void resetStopwatch() {
    setState(() {
      startPress = true;
      resetPress = true;
    });
    swatch.reset();
    stoptimeTodisplay = "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimeTodisplay,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: stopPress ? null : stopedStopwatch,
                      color: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        "Stop",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: resetPress ? null : resetStopwatch,
                      color: Colors.teal,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  onPressed: startPress ? startStopwatch : null,
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
