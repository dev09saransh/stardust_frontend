import 'package:flutter/material.dart';
import '../../widgets/stardust_background.dart';
import '../../widgets/glass_card.dart';
import '../../theme.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const SettingsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StardustBackground(
        child: SafeArea(
          child: Column(
            children: [
              _header(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _sectionHeader(context, 'Profile'),
                    _settingsTile(context, Icons.person_outline_rounded, 'Account Details', 'Guest User'),
                    _settingsTile(context, Icons.alternate_email_rounded, 'Email Address', 'guest@example.com'),
                    const SizedBox(height: 24),
                    _sectionHeader(context, 'Security'),
                    _settingsTile(context, Icons.fingerprint_rounded, 'Biometric Lock', 'Enabled', toggle: true),
                    _settingsTile(context, Icons.verified_user_rounded, 'Two-Factor Auth', 'Enabled'),
                    _settingsTile(context, Icons.key_rounded, 'Change Password', ''),
                    const SizedBox(height: 24),
                    _sectionHeader(context, 'Preferences'),
                    _settingsTile(context, Icons.notifications_none_rounded, 'Notifications', 'On', toggle: true),
                    _settingsTile(context, Icons.language_rounded, 'Language', 'English'),
                    const SizedBox(height: 32),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/auth'),
                      child: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).colorScheme.onSurfaceVariant),
            onPressed: onBack ?? () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text('Settings',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1)),
    );
  }

  Widget _settingsTile(BuildContext context, IconData icon, String title, String value, {bool toggle = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w400)),
            ),
            if (toggle)
              Switch(value: true, onChanged: (_) {}, activeThumbImage: null, activeColor: Theme.of(context).colorScheme.primary)
            else if (value.isNotEmpty)
              Text(value,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.6))),
            if (!toggle) const SizedBox(width: 8),
            if (!toggle)
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}
