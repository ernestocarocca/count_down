//import 'package:count_down/count_down_pref.dart';
import 'package:flutter/material.dart';
import 'package:count_down/screen/first_screen.dart';

void main() {

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useDarmode = false;

  void toggleTheme() {
    setState(() {
      useDarmode = !useDarmode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: useDarmode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: FirstScreen(
        useDarmode: useDarmode,
        toggleTheme: toggleTheme,
      ),
    );
  }
}
