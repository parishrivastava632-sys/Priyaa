import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../services/fitness_service.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fitness = context.watch<FitnessService>();
    final score = fitness.getConsistencyScore();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Consistency Trends", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsHeader(score),
            const SizedBox(height: 40),
            Text(
              "7-DAY TREND",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white54,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 250,
              child: _buildTrendChart(),
            ),
            const SizedBox(height: 40),
            _buildInsightCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader(double score) {
    return Row(
      children: [
        _buildStatItem("Current Streak", "12 Days", const Color(0xFFCCFF00)),
        const SizedBox(width: 24),
        _buildStatItem("Avg Intensity", "7.4", Colors.blueAccent),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTrendChart() {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: const Color(0xFFCCFF00),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFCCFF00).withOpacity(0.1),
            ),
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 3.5),
              FlSpot(3, 5),
              FlSpot(4, 4.5),
              FlSpot(5, 6),
              FlSpot(6, 5.5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFFCCFF00), size: 18),
              SizedBox(width: 12),
              Text("SMART INSIGHT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Your consistency is 15% higher during morning sessions. Consider shifting your target time to 8:00 AM to maintain your athlete identity.",
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }
}
