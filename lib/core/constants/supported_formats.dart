class SupportedFormats {
  static const Map<String, List<String>> conversionMap = {
    'Image': ['jpg', 'jpeg', 'png', 'webp', 'bmp', 'avif', 'ico'],
    'Video': ['mp4', 'mkv', 'avi', 'mov', 'webm'],
    'Audio': ['mp3', 'wav', 'aac', 'ogg', 'flac'],
  };

  static List<String> getAllExtensions() {
    return conversionMap.values.expand((e) => e).toList();
  }

  static String? getCategoryForExtension(String extension) {
    String ext = extension.toLowerCase().replaceAll('.', '');
    for (var entry in conversionMap.entries) {
      if (entry.value.contains(ext)) {
        return entry.key;
      }
    }
    return null;
  }
}
