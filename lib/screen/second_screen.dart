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
  static const countdownDuration = Duration(minutes: 5, seconds: 20);
  List<Duration> durations = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset() {
    durations.clear();
    durations.add(countdownDuration);
    startTimer();
  }

  void addTime() {
    setState(() {
      for (int i = 0; i < durations.length; i++) {
        if (durations[i].inSeconds > 0) {
          durations[i] = Duration(seconds: durations[i].inSeconds - 1);
        } else {}
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BuildTime(),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    durations.add(countdownDuration); // Lägg till ny tid
                  });
                },
                child: Text('Start New Timer'),
              ),
            ],
          ),
        ),
      );

  Widget BuildTime() {
    return ListView.builder(
      itemCount: durations.length,
      itemBuilder: (BuildContext context, int index) {
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        final minutes = twoDigits(durations[index].inMinutes.remainder(60));
        final seconds = twoDigits(durations[index].inSeconds.remainder(60));

        return buildTimeCard(
          time1: minutes,
          header1: 'Minutes',
          time2: seconds,
          header2: 'Seconds',
        );
      },
    );
  }

  Widget buildTimeCard({
    required String time1,
    required String header1,
    required String time2,
    required String header2,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 100,
     
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  time1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 71,
                  ),
                ),
                Text(
                  time2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 71,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
