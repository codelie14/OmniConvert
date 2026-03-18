import 'package:flutter/foundation.dart';
import '../../features/converter/image/image_converter.dart';
import '../../features/converter/media/media_converter.dart';
import '../../features/converter/document/document_converter.dart';
import '../../features/converter/dev/data_converter.dart';
import '../../features/converter/dev/dev_utility_converter.dart';
import '../enums/app_category.dart';
import 'history_service.dart';
import 'notification_service.dart';
import 'package:path/path.dart' as p;

class ConverterOrchestrator {
  static Future<bool> convert(String sourcePath, AppCategory category, String targetFormat) async {
    bool success = false;

    try {
      switch (category) {
        case AppCategory.images:
          success = await ImageConverter.convertImage(sourcePath, targetFormat);
          break;
        case AppCategory.videos:
        case AppCategory.audio:
          success = await MediaConverter.convertMedia(sourcePath, targetFormat);
          break;
        case AppCategory.documents:
          if (sourcePath.endsWith('.md')) {
            success = await DocumentConverter.convertMarkdown(sourcePath, targetFormat);
          } else if (sourcePath.endsWith('.txt') && targetFormat == 'pdf') {
            success = await DocumentConverter.convertTxtToPdf(sourcePath);
          }
          break;
        case AppCategory.dev:
          if (targetFormat == 'base64') {
             success = await DevUtilityConverter.convertBase64(sourcePath, true);
          } else {
             success = await DataConverter.convertJson(sourcePath, targetFormat);
          }
          break;
        default:
          debugPrint('No converter for category: $category');
      }

      // Add to history
      await HistoryService.addRecord({
        'fileName': p.basename(sourcePath),
        'sourceFormat': p.extension(sourcePath).replaceAll('.', ''),
        'targetFormat': targetFormat,
        'timestamp': DateTime.now().toIso8601String(),
        'status': success ? 'success' : 'failed',
        'filePath': sourcePath,
      });

      if (success) {
        await NotificationService.showNotification('Conversion terminée', 'Le fichier a été converti en $targetFormat');
      }

      return success;
    } catch (e) {
      debugPrint('Orchestrator error: $e');
      return false;
    }
  }
}
