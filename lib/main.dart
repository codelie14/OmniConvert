import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'core/constants/app_constants.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1100, 700),
    minimumSize: Size(AppConstants.minimumWindowWidth, AppConstants.minimumWindowHeight),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    const ProviderScope(
      child: OmniConvertApp(),
    ),
  );
}

class OmniConvertApp extends StatelessWidget {
  const OmniConvertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppConstants.primaryBlue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppConstants.primaryBlue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppConstants.backgroundPrimary,
      ),
      themeMode: ThemeMode.dark, // Default to dark premium theme for MVP
      home: const HomePage(),
    );
  }
}
