import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/string_constants.dart';

class MockTracker {
  String displayName = '';
  String unit = '';
  String iconPath = '';
  String id = '';
  Color color = Colors.orange;
}

class MockTrackerList {
  static List<MockTracker> mockTrackers = [];

  static initialize() {
    MockTracker sleepTracker = MockTracker();
    sleepTracker.displayName = 'Sleep';
    sleepTracker.iconPath = kSleep;
    sleepTracker.id = 'sleep';
    sleepTracker.unit = 'hours';
    sleepTracker.color = const Color(0xFFbf2158);
    mockTrackers.add(sleepTracker);

    MockTracker weightTracker = MockTracker();
    weightTracker.displayName = 'Weight';
    weightTracker.iconPath = kWeight;
    weightTracker.id = 'weight';
    weightTracker.unit = 'kg';
    weightTracker.color = const Color(0xFF2c94d4);
    mockTrackers.add(weightTracker);

    MockTracker exerciseTracker = MockTracker();
    exerciseTracker.displayName = 'Exercise';
    exerciseTracker.iconPath = kThunder;
    exerciseTracker.id = 'exercise';
    exerciseTracker.unit = 'min(s)';
    exerciseTracker.color = const Color(0xFF30ab5b);
    mockTrackers.add(exerciseTracker);
  }
}
