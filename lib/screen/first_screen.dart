import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'second_screen.dart'; // Importera andra skärmen

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }

  void _incrementCounter() {
    while (_counter < 6) {
      setState(() {
        _counter++;
        print(_counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'This is the first screen',
              style: TextStyle(color: Colors.black),
            )
                .animate()
                .tint(color: Colors.red)
                .then()
                .shake(duration: Duration(seconds: 1)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigera till andra skärmen när knappen trycks
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
