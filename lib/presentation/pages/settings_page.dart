import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/settings_service.dart';
import '../../core/services/theme_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppConstants.surfaceDark,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Paramètres',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppConstants.textMain,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 40),
          _buildSettingSection('Apparence', [
            _buildSettingTile(
              context,
              'Mode Sombre',
              'Activez pour reposer vos yeux.',
              Switch(
                value: SettingsService.isDarkMode(),
                onChanged: (val) {
                  ThemeService().toggleTheme();
                },
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSettingSection('Langue', [
            _buildSettingTile(
              context,
              'Langue de l\'application',
              'Choisissez votre langue préférée.',
              DropdownButton<String>(
                value: SettingsService.getLanguage(),
                dropdownColor: AppConstants.surfaceDark,
                items: [
                  const DropdownMenuItem(value: 'fr', child: Text('Français', style: TextStyle(color: Colors.white))),
                  const DropdownMenuItem(value: 'en', child: Text('English', style: TextStyle(color: Colors.white))),
                  const DropdownMenuItem(value: 'es', child: Text('Español', style: TextStyle(color: Colors.white))),
                ],
                onChanged: (val) async {
                  if (val != null) {
                    await SettingsService.setLanguage(val);
                  }
                },
              ),
            ),
          ]),
          const Spacer(),
          Center(
            child: Text(
              'OmniConvert v${AppConstants.appVersion}\n© 2026 IndraLabs',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppConstants.textSecondary.withOpacity(0.5), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: AppConstants.primaryCyan, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildSettingTile(BuildContext context, String title, String subtitle, Widget trailing) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppConstants.backgroundPrimary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(subtitle, style: TextStyle(color: AppConstants.textSecondary.withOpacity(0.7), fontSize: 12)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
