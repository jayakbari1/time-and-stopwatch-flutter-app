import 'dart:async';
import 'package:numberpicker/numberpicker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_app/stopwatch.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Time",
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: "/",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stoped = true;
  bool reset = true;
  int timefottimer = 0;
  String timeToDispaly = "";
  bool checktimer = true;

  void start() {
    setState(() {
      started = false;
      stoped = true;
      reset = true;
    });
    timefottimer = (hour * 60 * 60) + (min * 60) + sec; //Convert all in seconds
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (timefottimer < 1 || checktimer == false) {
          t.cancel();
          if (timefottimer == 0) {
            started = true;
            stoped = true;
            debugPrint("TIme is Over!");
          }
          timeToDispaly = "";
          //
        }

        if (timefottimer < 60) {
          timeToDispaly = timefottimer.toString();
          timefottimer = timefottimer - 1;
        } else if (timefottimer < 3600) {
          int m = timefottimer ~/ 60;
          int s = timefottimer - (60 * m);
          timeToDispaly = m.toString() + ":" + s.toString();
          timefottimer = timefottimer - 1;
        } else {
          int h = timefottimer ~/ 3600;
          int t = timefottimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDispaly =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefottimer = timefottimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stoped = false;
      checktimer = false;
      //reset = true;
      debugPrint(timeToDispaly);
    });
  }

  void resetTime() {
    setState(() {
      started = true;
      stoped = true;
      reset = false;
      timeToDispaly = "";
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      timefottimer = 0;
    });
  }

  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "HH",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 70,
                          onChanged: (val) {
                            setState(() {
                              hour = val;
                            });
                          }),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "MM",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60,
                          onChanged: (val) {
                            setState(() {
                              min = val;
                            });
                          }),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "SS",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      NumberPicker.integer(
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 60,
                          onChanged: (val) {
                            setState(() {
                              sec = val;
                            });
                          }),
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Text(
                timeToDispaly,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              )),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: started ? start : null,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.green.withOpacity(.75),
                  splashColor: Colors.green,
                  hoverColor: Colors.black87,
                ),
                RaisedButton(
                  onPressed: stoped ? stop : null,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.red.withOpacity(0.75),
                  splashColor: Colors.red,
                  hoverColor: Colors.black87,
                ),
                RaisedButton(
                  onPressed: reset ? resetTime : null,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.yellow.withOpacity(0.75),
                  splashColor: Colors.red,
                  hoverColor: Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("TimerApp"),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Text("Timer"),
            Text("StopWatch"),
          ],
          labelPadding: EdgeInsets.only(bottom: 10.0),
          labelStyle: TextStyle(
            fontSize: 18.0,
          ),
          unselectedLabelColor: Colors.white60,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: [
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}
