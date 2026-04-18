import 'package:flutter/material.dart';

class LeaderboardEntry {
  final String name;
  final int points;
  final bool isCurrentUser;

  LeaderboardEntry({required this.name, required this.points, this.isCurrentUser = false});
}

class CommunityService with ChangeNotifier {
  final List<LeaderboardEntry> _leaderboard = [
    LeaderboardEntry(name: "Zenith_Runner", points: 2450),
    LeaderboardEntry(name: "Consistent_Claire", points: 2100),
    LeaderboardEntry(name: "You (Identity Building)", points: 0, isCurrentUser: true),
    LeaderboardEntry(name: "Slow_But_Sure", points: 1800),
    LeaderboardEntry(name: "Daily_Dave", points: 1550),
  ];

  List<LeaderboardEntry> get leaderboard => List.unmodifiable(_leaderboard);

  void updatePoints(int xp) {
    final index = _leaderboard.indexWhere((e) => e.isCurrentUser);
    if (index != -1) {
      _leaderboard[index] = LeaderboardEntry(
        name: _leaderboard[index].name,
        points: xp,
        isCurrentUser: true,
      );
      _leaderboard.sort((a, b) => b.points.compareTo(a.points));
      notifyListeners();
    }
  }
}
