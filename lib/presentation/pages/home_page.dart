import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import '../../core/constants/app_constants.dart';
import '../../core/enums/app_category.dart';
import '../providers/navigation_provider.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/main_area_widget.dart';
import '../widgets/preview_panel_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNav = ref.watch(navigationProvider);

    return Scaffold(
      body: Column(
        children: [
          // Custom Window Title Bar
          Container(
            height: 32,
            color: AppConstants.backgroundPrimary,
            child: const Row(
              children: [
                Expanded(child: DragToMoveArea(child: SizedBox.expand())),
                WindowCaption(
                  brightness: Brightness.dark,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
          // App Content
          Expanded(
            child: Row(
              children: [
                const SidebarWidget(),
                Expanded(
                  child: _buildContentArea(selectedNav),
                ),
                if (selectedNav != AppCategory.history && selectedNav != AppCategory.settings)
                  const PreviewPanelWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentArea(AppCategory category) {
    switch (category) {
      case AppCategory.home:
      case AppCategory.images:
      case AppCategory.videos:
      case AppCategory.audio:
        return const MainAreaWidget();
      case AppCategory.history:
        return const Center(child: Text('Historique (Prochainement)', style: TextStyle(color: Colors.white)));
      case AppCategory.settings:
        return const Center(child: Text('Paramètres (Prochainement)', style: TextStyle(color: Colors.white)));
    }
  }
}
