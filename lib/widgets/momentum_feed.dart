import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/momentum_service.dart';

class MomentumFeed extends StatelessWidget {
  const MomentumFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final momentum = context.watch<MomentumService>();
    final feed = momentum.feed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "MOMENTUM FEED",
          style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: feed.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, idx) => _buildFeedItem(context, feed[idx]),
        ),
      ],
    );
  }

  Widget _buildFeedItem(BuildContext context, MomentumEvent event) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: event.color.withOpacity(0.1),
            child: Icon(event.icon, color: event.color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                children: [
                  TextSpan(text: event.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  TextSpan(text: " ${event.action}"),
                ],
              ),
            ),
          ),
          Text(
             "${DateTime.now().difference(event.timestamp).inMinutes}m",
             style: const TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
