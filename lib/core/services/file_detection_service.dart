import 'dart:io';
import 'package:mime/mime.dart';
import '../constants/supported_formats.dart';

class FileDetectionService {
  static Future<FileDetectionResult> analyzeFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      return FileDetectionResult(isValid: false, errorMessage: 'File not found');
    }

    final String extension = filePath.split('.').last.toLowerCase();
    final String? mimeType = lookupMimeType(filePath);

    // Get basic stats
    final int sizeBytes = await file.length();
    
    // Check if format is supported
    final String? category = SupportedFormats.getCategoryForExtension(extension);
    final bool isValid = category != null;

    return FileDetectionResult(
      filePath: filePath,
      fileName: filePath.split(Platform.pathSeparator).last,
      extension: extension,
      mimeType: mimeType ?? 'unknown',
      sizeBytes: sizeBytes,
      category: category,
      isValid: isValid,
      errorMessage: isValid ? null : 'Unsupported format: $extension',
    );
  }
}

class FileDetectionResult {
  final String filePath;
  final String fileName;
  final String extension;
  final String mimeType;
  final int sizeBytes;
  final String? category;
  final bool isValid;
  final String? errorMessage;

  FileDetectionResult({
    this.filePath = '',
    this.fileName = '',
    this.extension = '',
    this.mimeType = '',
    this.sizeBytes = 0,
    this.category,
    required this.isValid,
    this.errorMessage,
  });
}
