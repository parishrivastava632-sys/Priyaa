enum ActivityType { workout, yoga, walk, run, cycling }

class Activity {
  final String id;
  final ActivityType type;
  final Duration duration;
  final int intensity; // 1-10
  final DateTime timestamp;

  Activity({
    required this.id,
    required this.type,
    required this.duration,
    required this.intensity,
    required this.timestamp,
  });

  factory Activity.fromMap(Map<String, dynamic> map, String id) {
    return Activity(
      id: id,
      type: ActivityType.values.firstWhere((e) => e.name == map['type']),
      duration: Duration(minutes: map['duration']),
      intensity: map['intensity'],
      timestamp: (map['timestamp'] as dynamic).toDate(),
    );
  }
}

class UserMetrics {
  final int steps;
  final double sleepHours;
  final int mood; // 1-5
  final DateTime date;

  UserMetrics({
    required this.steps,
    required this.sleepHours,
    required this.mood,
    required this.date,
  });
}
