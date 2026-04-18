import 'package:flutter/material.dart';

enum Archetype { stoicWolf, dynamicPhoenix, steadyMountain, sprintCheetah }

class ArchetypeModel {
  final Archetype type;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  ArchetypeModel({
    required this.type,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class ArchetypeService with ChangeNotifier {
  ArchetypeModel? _userArchetype;

  ArchetypeModel? get userArchetype => _userArchetype;

  final Map<Archetype, ArchetypeModel> archetypes = {
    Archetype.stoicWolf: ArchetypeModel(
      type: Archetype.stoicWolf,
      name: "The Stoic Wolf",
      description: "You thrive on solitary discipline. Wind, rain, or fatigue—nothing breaks your pack of habits.",
      icon: Icons.brightness_3,
      color: Colors.blueGrey,
    ),
    Archetype.dynamicPhoenix: ArchetypeModel(
      type: Archetype.dynamicPhoenix,
      name: "The Dynamic Phoenix",
      description: "You excel at bouncing back. Even if you miss a day, you rise stronger the next morning.",
      icon: Icons.local_fire_department,
      color: Colors.orangeAccent,
    ),
    Archetype.steadyMountain: ArchetypeModel(
      type: Archetype.steadyMountain,
      name: "The Steady Mountain",
      description: "Unshakable and slow-building consistency. You value the long-term journey over short-term sprints.",
      icon: Icons.terrain,
      color: Colors.greenAccent,
    ),
    Archetype.sprintCheetah: ArchetypeModel(
      type: Archetype.sprintCheetah,
      name: "The Sprint Cheetah",
      description: "High intensity, high reward. You love explosive sessions and quick consistency wins.",
      icon: Icons.speed,
      color: const Color(0xFFCCFF00),
    ),
  };

  void assignArchetype(Archetype type) {
    _userArchetype = archetypes[type];
    notifyListeners();
  }
}
