import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Duration countdownDuration = const Duration();
  bool done = false;
  List<Duration> durations = [];
  Duration stopTime = const Duration();
  bool isRunning = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    loadSavedTime();
    print('init duration $durations');
  }

  void loadSavedTime() async {
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    List<String>? savedTimes = prefs.getStringList('savedTime');
    print(savedTimes);
    if (savedTimes != null && savedTimes.isNotEmpty) {
      setState(() {
        durations = savedTimes.map((timeString) {
          // Om sparad tid är 'Done', sätt den till 0
          if (timeString == 'Done') {
            return Duration.zero;
          }
          return Duration(seconds: int.parse(timeString));
        }).toList();
      });
    }
  }

  void random() {
    int random1(int min, int max) {
      return min + Random().nextInt(max - min);
    }

    int randomNumber = random1(5, 21);
    countdownDuration = Duration(seconds: randomNumber);
  }

  void reset() async {
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    prefs.setStringList('savedTime', []);
    setState(() {
      durations.clear();

      done = false;
    });

    durations.add(countdownDuration);
  }

  void addTime() {
    setState(() {
      for (int i = 0; i < durations.length; i++) {
        if (durations[i].inSeconds > 0) {
          durations[i] = Duration(seconds: durations[i].inSeconds - 1);
          print(durations);
        } else {
          durations[i] = Duration.zero;
          done = true;
        }
      }
    });
  }

  void startTimer(Duration duration, int index) async {
    if (!isRunning) {
      isRunning = true;
      // loadSavedTime();
      countdownDuration = duration;

      if (duration == Duration.zero) {
        random(); //
      } else {
        countdownDuration = duration;
      }
      timer =
          Timer.periodic(const Duration(seconds: 1), (_) => updateTimer(index));
    }
  }

  void updateTimer(int index) {
    setState(() {
      if (durations[index].inSeconds > 0) {
        durations[index] = Duration(seconds: durations[index].inSeconds - 1);
      } else {
        stopTimer(index);
      }
    });
  }

  void stopTimer(int index) async {
    // saves data in device ?
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    isRunning = false;
    if (timer != null) {
      timer!.cancel();

      List<String> newDurationList = [];

      for (Duration d in durations) {
        newDurationList.add(d.inSeconds.toString());
      }

      prefs.setStringList('savedTime', newDurationList);
      print(' pref setTime  $prefs');
      print(newDurationList);

      print('Saved time at index $index: ${durations[index]}');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveTimes() async {
    SharedPreferences prefs = SharedPreferencesManager._preferences;

    List<String> timeStrings = durations.map((duration) {
      if (duration.inSeconds <= 0) {
        return 'Done';
      }
      return duration.inSeconds.toString();
    }).toList();
    await prefs.setStringList('savedTimes', timeStrings);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
          actions: [
            IconButton(
              onPressed: reset,
              icon: const Icon(Icons
                  .clear), // Här använder du en "clear" ikon, kan ändras till vad du vill
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BuildTime(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.00),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      random();
                      durations.add(countdownDuration);

                      if (durations.isNotEmpty) {
                        startTimer(countdownDuration, durations.length - 1);
                      }

                      // saveTimes();

                      // Lägg till ny tid
                    });
                  },

                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16.0),
                    ),

                    elevation: MaterialStateProperty.all<double>(15.0),
                    shadowColor: MaterialStateProperty.all<Color>(
                        Colors.grey), // Ange önskad skuggfärg
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),

                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black,
                    ), //
                  ),
                  icon: const Icon(
                    Icons.timer,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Start New Timer',
                    style: TextStyle(color: Colors.green),
                  ),
                  //
                ),
              ),
            ],
          ),
        ),
      );

  Widget BuildTime() {
    return ListView.builder(
      itemCount: durations.length,
      itemBuilder: (BuildContext context, int index) {
        String twoDigits(int n) => n.toString().padLeft(2, '');
        var minutes = twoDigits(durations[index].inMinutes.remainder(60));
        var seconds = twoDigits(durations[index].inSeconds.remainder(60));
        // countdown zero then = 'Done'
        if (durations[index].inSeconds <= 0) {
          seconds = 'Done';
        }

        return buildTimeCard(
          time1: minutes,
          header1: 'Minutes',
          time2: seconds,
          header2: 'Seconds',
          index: index,
        );
      },
    );
  }

  Widget buildTimeCard({
    required String time1,
    required String header1,
    required String time2,
    required String header2,
    required int index,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 4, left: 4, top: 5),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                      onPressed: () async {
                        startTimer(countdownDuration, index);
                      },
                      backgroundColor: Colors.green,
                      elevation: 35, // Ikon som visas på knappen
                      heroTag: 'playButton_$index',
                      child: const Icon(Icons.play_arrow)),
                  Text(
                    time2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 71,
                    ),
                  ),
                  FloatingActionButton(
                    elevation: 35,

                    onPressed: () async {
                      stopTimer(index);
                    },

                    tooltip: 'Lägg till',
                    child: Icon(Icons.stop), // Ikon som visas på knappen
                    backgroundColor: Colors.red,
                    heroTag: 'stopButton_$index',
                  ),
                ],
              ),
            ),
          )
        ],
      );
}

class SharedPreferencesManager {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get preferences {
    return _preferences;
  }
}
