import 'package:flutter/material.dart';
import 'fitness_service.dart';

class MotivationNudge {
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  MotivationNudge({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });
}

class MotivationService with ChangeNotifier {
  FitnessService? _fitnessService;
  List<MotivationNudge> _currentNudges = [];

  List<MotivationNudge> get currentNudges => _currentNudges;

  void update(FitnessService fitness) {
    _fitnessService = fitness;
    _generateNudges();
    notifyListeners();
  }

  void _generateNudges() {
    if (_fitnessService == null) return;
    
    _currentNudges = [];
    final score = _fitnessService!.getConsistencyScore();
    final state = _fitnessService!.getMomentumState();

    // Identity-based Nudges
    if (state == 'On Track') {
      _currentNudges.add(MotivationNudge(
        title: "The Athlete's Flow",
        message: "You're building the identity of a consistent athlete. 5 straight days is no accident.",
        icon: Icons.auto_awesome,
        color: const Color(0xFFCCFF00),
      ));
    } else if (state == 'Slipping') {
      _currentNudges.add(MotivationNudge(
        title: "Momentum Guard",
        message: "Don't let the rhythm break. Even a 2-minute effort keeps the identity alive.",
        icon: Icons.Shield_outlined,
        color: Colors.orangeAccent,
      ));
    } else {
      _currentNudges.add(MotivationNudge(
        title: "Fresh Start",
        message: "Every expert was once a beginner who didn't quit. Today is Day 1 of your new streak.",
        icon: Icons.refresh,
        color: Colors.blueAccent,
      ));
    }

    // Performance Nudges
    if (score > 0.9) {
      _currentNudges.add(MotivationNudge(
        title: "Elite Level",
        message: "You're in the top 5% of consistent users this week!",
        icon: Icons.Emoji_events_outlined,
        color: const Color(0xFFFFD700),
      ));
    }
  }
}
