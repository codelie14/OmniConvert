import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

class DevUtilityConverter {
  static Future<bool> convertBase64(String sourcePath, bool isEncode) async {
    try {
      final file = File(sourcePath);
      final dir = file.parent.path;
      final fileName = p.basenameWithoutExtension(sourcePath);
      final outputPath = p.join(dir, '${fileName}_${isEncode ? "encoded" : "decoded"}.${isEncode ? "txt" : "bin"}');

      if (isEncode) {
        final bytes = await file.readAsBytes();
        final encoded = base64Encode(bytes);
        await File(outputPath).writeAsString(encoded);
      } else {
        final content = await file.readAsString();
        final decoded = base64Decode(content.trim());
        await File(outputPath).writeAsBytes(decoded);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getHash(String sourcePath, String hashType) async {
    try {
      final file = File(sourcePath);
      final bytes = await file.readAsBytes();

      if (hashType == 'md5') {
        return md5.convert(bytes).toString();
      } else if (hashType == 'sha256') {
        return sha256.convert(bytes).toString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
