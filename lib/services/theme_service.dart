import 'package:flutter/material.dart';
import 'fitness_service.dart';

class ThemeService with ChangeNotifier {
  Color _primaryColor = const Color(0xFFCCFF00); // Default Cyber Lime
  
  Color get primaryColor => _primaryColor;

  void update(FitnessService fitness) {
    final state = fitness.getMomentumState();
    
    switch (state) {
      case 'On Track':
        _primaryColor = const Color(0xFFCCFF00); // Cyber Lime
        break;
      case 'Slipping':
        _primaryColor = Colors.orangeAccent;
        break;
      case 'Off Track':
        _primaryColor = Colors.redAccent;
        break;
      default:
        _primaryColor = const Color(0xFFCCFF00);
    }
    notifyListeners();
  }
}
