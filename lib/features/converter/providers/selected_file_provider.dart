import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/file_detection_service.dart';

final selectedFileProvider = StateNotifierProvider<SelectedFileNotifier, FileDetectionResult?>((ref) {
  return SelectedFileNotifier();
});

class SelectedFileNotifier extends StateNotifier<FileDetectionResult?> {
  SelectedFileNotifier() : super(null);

  Future<void> setFile(String filePath) async {
    final result = await FileDetectionService.analyzeFile(filePath);
    if (result.isValid) {
      state = result;
    } else {
      // TODO: Handle invalid file error (e.g. show snackbar)
      state = null;
    }
  }

  void clearFile() {
    state = null;
  }
}
