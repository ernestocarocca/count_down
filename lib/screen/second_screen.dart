import 'dart:async';

import 'dart:math';

import 'package:count_down/count_downtimer.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Duration countdownDuration = Duration();

  List<Duration> durations = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();

    random();
    reset();
  }

  int random1(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void random() {
    // Random random = Random();
    int randomNumber = random1(5, 21); //random.nextInt(16) + 5;
    countdownDuration = Duration(seconds: randomNumber);
  }

  void reset() {
    //durations.clear();

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

  /*@override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }*/

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
                    random();
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
