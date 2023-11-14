import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<dynamic> name = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Fred',
    'Grace',
    'Henry',
    'Ivy',
    'Jack'
        'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Fred',
    'Grace',
    'Henry',
    'Ivy',
    'Jack'
        'Alice',
    'Bob',
    'Charlie',
    'David',
    'Emma',
    'Fred',
    'Grace',
    'Henry',
    'Ivy',
    'Jack'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (BuildContext context, index) {
            final names = name[index];
            return ListTile(
              title: Text(names),
            );
          }),
    );
  }
}
