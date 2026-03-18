import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/enums/app_category.dart';

final navigationProvider = StateProvider<AppCategory>((ref) => AppCategory.home);
