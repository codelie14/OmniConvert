import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'OmniConvert';
  static const String appVersion = '1.0.0';

  // UI Constants
  static const double sidebarWidth = 250.0;
  static const double previewPanelWidth = 300.0;
  static const double minimumWindowWidth = 900.0;
  static const double minimumWindowHeight = 600.0;
  
  // Custom Colors
  static const Color backgroundPrimary = Color(0xFF0F172A);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color textMain = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE5E7EB);

  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentYellow = Color(0xFFFACC15);
  static const Color accentPurple = Color(0xFFA855F7);
  
  // Computed theme colors based on palette
  static const Color surfaceDark = Color(0xFF1E293B); // Slightly lighter than backgroundPrimary
}
