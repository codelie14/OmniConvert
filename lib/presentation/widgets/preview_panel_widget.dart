import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/supported_formats.dart';
import '../../../../core/enums/app_category.dart';
import '../../../features/converter/providers/selected_file_provider.dart';
import '../../../features/converter/providers/conversion_state_provider.dart';
import '../../../../core/services/converter_orchestrator.dart';
import '../../../../core/utils/file_utils.dart';

class PreviewPanelWidget extends ConsumerWidget {
  const PreviewPanelWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFile = ref.watch(selectedFileProvider);

    return Container(
      width: AppConstants.previewPanelWidth,
      color: AppConstants.backgroundPrimary,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Settings & Preview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppConstants.textMain,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          
          if (selectedFile == null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings_suggest_rounded,
                    size: 64,
                    color: AppConstants.textSecondary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select a file to configure conversion options',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppConstants.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // File Info Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppConstants.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getIconForCategory(selectedFile.category),
                              color: AppConstants.primaryBlue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                selectedFile.fileName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow('Type:', selectedFile.extension.toUpperCase()),
                        const SizedBox(height: 4),
                        _buildInfoRow('Size:', FileUtils.formatBytes(selectedFile.sizeBytes)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'Target Format',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.surfaceDark),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select a format'),
                        value: ref.watch(targetFormatProvider),
                        dropdownColor: AppConstants.surfaceDark,
                        icon: const Icon(Icons.arrow_drop_down, color: AppConstants.primaryCyan),
                        items: (SupportedFormats.conversionMap[selectedFile.category] ?? [])
                            .where((ext) => ext != selectedFile.extension.toLowerCase())
                            .map((String format) {
                          return DropdownMenuItem<String>(
                            value: format,
                            child: Text(format.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          ref.read(targetFormatProvider.notifier).state = newValue;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, child) {
              final isConverting = ref.watch(isConvertingProvider);
              final targetFormat = ref.watch(targetFormatProvider);
              
              return ElevatedButton(
                onPressed: (selectedFile != null && targetFormat != null && !isConverting) ? () async {
                  ref.read(isConvertingProvider.notifier).state = true;
                  
                  bool success = await ConverterOrchestrator.convert(
                    selectedFile.filePath,
                    selectedFile.category!,
                    targetFormat
                  );
                  
                  ref.read(isConvertingProvider.notifier).state = false;
                  
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success ? 'Converted successfully!' : 'Conversion failed.'),
                        backgroundColor: success ? AppConstants.accentGreen : Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryCyan,
                  disabledBackgroundColor: AppConstants.surfaceDark,
                  disabledForegroundColor: AppConstants.textSecondary.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isConverting ? const SizedBox(
                  width: 24, height: 24, 
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                ) : const Text(
                  'Convert',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppConstants.textSecondary)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  IconData _getIconForCategory(AppCategory? category) {
    switch (category) {
      case AppCategory.images:
        return Icons.image;
      case AppCategory.videos:
        return Icons.movie;
      case AppCategory.audio:
        return Icons.audiotrack;
      case AppCategory.documents:
        return Icons.description;
      case AppCategory.dev:
        return Icons.code;
      default:
        return Icons.insert_drive_file;
    }
  }
}
