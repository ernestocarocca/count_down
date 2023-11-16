import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Duration countdownDuration = const Duration();
  bool done = false;
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
    int randomNumber = random1(5, 21);
    countdownDuration = Duration(seconds: randomNumber);
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
        } else {
          done = true;
        }
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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BuildTime(),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    random();
                    durations.add(countdownDuration);

                    // Lägg till ny tid
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(16.0),
                    // Ange önskad utfyllnad runt texten
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
                  ), // Ange önskad färg
                ),
                icon: const Icon(Icons.timer), label: Text('Start New Timer'),
                //   child: Text('Start New Timer'),
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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 4, left: 4, top: 5),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {},

                    child: Icon(Icons.play_arrow),
                    backgroundColor: Colors.green,
                    elevation: 35, // Ikon som visas på knappen
                  ),
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

                    onPressed: () {
                      // Kod för att utföra handlingen när knappen trycks
                      // t.ex. navigering, lägg till ett objekt, visa en dialog, etc.
                    },
                    tooltip: 'Lägg till',
                    child: Icon(Icons.stop), // Ikon som visas på knappen
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
