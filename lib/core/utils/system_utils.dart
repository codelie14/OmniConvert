import 'package:process_run/shell.dart';

class SystemUtils {
  static Future<bool> isFfmpegAvailable() async {
    try {
      final shell = Shell();
      final results = await shell.run('ffmpeg -version');
      return results.isNotEmpty && results.first.exitCode == 0;
    } catch (e) {
      return false;
    }
  }
}
