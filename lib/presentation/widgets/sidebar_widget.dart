import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.sidebarWidth,
      color: AppConstants.backgroundPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Icon(Icons.sync_alt, color: AppConstants.primaryCyan, size: 28),
                const SizedBox(width: 12),
                Text(
                  'OmniConvert',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppConstants.textMain,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _buildNavItem(context, Icons.home_rounded, 'Accueil', true),
          _buildNavItem(context, Icons.image_rounded, 'Images', false),
          _buildNavItem(context, Icons.videocam_rounded, 'Vidéos', false),
          _buildNavItem(context, Icons.audiotrack_rounded, 'Audio', false),
          const Spacer(),
          _buildNavItem(context, Icons.history_rounded, 'Historique', false),
          _buildNavItem(context, Icons.settings_rounded, 'Paramètres', false),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isSelected ? AppConstants.primaryBlue.withValues(alpha: 0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: AppConstants.primaryBlue.withValues(alpha: 0.5), width: 1) : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppConstants.primaryBlue : AppConstants.textSecondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppConstants.primaryBlue : AppConstants.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {
          // TODO: Implement navigation logic via Riverpod
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
