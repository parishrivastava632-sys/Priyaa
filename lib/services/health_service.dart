import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/activity.dart';
import 'fitness_service.dart';

class HealthService with ChangeNotifier {
  bool _isSyncing = false;
  int _dailySteps = 0;
  
  bool get isSyncing => _isSyncing;
  int get dailySteps => _dailySteps;

  Future<void> syncData(FitnessService fitness) async {
    _isSyncing = true;
    notifyListeners();

    // Mock API Delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate finding a new activity from the wearable
    final random = Random();
    if (random.nextBool()) {
      fitness.addActivity(Activity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: ActivityType.walk,
        duration: const Duration(minutes: 30),
        intensity: 3,
        timestamp: DateTime.now(),
      ));
    }

    _dailySteps = 5000 + random.nextInt(5000);
    _isSyncing = false;
    notifyListeners();
  }
}
