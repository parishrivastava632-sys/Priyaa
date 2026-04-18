enum IdentityType { athlete, warrior, yogi, runner, builder }

class IdentityGoal {
  final IdentityType type;
  final String nickname; // e.g., "The Morning Warrior"
  final String coreMantra; // e.g., "Never miss twice"
  final DateTime startedAt;

  IdentityGoal({
    required this.type,
    required this.nickname,
    required this.coreMantra,
    required this.startedAt,
  });

  String get identityStatement => "I am a ${type.name} who follows the path of $coreMantra.";
}
