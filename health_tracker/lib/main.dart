import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/mock_data/mock_tracker_data.dart';
import 'package:health_tracker/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MockTrackerList.initialize();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: WelcomePage()));
}
