import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/archetype_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  final List<int> _scores = [0, 0, 0, 0]; // Index maps to Archetype enum

  final List<QuizQuestion> _questions = [
    QuizQuestion(
      text: "How do you handle a missed workout session?",
      options: [
        QuizOption("I feel guilty and try to double up tomorrow.", 1), // Phoenix
        QuizOption("I accept it as part of the slow journey.", 2), // Mountain
        QuizOption("I immediately schedule a 2-min session to keep the streak.", 0), // Wolf
        QuizOption("I'll just wait for my next high-energy burst.", 3), // Cheetah
      ],
    ),
    QuizQuestion(
      text: "What motivates you most to stay consistent?",
      options: [
        QuizOption("The quiet satisfaction of self-discipline.", 0), // Wolf
        QuizOption("Seeing visible progress over years, not weeks.", 2), // Mountain
        QuizOption("The thrill of hitting high-intensity goals.", 3), // Cheetah
        QuizOption("The ability to overcome any obstacle.", 1), // Phoenix
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Consistency Quiz", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
              backgroundColor: Colors.white10,
              color: const Color(0xFFCCFF00),
            ),
            const SizedBox(height: 60),
            Text(
              _questions[_currentQuestion].text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            ..._questions[_currentQuestion].options.map((opt) => _buildOption(opt)),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(QuizOption opt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _handleAnswer(opt.valueIndex),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(opt.text, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ),
      ),
    );
  }

  void _handleAnswer(int index) {
    _scores[index]++;
    if (_currentQuestion < _questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    int maxIdx = 0;
    for (int i = 1; i < _scores.length; i++) {
      if (_scores[i] > _scores[maxIdx]) maxIdx = i;
    }
    
    final archetype = Archetype.values[maxIdx];
    context.read<ArchetypeService>().assignArchetype(archetype);
    
    _showResultDialog(context.read<ArchetypeService>().archetypes[archetype]!);
  }

  void _showResultDialog(ArchetypeModel model) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(model.name, style: TextStyle(color: model.color, fontWeight: FontWeight.bold)),
        content: Text(model.description, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return
            },
            child: const Text("EMBRACE IDENTITY", style: TextStyle(color: Color(0xFFCCFF00))),
          ),
        ],
      ),
    );
  }
}

class QuizQuestion {
  final String text;
  final List<QuizOption> options;
  QuizQuestion({required this.text, required this.options});
}

class QuizOption {
  final String text;
  final int valueIndex;
  QuizOption(this.text, this.valueIndex);
}
