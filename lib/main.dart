import 'package:flutter/material.dart';
import 'package:samudera/presentation/dev/widget_showcase.dart';
import 'package:samudera/presentation/theme/app_theme.dart';

import './core/config/env_config.dart';

Future<void> main() async {
  await EnvConfig.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: WidgetShowcaseScreen(),
    );
  }
}
