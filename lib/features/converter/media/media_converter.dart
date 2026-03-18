import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:process_run/shell.dart';

class MediaConverter {
  static Future<bool> convertMedia(String sourcePath, String targetFormat) async {
    try {
      final String dir = File(sourcePath).parent.path;
      final String filename = sourcePath.split(Platform.pathSeparator).last;
      final String nameWithoutExt = filename.substring(0, filename.lastIndexOf('.'));
      final String outputPath = '$dir${Platform.pathSeparator}${nameWithoutExt}_converted.$targetFormat';

      // Ensure ffmpeg is available in the system PATH
      var shell = Shell();
      
      // Basic FFmpeg command for conversion
      // -y overwrites output files without asking
      // -i is the input file
      final command = 'ffmpeg -y -i "$sourcePath" "$outputPath"';
      
      debugPrint('Running Command: $command');
      
      final results = await shell.run(command);
      
      if (results.isNotEmpty && results.first.exitCode == 0) {
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint("Media conversion failed: $e");
      return false;
    }
  }
}
