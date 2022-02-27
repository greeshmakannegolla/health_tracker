import 'package:flutter/material.dart';
import 'package:health_tracker/helpers/color_constants.dart';
import 'package:health_tracker/helpers/string_constants.dart';

class MockTracker {
  String displayName = '';
  String unit = '';
  String iconPath = '';
  String id = '';
  Color color = ColorConstants.kActionButtonColor;
}

class MockTrackerList {
  static List<MockTracker> mockTrackers = [];

  static initialize() {
    MockTracker bpTracker = MockTracker();
    bpTracker.displayName = 'Blood Pressure';
    bpTracker.iconPath = kBp;
    bpTracker.id = 'bp_data';
    bpTracker.unit = 'mm Hg';
    bpTracker.color = ColorConstants.kBloodPressureColor;
    mockTrackers.add(bpTracker);

    MockTracker weightTracker = MockTracker();
    weightTracker.displayName = 'Weight';
    weightTracker.iconPath = kWeight;
    weightTracker.id = 'weight';
    weightTracker.unit = 'kg';
    weightTracker.color = ColorConstants.kWeightColor;
    mockTrackers.add(weightTracker);

    MockTracker exerciseTracker = MockTracker();
    exerciseTracker.displayName = 'Exercise';
    exerciseTracker.iconPath = kThunder;
    exerciseTracker.id = 'exercise';
    exerciseTracker.unit = 'min(s)';
    exerciseTracker.color = ColorConstants.kExerciseColor;
    mockTrackers.add(exerciseTracker);
  }
}
