import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/system_utils.dart';
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
  bool _isFfmpegAvailable = true;

  @override
  void initState() {
    super.initState();
    _checkFfmpeg();
  }

  Future<void> _checkFfmpeg() async {
    final available = await SystemUtils.isFfmpegAvailable();
    if (mounted) {
      setState(() {
        _isFfmpegAvailable = available;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.surfaceDark,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Convert Files',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppConstants.textMain,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (!_isFfmpegAvailable)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 16),
                      const SizedBox(width: 8),
                      const Text(
                        'FFmpeg non détecté',
                        style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Glissez-déposez vos fichiers images, audio ou vidéo ici.',
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
                  final success = await ref.read(selectedFileProvider.notifier).setFile(files.first.path);
                  if (!success && mounted) {
                    _showErrorSnackBar('Format de fichier non supporté ou invalide.');
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: _isDragging ? AppConstants.primaryBlue.withOpacity(0.1) : AppConstants.backgroundPrimary,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _isDragging ? AppConstants.primaryBlue : AppConstants.surfaceDark.withOpacity(0.5),
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
                        color: _isDragging ? AppConstants.primaryBlue : AppConstants.textSecondary.withOpacity(0.5),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Déposez vos fichiers ici',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: _isDragging ? AppConstants.primaryBlue : AppConstants.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'ou',
                        style: TextStyle(color: AppConstants.textSecondary.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                           FilePickerResult? result = await FilePicker.platform.pickFiles(
                             allowMultiple: false,
                           );
                           if (result != null && result.files.isNotEmpty) {
                              final path = result.files.first.path;
                              if (path != null) {
                                final success = await ref.read(selectedFileProvider.notifier).setFile(path);
                                if (!success && mounted) {
                                  _showErrorSnackBar('Format de fichier non supporté ou invalide.');
                                }
                              }
                           }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Parcourir les fichiers'),
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
