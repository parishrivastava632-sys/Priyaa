import 'package:flutter/material.dart';
import 'dart:async';

class WorkoutScreen extends StatefulWidget {
  final String workoutTitle;
  const WorkoutScreen({super.key, required this.workoutTitle});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _seconds = 300; // 5 minute default
  Timer? _timer;
  bool _isActive = false;
  int _currentStep = 0;

  final List<String> _steps = ["Warm Up", "High Knees", "Plank Hold", "Push Ups", "Cool Down"];

  void _startTimer() {
    setState(() => _isActive = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
        if (_seconds % 60 == 0 && _currentStep < _steps.length - 1) {
          setState(() => _currentStep++);
        }
      } else {
        _timer?.cancel();
        _showCompleteDialog();
      }
    });
  }

  void _showCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Consistency Win! ⚡", style: TextStyle(color: Colors.white)),
        content: const Text("You just reinforced your athlete identity. XP earned: +50", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to dashboard
            },
            child: const Text("CONTINUE", style: TextStyle(color: Color(0xFFCCFF00))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "$mins:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const Spacer(),
            _buildTimerCircle(),
            const SizedBox(height: 60),
            _buildStepIndicator(),
            const Spacer(),
            _buildControlButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white54)),
          Text(widget.workoutTitle.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(width: 48), // Spacer
        ],
      ),
    );
  }

  Widget _buildTimerCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: CircularProgressIndicator(
            value: _seconds / 300,
            strokeWidth: 8,
            backgroundColor: Colors.white10,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Column(
          children: [
            Text(
              _formatTime(_seconds),
              style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const Text("REMAINING", style: TextStyle(color: Colors.white38, letterSpacing: 2)),
          ],
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Column(
      children: [
        Text(
          "NEXT: ${_steps[_currentStep]}",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text("Keep your flow steady and focused.", style: TextStyle(color: Colors.white38)),
      ],
    );
  }

  Widget _buildControlButtons() {
    return GestureDetector(
      onTap: _isActive ? null : _startTimer,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        decoration: BoxDecoration(
          color: _isActive ? Colors.white10 : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          _isActive ? "PUSHING LIMITS..." : "START SESSION",
          style: TextStyle(
            color: _isActive ? Colors.white24 : Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
