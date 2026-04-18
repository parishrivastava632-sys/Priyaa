import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gamification_service.dart';
import '../models/identity_goal.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gamification = context.watch<GamificationService>();
    
    // Mocking an identity goal for the profile
    final identity = IdentityGoal(
      type: IdentityType.athlete,
      nickname: "The Consistent Warrior",
      coreMantra: "Never Miss Twice",
      startedAt: DateTime.now().subtract(const Duration(days: 14)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Your Identity", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProfileHeader(context, identity, gamification),
            const SizedBox(height: 40),
            _buildIdentityCard(context, identity),
            const SizedBox(height: 32),
            _buildAchievements(context, gamification.earnedBadges),
            const SizedBox(height: 40),
            _buildSettingsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, IdentityGoal identity, GamificationService gamification) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          child: Icon(Icons.person, size: 50, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 16),
        Text(
          identity.nickname,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          "Level ${gamification.level} Athlete",
          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildIdentityCard(BuildContext context, IdentityGoal identity) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("CORE IDENTITY", style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 12)),
          const SizedBox(height: 12),
          Text(
            identity.identityStatement,
            style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.4, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          _buildDetailRow("Mantra", identity.coreMantra),
          _buildDetailRow("Since", "April 2026"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38)),
          Text(value, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAchievements(BuildContext context, List<dynamic> badges) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("LIFETIME ACHIEVEMENTS", style: TextStyle(color: Colors.white54, letterSpacing: 2, fontSize: 12)),
        const SizedBox(height: 16),
        Container(
          height: 100,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: badges.isEmpty 
            ? const Center(child: Text("Keep being consistent to earn your first badge!", style: TextStyle(color: Colors.white24)))
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: badges.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, idx) => Column(
                  children: [
                    CircleAvatar(backgroundColor: badges[idx].color.withOpacity(0.2), child: Icon(badges[idx].icon, color: badges[idx].color)),
                    const SizedBox(height: 4),
                    Text(badges[idx].name, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildSettingsItem(Icons.notifications_active_outlined, "Nudge Reminders", "7:00 PM"),
        _buildSettingsItem(Icons.lock_outline, "Privacy & Social", ""),
        _buildSettingsItem(Icons.logout, "Reset My Morning Identity", ""),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.white38),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      trailing: Text(trailing, style: const TextStyle(color: Colors.white38)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
