import 'package:flutter/foundation.dart';
import 'package:process_run/shell.dart';
import 'dart:io';

class NotificationService {
  static Future<void> showNotification(String title, String message) async {
    try {
      if (!kIsWeb && Platform.isWindows) {
         // Windows specific notification logic (MVP: simple debug print)
      }
      debugPrint('Notification: $title - $message');
    } catch (e) {
      debugPrint('Notification error: $e');
    }
  }
}
