import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/community_service.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final community = context.watch<CommunityService>();
    final leaderboard = community.leaderboard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "COMMUNITY LEADERBOARD",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white54,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: leaderboard.map((entry) => _buildEntry(entry)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEntry(LeaderboardEntry entry) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
        color: entry.isCurrentUser ? const Color(0xFFCCFF00).withOpacity(0.05) : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: entry.isCurrentUser ? const Color(0xFFCCFF00) : Colors.white10,
            child: Text(
              entry.name[0],
              style: TextStyle(
                color: entry.isCurrentUser ? Colors.black : Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              entry.name,
              style: TextStyle(
                color: entry.isCurrentUser ? const Color(0xFFCCFF00) : Colors.white70,
                fontWeight: entry.isCurrentUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            "${entry.points} pts",
            style: const TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
