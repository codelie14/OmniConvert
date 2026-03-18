import 'dart:convert';
import 'dart:io';
import 'package:json2yaml/json2yaml.dart';
import 'package:csv/csv.dart';
import 'package:xml/xml.dart';
import 'package:path/path.dart' as p;

class DataConverter {
  static Future<bool> convertJson(String sourcePath, String targetFormat) async {
    try {
      final input = await File(sourcePath).readAsString();
      final dynamic data = jsonDecode(input);
      final dir = File(sourcePath).parent.path;
      final fileName = p.basenameWithoutExtension(sourcePath);
      final outputPath = p.join(dir, '${fileName}_converted.$targetFormat');

      String output = '';
      if (targetFormat == 'yaml') {
        output = json2yaml(data);
      } else if (targetFormat == 'csv') {
        output = _toCsv(data);
      } else if (targetFormat == 'xml') {
        output = _toXml(data);
      }

      await File(outputPath).writeAsString(output);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String _toCsv(dynamic data) {
    if (data is! List) return '';
    List<List<dynamic>> rows = [];
    if (data.isNotEmpty && data.first is Map) {
      rows.add((data.first as Map).keys.toList());
      for (var item in data) {
        rows.add((item as Map).values.toList());
      }
    }
    return const ListToCsvConverter().convert(rows);
  }

  static String _toXml(dynamic data) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('root', nest: () {
      if (data is Map) {
        data.forEach((key, value) {
          builder.element(key.toString(), nest: value.toString());
        });
      }
    });
    return builder.buildDocument().toXmlString(pretty: true);
  }
}
