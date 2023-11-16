import 'package:count_down/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'second_screen.dart'; // Importera andra skärmen

/*
class FirstScreen extends StatefulWidget {
 
  @override
  _FirstScreenState createState() => _FirstScreenState();
}
*/
class FirstScreen extends StatelessWidget {
  final bool useDarmode;
  final VoidCallback toggleTheme;

  FirstScreen({required this.useDarmode, required this.toggleTheme});
  var _counter = 0;
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }*/
/*
  void _incrementCounter() {
    while (_counter < 6) {
      setState(() {
        _counter++;
        print(_counter);
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        actions: [
          IconButton(
              icon: Icon(useDarmode ? Icons.dark_mode : Icons.light_mode),
              onPressed: toggleTheme),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            useDarmode
                ? const Text(
                    'This is the first screen',
                    style: TextStyle(color: Colors.white),
                  )
                : const Text(
                    'This is the first screen',
                    style: TextStyle(color: Colors.black),
                  ),
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
            ).animate().then().shake(duration: Duration(seconds: 1)),
          ],
        ),
      ),
    );
  }
}
