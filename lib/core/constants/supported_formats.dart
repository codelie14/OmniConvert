import '../enums/app_category.dart';

class SupportedFormats {
  static const Map<AppCategory, List<String>> conversionMap = {
    AppCategory.documents: ['pdf', 'docx', 'md', 'html', 'txt', 'epub'],
    AppCategory.images: ['jpg', 'jpeg', 'png', 'webp', 'bmp', 'avif', 'ico', 'svg', 'heic', 'gif'],
    AppCategory.videos: ['mp4', 'mkv', 'avi', 'mov', 'webm', 'gif'],
    AppCategory.audio: ['mp3', 'wav', 'aac', 'ogg', 'flac'],
    AppCategory.dev: ['json', 'yaml', 'csv', 'xml', 'env', 'sql', 'base64'],
  };

  static List<String> getAllExtensions() {
    return conversionMap.values.expand((e) => e).toList();
  }

  static AppCategory? getCategoryForExtension(String extension) {
    String ext = extension.toLowerCase().replaceAll('.', '');
    for (var entry in conversionMap.entries) {
      if (entry.value.contains(ext)) {
        return entry.key;
      }
    }
    return null;
  }
}
