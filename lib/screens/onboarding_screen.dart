import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Define Your Identity",
      description: "Consistency isn't about what you do, it's about who you ARE. Become the athlete.",
      icon: Icons.fingerprint,
      color: const Color(0xFFCCFF00),
    ),
    OnboardingData(
      title: "Never Miss Twice",
      description: "The secret to elite streaks? If you miss a day, never miss the second. Guard your momentum.",
      icon: Icons.shield_rounded,
      color: Colors.blueAccent,
    ),
    OnboardingData(
      title: "AI Wisdom",
      description: "Our contextual coach pivots your goals based on your fatigue, mood, and consistency.",
      icon: Icons.psychology,
      color: Colors.purpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            itemCount: _pages.length,
            itemBuilder: (context, idx) => _buildPage(_pages[idx]),
          ),
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDots(),
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 120, color: data.color),
          const SizedBox(height: 60),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      children: List.generate(
        _pages.length,
        (idx) => Container(
          margin: const EdgeInsets.only(right: 8),
          width: _currentPage == idx ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == idx ? const Color(0xFFCCFF00) : Colors.white24,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      closedElevation: 0,
      closedColor: const Color(0xFFCCFF00),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      closedBuilder: (context, action) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Text(
          _currentPage == _pages.length - 1 ? "GET STARTED" : "NEXT",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      openBuilder: (context, action) => const DashboardScreen(),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({required this.title, required this.description, required this.icon, required this.color});
}
