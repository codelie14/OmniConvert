import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/file_detection_service.dart';

final selectedFileProvider = StateNotifierProvider<SelectedFileNotifier, FileDetectionResult?>((ref) {
  return SelectedFileNotifier();
});

class SelectedFileNotifier extends StateNotifier<FileDetectionResult?> {
  SelectedFileNotifier() : super(null);

  Future<bool> setFile(String filePath) async {
    final result = await FileDetectionService.analyzeFile(filePath);
    if (result.isValid) {
      state = result;
      return true;
    } else {
      state = null;
      return false;
    }
  }

  void clearFile() {
    state = null;
  }
}
