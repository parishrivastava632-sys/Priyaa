import 'package:flutter/material.dart';
import '../services/motivation_service.dart';

class NudgeCard extends StatelessWidget {
  final MotivationNudge nudge;

  const NudgeCard({super.key, required this.nudge});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: nudge.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(nudge.icon, color: nudge.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  nudge.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            nudge.message,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
             "READ MORE →",
             style: TextStyle(
               color: nudge.color,
               fontWeight: FontWeight.bold,
               fontSize: 12,
               letterSpacing: 1.2,
             ),
          ),
        ],
      ),
    );
  }
}
