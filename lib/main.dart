import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'services/fitness_service.dart';
import 'services/motivation_service.dart';
import 'services/gamification_service.dart';
import 'services/theme_service.dart';
import 'services/health_service.dart';
import 'services/community_service.dart';
import 'services/archetype_service.dart';
import 'services/momentum_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Firebase initialization would happen here in a real env
  // await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FitnessService()),
        ChangeNotifierProxyProvider<FitnessService, MotivationService>(
          create: (_) => MotivationService(),
          update: (_, fitness, motivation) => motivation!..update(fitness),
        ),
        ChangeNotifierProxyProvider<FitnessService, GamificationService>(
          create: (_) => GamificationService(),
          update: (_, fitness, gamification) => gamification!..update(fitness),
        ),
        ChangeNotifierProxyProvider<FitnessService, ThemeService>(
          create: (_) => ThemeService(),
          update: (_, fitness, theme) => theme!..update(fitness),
        ),
        ChangeNotifierProvider(create: (_) => HealthService()),
        ChangeNotifierProxyProvider<GamificationService, CommunityService>(
          create: (_) => CommunityService(),
          update: (_, gamification, community) => community!..updatePoints(gamification.xp),
        ),
        ChangeNotifierProvider(create: (_) => ArchetypeService()),
        ChangeNotifierProvider(create: (_) => MomentumService()),
      ],
      child: const FlexFlowApp(),
    ),
  );
}
