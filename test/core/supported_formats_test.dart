import 'package:flutter_test/flutter_test.dart';
import 'package:omniconvert/core/constants/supported_formats.dart';
import 'package:omniconvert/core/enums/app_category.dart';

void main() {
  test('SupportedFormats should return correct category for extension', () {
    expect(SupportedFormats.getCategoryForExtension('jpg'), AppCategory.images);
    expect(SupportedFormats.getCategoryForExtension('.png'), AppCategory.images);
    expect(SupportedFormats.getCategoryForExtension('mp4'), AppCategory.videos);
    expect(SupportedFormats.getCategoryForExtension('pdf'), AppCategory.documents);
    expect(SupportedFormats.getCategoryForExtension('json'), AppCategory.dev);
  });
}
