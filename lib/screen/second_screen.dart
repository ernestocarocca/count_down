import 'dart:async';
import 'dart:ffi';

import 'package:count_down/count_downtimer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Duration duration = Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: BuildTime(),
        ),
      );

  Widget BuildTime() {
    return Text(
      '${duration.inSeconds}',
      style: TextStyle(fontSize: 80),
    );
  }
}
