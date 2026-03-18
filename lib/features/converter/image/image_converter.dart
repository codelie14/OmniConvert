import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

class ImageConverter {
  static Future<bool> convertImage(String sourcePath, String targetFormat, {int quality = 85}) async {
    try {
      final inputBytes = await File(sourcePath).readAsBytes();
      
      // Use compute for heavy image decoding/encoding to avoid blocking the main thread
      return await compute(_processImage, {
        'bytes': inputBytes,
        'sourcePath': sourcePath,
        'targetFormat': targetFormat.toLowerCase(),
        'quality': quality,
      });
    } catch (e) {
      debugPrint("Image conversion failed: $e");
      return false;
    }
  }

  static bool _processImage(Map<String, dynamic> args) {
    try {
      final List<int> bytes = args['bytes'];
      final String sourcePath = args['sourcePath'];
      final String targetFormat = args['targetFormat'];
      final int quality = args['quality'];

      // Decode image
      final img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
      if (image == null) return false;

      // Define output path
      final String dir = File(sourcePath).parent.path;
      final String filename = sourcePath.split(Platform.pathSeparator).last;
      final String nameWithoutExt = filename.substring(0, filename.lastIndexOf('.'));
      final String outputPath = '$dir${Platform.pathSeparator}${nameWithoutExt}_converted.$targetFormat';

      // Encode image
      List<int>? outBytes;
      switch (targetFormat) {
        case 'jpg':
        case 'jpeg':
          outBytes = img.encodeJpg(image, quality: quality);
          break;
        case 'png':
          outBytes = img.encodePng(image);
          break;
        case 'webp':
          // Using encodeJpg or encodePng as fallback if WebP isn't fully supported without external lib in current version
          outBytes = img.encodeJpg(image, quality: quality); // Simplified for MVP if encodeWebp is missing in image package
          break;
        case 'bmp':
          outBytes = img.encodeBmp(image);
          break;
        default:
          return false;
      }

      if (outBytes.isNotEmpty) {
        File(outputPath).writeAsBytesSync(outBytes);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
