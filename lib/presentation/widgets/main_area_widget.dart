import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import '../../../features/converter/providers/selected_file_provider.dart';

class MainAreaWidget extends ConsumerStatefulWidget {
  const MainAreaWidget({super.key});

  @override
  ConsumerState<MainAreaWidget> createState() => _MainAreaWidgetState();
}

class _MainAreaWidgetState extends ConsumerState<MainAreaWidget> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.surfaceDark,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Convert Files',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppConstants.textMain,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag and drop your images, audio, or video files here.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppConstants.textSecondary,
                ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: DropTarget(
              onDragEntered: (details) {
                setState(() {
                  _isDragging = true;
                });
              },
              onDragExited: (details) {
                setState(() {
                  _isDragging = false;
                });
              },
              onDragDone: (details) async {
                setState(() {
                  _isDragging = false;
                });
                
                final files = details.files;
                if (files.isNotEmpty) {
                  // Wait for the provider to process the first file for MVP
                  await ref.read(selectedFileProvider.notifier).setFile(files.first.path);
                  debugPrint('Dropped ${files.length} files. Selected: ${files.first.path}');
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _isDragging ? AppConstants.primaryBlue.withValues(alpha: 0.1) : AppConstants.backgroundPrimary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isDragging ? AppConstants.primaryBlue : AppConstants.surfaceDark.withValues(alpha: 0.5),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_rounded,
                        size: 80,
                        color: _isDragging ? AppConstants.primaryBlue : AppConstants.textSecondary.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Drop files here',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: _isDragging ? AppConstants.primaryBlue : AppConstants.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'or',
                        style: TextStyle(color: AppConstants.textSecondary.withValues(alpha: 0.7)),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                           FilePickerResult? result = await FilePicker.platform.pickFiles(
                             allowMultiple: false, // Keep it simple for MVP selected file
                           );
                           if (result != null && result.files.isNotEmpty) {
                              final path = result.files.first.path;
                              if (path != null) {
                                await ref.read(selectedFileProvider.notifier).setFile(path);
                              }
                           }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Browse Files'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryBlue,
                          foregroundColor: AppConstants.textMain,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
