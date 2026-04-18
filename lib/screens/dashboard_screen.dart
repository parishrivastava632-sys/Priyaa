import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import '../services/fitness_service.dart';
import '../services/motivation_service.dart';
import '../services/health_service.dart';
import '../models/motivation_nudge.dart';
import '../widgets/nudge_card.dart';
import '../widgets/ai_coach_sheet.dart';
import '../widgets/activity_heatmap.dart';
import '../widgets/leaderboard_widget.dart';
import '../widgets/momentum_feed.dart';
import 'profile_screen.dart';
import 'workout_screen.dart';
import 'analytics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fitness = context.watch<FitnessService>();
    final motivation = context.watch<MotivationService>();
    final health = context.watch<HealthService>();
    
    final score = fitness.getConsistencyScore();
    final state = fitness.getMomentumState();
    final nudges = motivation.getIdentityNudges(state);
    final suggestion = fitness.getAdaptiveSuggestion();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, fitness, health),
                const SizedBox(height: 32),
                _buildConsistencyMeter(context, score, state),
                const SizedBox(height: 40),
                _buildActivityHeatmap(context),
                const SizedBox(height: 40),
                const MomentumFeed(),
                const SizedBox(height: 40),
                _buildSectionHeader("ADAPTIVE COACHING"),
                const SizedBox(height: 16),
                _buildSuggestionCard(context, suggestion),
                const SizedBox(height: 40),
                _buildSectionHeader("IDENTITY NUDGES"),
                const SizedBox(height: 16),
                _buildNudgeStream(nudges),
                const SizedBox(height: 40),
                _buildSectionHeader("COMMUNITY MOMENTUM"),
                const SizedBox(height: 16),
                const LeaderboardWidget(),
                const SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FitnessService fitness, HealthService health) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FLEXFLOW",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                fontSize: 12,
              ),
            ),
            const Text(
              "Athlete Mode",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsScreen())),
              icon: const Icon(Icons.bar_chart, color: Colors.white54),
            ),
            IconButton(
              onPressed: health.isSyncing ? null : () => health.syncData(fitness),
              icon: Icon(
                health.isSyncing ? Icons.sync : Icons.cloud_download_outlined,
                color: health.isSyncing ? const Color(0xFFCCFF00) : Colors.white54,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
              child: const CircleAvatar(
                backgroundColor: Colors.white10,
                child: Icon(Icons.person_outline, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _showAiCoach(context),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.psychology, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAiCoach(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AiCoachSheet(),
    );
  }

  Widget _buildConsistencyMeter(BuildContext context, double score, String state) {
    return GlassContainer.frostedGlass(
      height: 180,
      width: double.infinity,
      borderRadius: BorderRadius.circular(32),
      borderWidth: 1,
      borderColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("7-DAY CONSISTENCY", style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 13)),
            const Spacer(),
            Row(
              children: [
                Text(
                  "${(score * 100).toInt()}%",
                  style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getMomentumColor(state).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.toUpperCase(),
                    style: TextStyle(color: _getMomentumColor(state), fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const Spacer(),
            LinearProgressIndicator(
              value: score,
              backgroundColor: Colors.white10,
              color: _getMomentumColor(state),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityHeatmap(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("YOUR MOMENTUM JOURNEY", style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 12)),
        SizedBox(height: 16),
        ActivityHeatmap(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 13, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, String suggestion) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutScreen(workoutTitle: suggestion))),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("LIVE SUGGESTION", style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1)),
                  Text(
                    suggestion,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNudgeStream(List<MotivationNudge> nudges) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: nudges.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => NudgeCard(nudge: nudges[index]),
      ),
    );
  }

  Color _getMomentumColor(String momentum) {
    switch (momentum) {
      case 'On Track': return const Color(0xFFCCFF00);
      case 'Slipping': return Colors.orangeAccent;
      case 'Off Track': return Colors.redAccent;
      default: return Colors.white;
    }
  }
}
