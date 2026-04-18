import 'package:flutter/material.dart';
import 'fitness_service.dart';

class Badge {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  Badge({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class GamificationService with ChangeNotifier {
  int _xp = 0;
  int _level = 1;
  final List<Badge> _earnedBadges = [];

  int get xp => _xp;
  int get level => _level;
  List<Badge> get earnedBadges => List.unmodifiable(_earnedBadges);

  void update(FitnessService fitness) {
    // XP calculation: 100 XP for every 10% consistency
    final score = fitness.getConsistencyScore();
    _xp = (score * 1000).toInt();
    
    // Level calculation: Every 500 XP is a level
    _level = (_xp / 500).floor() + 1;

    _checkBadges(fitness);
    notifyListeners();
  }

  void _checkBadges(FitnessService fitness) {
    // 7-Day Consistency King
    if (fitness.getConsistencyScore() >= 1.0 && !_hasBadge("Consistency King")) {
      _earnedBadges.add(Badge(
        name: "Consistency King",
        description: "Achieved 100% consistency target for the week.",
        icon: Icons.Workspace_premium,
        color: const Color(0xFFFFD700),
      ));
    }

    // High Level Badge
    if (_level >= 5 && !_hasBadge("Veteran Athlete")) {
      _earnedBadges.add(Badge(
        name: "Veteran Athlete",
        description: "Reached level 5 through disciplined consistency.",
        icon: Icons.Military_tech,
        color: Colors.purpleAccent,
      ));
    }
  }

  bool _hasBadge(String name) => _earnedBadges.any((b) => b.name == name);
}
