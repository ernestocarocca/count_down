
/*
import 'dart:convert';

import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class _Timer {
  final int id;
  Duration time;
  bool isRunning;
  _Timer(this.id, this.time, this.isRunning);

  Map<String, dynamic> toJson() {
    return {
      'runing': isRunning,
      'id': id,
      'time': time.inSeconds,
    };
  }

  factory _Timer.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return _Timer(0, Duration(seconds: 0),
          false); // Ersätter med standardvärden om json är null
    }
    return _Timer(
      json['id'] ?? 0,
      Duration(seconds: json['time'] ?? 0),
      json['isRunning'] ?? false,
    );
  }
}

class TimeManager {
  static const _keyTime = 'thisTime';

  Future<void> addCounterTimer(_Timer timeData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> timeList = prefs.getStringList(_keyTime) ?? [];

    // String jsonTime = json.encode(timeData.toJson());
    timeList.add(json.encode(timeData.toJson()));

    await prefs.setStringList(_keyTime, timeList);
  }

  Future<void> removeTime(_Timer timeData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> timeList = prefs.getStringList(_keyTime) ?? [];

    timeList.removeWhere((timeData) {
      final tData = json.decode(timeData);
      return tData['id'] == tData.id &&
          tData['time'] == tData.time &&
          tData['runing'] == tData.isRunning;
    });
    await prefs.setStringList(_keyTime, timeList);
  }

  Future<List<_Timer>> getTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? timeList = prefs.getStringList(_keyTime);

    if (timeList == null || timeList.isEmpty) {
      return []; // Returnerar en tom lista om det inte finns någon sparad data
    }

    return timeList.map((timeJson) {
      final Map<String, dynamic> timeData = json.decode(timeJson);
      return _Timer(
        timeData['id'] ?? 0,
        Duration(seconds: timeData['time'] ?? 0),
        timeData['isRunning'] ?? false,
      );
    }).toList();
  }

/*
  Future<List<Timer>> getTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> timeList = prefs.getStringList(_keyTime) ?? [];
    return timeList.map((timeJson) {
      final timeData = json.decode(timeJson);
      return Timer(timeData['id'], Duration(seconds: timeData['time']),
          timeData['running']);
    }).toList();
  } */
}
*/