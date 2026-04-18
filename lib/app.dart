import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/onboarding_screen.dart';

class FlexFlowApp extends StatelessWidget {
  const FlexFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlexFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Deep Slate
        primaryColor: const Color(0xFFCCFF00), // Cyber Lime
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCCFF00),
          brightness: Brightness.dark,
          secondary: const Color(0xFF38BDF8), // Electric Blue
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme,
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
