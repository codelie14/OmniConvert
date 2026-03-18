import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as p;

class DocumentConverter {
  static Future<bool> convertMarkdown(String sourcePath, String targetFormat) async {
    try {
      final input = await File(sourcePath).readAsString();
      final dir = File(sourcePath).parent.path;
      final fileName = p.basenameWithoutExtension(sourcePath);
      final outputPath = p.join(dir, '${fileName}_converted.$targetFormat');

      if (targetFormat == 'html') {
        final html = md.markdownToHtml(input);
        await File(outputPath).writeAsString(html);
        return true;
      } else if (targetFormat == 'pdf') {
        final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(input),
              );
            },
          ),
        );
        final file = File(outputPath);
        await file.writeAsBytes(await pdf.save());
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Document conversion error: $e');
      return false;
    }
  }

  static Future<bool> convertTxtToPdf(String sourcePath) async {
    try {
      final input = await File(sourcePath).readAsString();
      final dir = File(sourcePath).parent.path;
      final fileName = p.basenameWithoutExtension(sourcePath);
      final outputPath = p.join(dir, '${fileName}_converted.pdf');

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Text(input);
          },
        ),
      );
      await File(outputPath).writeAsBytes(await pdf.save());
      return true;
    } catch (e) {
      return false;
    }
  }
}
