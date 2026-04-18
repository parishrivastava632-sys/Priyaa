import 'package:flutter/material.dart';

class ActivityHeatmap extends StatelessWidget {
  const ActivityHeatmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ACTIVITY HEATMAP",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white54,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) => _buildDayLabel(index)),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: List.generate(28, (index) => _buildHeatBox(index)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDayLabel(int index) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Text(
      days[index],
      style: const TextStyle(color: Colors.white38, fontSize: 10),
    );
  }

  Widget _buildHeatBox(int index) {
    // Mocking intensity for the heatmap
    final intensity = (index % 4) / 4.0;
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFFCCFF00).withOpacity(intensity + 0.05),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
