import 'package:flutter/material.dart';
import '../models/activity.dart';

class FitnessService with ChangeNotifier {
  final List<Activity> _activities = [];
  final List<UserMetrics> _metrics = [];
  bool _onboardingSeen = false;

  List<Activity> get activities => List.unmodifiable(_activities);
  bool get onboardingSeen => _onboardingSeen;
  
  void setOnboardingSeen() {
    _onboardingSeen = true;
    notifyListeners();
  }
  
  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  // Consistency Score Algorithm
  // Consistency = (Workouts in last 7 days / Target Workouts)
  double getConsistencyScore({int targetPerWeek = 5}) {
    if (_activities.isEmpty) return 0.0;
    
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final activeDays = _activities
        .where((a) => a.timestamp.isAfter(sevenDaysAgo))
        .map((a) => DateTime(a.timestamp.year, a.timestamp.month, a.timestamp.day))
        .toSet();

    double score = activeDays.length / targetPerWeek;
    return score.clamp(0.0, 1.0);
  }

  // Momentum State: On Track, Slipping, Off Track
  String getMomentumState() {
    final score = getConsistencyScore();
    if (score >= 0.8) return 'On Track';
    if (score >= 0.5) return 'Slipping';
    return 'Off Track';
  }

  // Predictive Drop-off Detection
  // Compares current 3-day consistency with the previous 3-day window
  bool isAtRisk() {
    if (_activities.length < 2) return false;
    
    final now = DateTime.now();
    final window1 = _getUniqueActiveDays(now.subtract(const Duration(days: 3)), now);
    final window2 = _getUniqueActiveDays(now.subtract(const Duration(days: 6)), now.subtract(const Duration(days: 3)));

    // Risk if activity is dropping and already below target
    return (window1 < window2) && (getConsistencyScore() < 0.7);
  }

  int _getUniqueActiveDays(DateTime start, DateTime end) {
    return _activities
        .where((a) => a.timestamp.isAfter(start) && a.timestamp.isBefore(end))
        .map((a) => DateTime(a.timestamp.year, a.timestamp.month, a.timestamp.day))
        .toSet()
        .length;
  }
}
