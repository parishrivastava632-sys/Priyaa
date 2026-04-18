import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/fitness_service.dart';

class AiCoachSheet extends StatelessWidget {
  const AiCoachSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final fitness = context.watch<FitnessService>();
    final state = fitness.getMomentumState();
    final advice = _getCoachResponse(state);
    
    // Mocking AI memory
    final List<String> memory = [
      "Yesterday: You felt highly motivated.",
      "2 days ago: You hit a 3-day recovery streak.",
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandle(),
          const SizedBox(height: 24),
          const Row(
            children: [
              Icon(Icons.psychology, color: Color(0xFFCCFF00)),
              SizedBox(width: 12),
              Text("AI COACH", style: TextStyle(color: Color(0xFFCCFF00), fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            advice,
            style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.6, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 32),
          const Text("AI MEMORY RECALL", style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 12)),
          const SizedBox(height: 16),
          ...memory.map((m) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("• $m", style: const TextStyle(color: Colors.white38, fontSize: 14)),
          )),
          const SizedBox(height: 40),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildCoachAction("Analyze my trends", Icons.analytics_outlined),
        const SizedBox(height: 12),
        _buildCoachAction("Adjust my current goal", Icons.tune),
      ],
    );
  }

  Widget _buildCoachAction(String text, IconData icon) {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(color: Colors.white60)),
            const Icon(Icons.chevron_right, size: 16, color: Colors.white30),
          ],
        ),
      ),
    );
  }

  String _getCoachResponse(String state) {
    if (state == 'On Track') {
      return "You're in the elite flow right now. The best way to keep this identity is to diversify. Have you tried a high-intensity stretch session to aid recovery?";
    } else if (state == 'Slipping') {
      return "I notice the momentum is cooling down. Remember: a 5-minute session today is 100% better than a 0-minute session. What's the smallest step you can take right now?";
    } else {
      return "Let's throw away the guilt. Today is Day 1 again. We focus on just one activity to get the engine running. Ready?";
    }
  }
}
