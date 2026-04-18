import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/fitness_service.dart';

class AiCoachSheet extends StatelessWidget {
  const AiCoachSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final fitness = context.read<FitnessService>();
    final state = fitness.getMomentumState();
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFCCFF00),
                child: Icon(Icons.psychology, color: Colors.black),
              ),
              const SizedBox(width: 16),
              Text(
                "Flex AI Coach",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildCoachBubble(_getCoachResponse(state)),
          const SizedBox(height: 16),
          _buildOption(context, "How do I level up faster?"),
          _buildOption(context, "Give me a 5-min routine."),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCoachBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
