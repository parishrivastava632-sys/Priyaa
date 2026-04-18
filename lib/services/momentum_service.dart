import 'package:flutter/material.dart';

class MomentumEvent {
  final String userName;
  final String action; // e.g., "saved a 10-day streak"
  final DateTime timestamp;
  final IconData icon;
  final Color color;

  MomentumEvent({
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.icon,
    required this.color,
  });
}

class MomentumService with ChangeNotifier {
  final List<MomentumEvent> _feed = [
    MomentumEvent(
      userName: "Claire",
      action: "just completed a 5-min Recovery Session",
      timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      icon: Icons.bolt,
      color: const Color(0xFFCCFF00),
    ),
    MomentumEvent(
      userName: "Dave",
      action: "hit a 14-day Consistency Milestone!",
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.emoji_events,
      color: Colors.orangeAccent,
    ),
    MomentumEvent(
      userName: "Zenith",
      action: "reinforced their 'Never Miss Twice' mantra",
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      icon: Icons.shield,
      color: Colors.blueAccent,
    ),
  ];

  List<MomentumEvent> get feed => List.unmodifiable(_feed);

  void postEvent(MomentumEvent event) {
    _feed.insert(0, event);
    notifyListeners();
  }
}
