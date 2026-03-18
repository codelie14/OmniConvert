import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/sidebar_widget.dart';
import '../widgets/main_area_widget.dart';
import '../widgets/preview_panel_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: const Center(
              child: Text('Debug Layout Pass', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
