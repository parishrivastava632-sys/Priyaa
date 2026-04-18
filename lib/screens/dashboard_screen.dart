import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glass_kit/glass_kit.dart';
import '../services/fitness_service.dart';
import '../services/motivation_service.dart';
import '../services/gamification_service.dart';
import '../services/health_service.dart';
import '../widgets/nudge_card.dart';
import '../widgets/ai_coach_sheet.dart';
import '../widgets/activity_heatmap.dart';
import '../widgets/leaderboard_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fitness = context.watch<FitnessService>();
    final motivation = context.watch<MotivationService>();
    final gamification = context.watch<GamificationService>();
    final health = context.watch<HealthService>();
    final score = fitness.getConsistencyScore();
    final momentum = fitness.getMomentumState();
    final isAtRisk = fitness.isAtRisk();

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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, gamification, health, fitness),
                const SizedBox(height: 32),
                if (isAtRisk) _buildRiskWarning(context),
                if (isAtRisk) const SizedBox(height: 16),
                _buildConsistencyTracker(context, score, momentum),
                const SizedBox(height: 32),
                _buildAdaptiveSuggestion(context, fitness.getAdaptiveSuggestion()),
                const SizedBox(height: 32),
                const ActivityHeatmap(),
                const SizedBox(height: 32),
                _buildBadgeSection(context, gamification.earnedBadges),
                const SizedBox(height: 32),
                const LeaderboardWidget(),
                const SizedBox(height: 32),
                Text(
                  "FOR YOUR IDENTITY",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white54,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                _buildNudgeStream(motivation.currentNudges),
                const SizedBox(height: 80), // Padding for FAB
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // Log workout action
        backgroundColor: const Color(0xFFCCFF00),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("LOG ACTIVITY", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GamificationService gamification, HealthService health, FitnessService fitness) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Level ${gamification.level}",
                  style: const TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  "• ${gamification.xp} XP",
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            Text(
              "FlexFlow",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: health.isSyncing ? null : () => health.syncData(fitness),
              icon: Icon(
                health.isSyncing ? Icons.sync : Icons.cloud_download_outlined,
                color: health.isSyncing ? const Color(0xFFCCFF00) : Colors.white54,
              ),
            ),
            GestureDetector(
              onTap: () => _showAiCoach(context),
              child: const CircleAvatar(
                backgroundColor: Color(0xFFCCFF00),
                child: Icon(Icons.psychology, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRiskWarning(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "MOMENTUM ALERT: Your consistency is dropping. A 2-min session will save your streak!",
              style: TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeSection(BuildContext context, List<Badge> badges) {
    if (badges.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EARNED BADGES",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white54,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: badges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => CircleAvatar(
              backgroundColor: badges[index].color.withOpacity(0.2),
              child: Icon(badges[index].icon, color: badges[index].color, size: 20),
            ),
          ),
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

  Widget _buildConsistencyTracker(BuildContext context, double score, String momentum) {
    return GlassContainer.clearGlass(
      height: 200,
      width: double.infinity,
      borderRadius: BorderRadius.circular(24),
      borderWidth: 1,
      borderColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Consistency Score",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${(score * 100).toInt()}%",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getMomentumColor(momentum).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      momentum.toUpperCase(),
                      style: TextStyle(
                        color: _getMomentumColor(momentum),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildCircularProgress(score),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularProgress(double score) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: score,
            strokeWidth: 10,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFCCFF00)),
          ),
          Center(
            child: Icon(
              Icons.bolt,
              size: 40,
              color: score > 0.5 ? const Color(0xFFCCFF00) : Colors.white30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveSuggestion(BuildContext context, String suggestion) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF38BDF8).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: Color(0xFF38BDF8)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              suggestion,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
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
