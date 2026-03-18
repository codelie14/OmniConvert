import 'package:flutter_riverpod/flutter_riverpod.dart';

final targetFormatProvider = StateProvider<String?>((ref) => null);

final isConvertingProvider = StateProvider<bool>((ref) => false);
