import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Duration> durations = [];
  List<Timer> timers = [];

  @override
  void initState() {
    super.initState();

    loadSavedTime(); //Function call to load saved durations from SharedPreferences

    // Create timers for stored durations
    Future.wait(List.generate(durations.length, (index) => createTimer(index)))
        .then((List<Timer> createdTimers) {
      setState(() {
        timers.addAll(createdTimers);
        print(timers);
        print(durations);
      });
    });
  }

  void loadSavedTime() async {
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    List<String>? savedTimes = prefs.getStringList('savedTime');
    // Load saved durations from SharedPreferences and convert them to Duration objects
    if (savedTimes != null && savedTimes.isNotEmpty) {
      setState(() {
        durations = savedTimes.map((timeString) {
          if (timeString == 'Done') {
            return Duration.zero;
          }
          return Duration(seconds: int.parse(timeString));
        }).toList();
      });
    }
  }

// Function to create a new random Duration with random number between 5-20 secunds
  Duration createNewDuration() {
    int random(int min, int max) {
      return min + Random().nextInt(max - min);
    }

    int randomNumber = random(5, 21);
    Duration duration = Duration(seconds: randomNumber);
    return duration;
  }

  // Function to reset the stored durations
  void reset() async {
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    prefs.setStringList('savedTime', []);
    setState(() {
      durations.clear();
    });
  }

  // Function to create a Timer for a duration at a specific index
  Future<Timer> createTimer(int index) async {
    Timer timer =
        Timer.periodic(const Duration(seconds: 1), (_) => updateTimer(index));
    return timer;
  }
  // Function to update the duration at a specific index

  void updateTimer(int index) {
    setState(() {
      if (durations[index].inSeconds > 0) {
        durations[index] = Duration(seconds: durations[index].inSeconds - 1);
      } else {
        stopTimer(index);
      }
    });
  }

  // Function to stop the timer at a specific index and save durations to SharedPreferences
  void stopTimer(int index) async {
    // saves data in device ?
    SharedPreferences prefs = SharedPreferencesManager._preferences;

    timers[index].cancel();
    List<String> newDurationList =
        durations.map((d) => d.inSeconds.toString()).toList();
    prefs.setStringList('savedTime', newDurationList);
  }

  // Function to save durations to SharedPreferences
  void saveDurations() {
    SharedPreferences prefs = SharedPreferencesManager._preferences;
    List<String> newDurationList =
        durations.map((d) => d.inSeconds.toString()).toList();
    prefs.setStringList('savedTime', newDurationList);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    saveDurations();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // leading: BackButton(onPressed: saveDurations),
          title: Text('Second Screen'),
          actions: [
            IconButton(
              onPressed: reset,
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: buildTime(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.00),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      Duration newDuration = createNewDuration();
                      durations.add(newDuration);
                      Future<Timer> newTimer = createTimer(timers.length);
                      newTimer.then((value) {
                        timers.add(value);
                      });
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

  Widget buildTime() {
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
                        // crate new timer and replace in index
                        createTimer(index).then((value) {
                          timers[index] = value;
                        });
                      },
                      backgroundColor: Colors.green,
                      elevation: 35,
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

                    tooltip: 'Lägg till', // Ikon som visas på knappen
                    backgroundColor: Colors.red,
                    heroTag: 'stopButton_$index',
                    child: const Icon(Icons.stop),
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
