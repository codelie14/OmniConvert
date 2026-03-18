import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/enums/app_category.dart';
import '../providers/navigation_provider.dart';

class SidebarWidget extends ConsumerWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNav = ref.watch(navigationProvider);

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
          _buildNavItem(context, ref, Icons.home_rounded, 'Accueil', AppCategory.home, selectedNav == AppCategory.home),
          _buildNavItem(context, ref, Icons.image_rounded, 'Images', AppCategory.images, selectedNav == AppCategory.images),
          _buildNavItem(context, ref, Icons.videocam_rounded, 'Vidéos', AppCategory.videos, selectedNav == AppCategory.videos),
          _buildNavItem(context, ref, Icons.audiotrack_rounded, 'Audio', AppCategory.audio, selectedNav == AppCategory.audio),
          const Spacer(),
          _buildNavItem(context, ref, Icons.history_rounded, 'Historique', AppCategory.history, selectedNav == AppCategory.history),
          _buildNavItem(context, ref, Icons.settings_rounded, 'Paramètres', AppCategory.settings, selectedNav == AppCategory.settings),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, WidgetRef ref, IconData icon, String title, AppCategory category, bool isSelected) {
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
          ref.read(navigationProvider.notifier).state = category;
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
